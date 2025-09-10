import 'package:edmentoresolve/features/shared/domain/entities/communication_message.dart';
import 'package:edmentoresolve/features/shared/domain/enums/communication_tab.dart';
import 'package:edmentoresolve/features/shared/domain/repositories/communication_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Shared communication cubit that works for all user roles
class CommunicationCubit extends Cubit<CommunicationState> {
  final ICommunicationRepository _repository;

  CommunicationCubit(this._repository) : super(const CommunicationState());

  /// Ensure messages are loaded for a specific tab
  Future<void> ensureLoaded(CommunicationTab tab) async {
    if (state.items[tab]?.isNotEmpty == true) return;
    await _loadMessages(tab);
  }

  /// Set the current tab
  void setTab(CommunicationTab tab) {
    emit(state.copyWith(currentTab: tab));
    ensureLoaded(tab);
  }

  /// Load messages for a specific tab
  Future<void> _loadMessages(CommunicationTab tab) async {
    emit(
      state.copyWith(
        isLoading: {...state.isLoading, tab: true},
        errors: {...state.errors, tab: null},
      ),
    );

    try {
      final messages = await _repository.getMessages(tab: tab);
      emit(
        state.copyWith(
          items: {...state.items, tab: messages},
          isLoading: {...state.isLoading, tab: false},
          errors: {...state.errors, tab: null},
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: {...state.isLoading, tab: false},
          errors: {...state.errors, tab: e.toString()},
        ),
      );
    }
  }

  /// Load more messages for a specific tab
  Future<void> loadMore(CommunicationTab tab) async {
    if (state.isLoadingMore[tab] == true) return;

    emit(state.copyWith(isLoadingMore: {...state.isLoadingMore, tab: true}));

    try {
      // TODO: Implement pagination
      final moreMessages = await _repository.getMessages(tab: tab);
      final currentMessages = state.items[tab] ?? [];
      emit(
        state.copyWith(
          items: {
            ...state.items,
            tab: [...currentMessages, ...moreMessages],
          },
          isLoadingMore: {...state.isLoadingMore, tab: false},
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isLoadingMore: {...state.isLoadingMore, tab: false},
          errors: {...state.errors, tab: e.toString()},
        ),
      );
    }
  }

  /// Refresh messages for a specific tab
  Future<void> refresh(CommunicationTab tab) async {
    emit(state.copyWith(items: {...state.items, tab: []}));
    await _loadMessages(tab);
  }

  /// Send a message
  Future<void> sendMessage(CommunicationMessage message) async {
    try {
      final sentMessage = await _repository.sendMessage(message);
      // Add to sent tab
      final sentMessages = state.items[CommunicationTab.sent] ?? [];
      emit(
        state.copyWith(
          items: {
            ...state.items,
            CommunicationTab.sent: [sentMessage, ...sentMessages],
          },
        ),
      );
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }

  /// Mark message as read
  Future<void> markAsRead(String messageId) async {
    try {
      await _repository.markAsRead(messageId);
      // Update the message in all tabs
      final updatedItems = <CommunicationTab, List<CommunicationMessage>>{};
      for (final entry in state.items.entries) {
        final updatedMessages = entry.value.map((msg) {
          if (msg.id == messageId) {
            return msg.copyWith(readAt: DateTime.now());
          }
          return msg;
        }).toList();
        updatedItems[entry.key] = updatedMessages;
      }
      emit(state.copyWith(items: updatedItems));
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }

  /// Delete a message
  Future<void> deleteMessage(String messageId, CommunicationTab tab) async {
    try {
      await _repository.deleteMessage(messageId);
      final currentMessages = state.items[tab] ?? [];
      final updatedMessages = currentMessages
          .where((msg) => msg.id != messageId)
          .toList();
      emit(state.copyWith(items: {...state.items, tab: updatedMessages}));
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }

  /// Get list of messages for a specific tab
  List<CommunicationMessage> listOf(CommunicationTab tab) {
    return state.items[tab] ?? [];
  }
}

/// Communication state
class CommunicationState {
  final Map<CommunicationTab, List<CommunicationMessage>> items;
  final Map<CommunicationTab, bool> isLoading;
  final Map<CommunicationTab, bool> isLoadingMore;
  final Map<CommunicationTab, String?> errors;
  final CommunicationTab currentTab;
  final String? error;

  const CommunicationState({
    this.items = const {},
    this.isLoading = const {},
    this.isLoadingMore = const {},
    this.errors = const {},
    this.currentTab = CommunicationTab.all,
    this.error,
  });

  CommunicationState copyWith({
    Map<CommunicationTab, List<CommunicationMessage>>? items,
    Map<CommunicationTab, bool>? isLoading,
    Map<CommunicationTab, bool>? isLoadingMore,
    Map<CommunicationTab, String?>? errors,
    CommunicationTab? currentTab,
    String? error,
  }) {
    return CommunicationState(
      items: items ?? this.items,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      errors: errors ?? this.errors,
      currentTab: currentTab ?? this.currentTab,
      error: error,
    );
  }
}
