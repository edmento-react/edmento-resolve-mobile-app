import 'package:edmentoresolve/features/teacher/data/repositories/mock_communication_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/comm_message.dart';
import '../../domain/enums/comm_tab.dart';
import '../../domain/repositories/communication_repository.dart';

class CommunicationState extends Equatable {
  final CommTab currentTab;
  final Map<CommTab, List<CommMessage>> items;
  final Map<CommTab, bool> isLoading;
  final Map<CommTab, bool> isLoadingMore;
  final Map<CommTab, bool> hasMore;
  final Map<CommTab, String?> errors;

  const CommunicationState({
    required this.currentTab,
    required this.items,
    required this.isLoading,
    required this.isLoadingMore,
    required this.hasMore,
    required this.errors,
  });

  factory CommunicationState.initial() => CommunicationState(
    currentTab: CommTab.all,
    items: {for (final t in CommTab.values) t: []},
    isLoading: {for (final t in CommTab.values) t: false},
    isLoadingMore: {for (final t in CommTab.values) t: false},
    hasMore: {for (final t in CommTab.values) t: true},
    errors: {for (final t in CommTab.values) t: null},
  );

  CommunicationState copyWith({
    CommTab? currentTab,
    Map<CommTab, List<CommMessage>>? items,
    Map<CommTab, bool>? isLoading,
    Map<CommTab, bool>? isLoadingMore,
    Map<CommTab, bool>? hasMore,
    Map<CommTab, String?>? errors,
  }) {
    return CommunicationState(
      currentTab: currentTab ?? this.currentTab,
      items: items ?? this.items,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasMore: hasMore ?? this.hasMore,
      errors: errors ?? this.errors,
    );
  }

  List<CommMessage> listOf(CommTab tab) => items[tab] ?? [];

  @override
  List<Object?> get props => [
    currentTab,
    items,
    isLoading,
    isLoadingMore,
    hasMore,
    errors,
  ];
}

class CommunicationCubit extends Cubit<CommunicationState> {
  final ICommunicationRepository repo;
  final int pageSize;
  final Map<CommTab, int> _pages = {for (final t in CommTab.values) t: 0};

  CommunicationCubit([ICommunicationRepository? repository, this.pageSize = 15])
    : repo = repository ?? MockCommunicationRepository(),
      super(CommunicationState.initial());

  void setTab(CommTab tab) {
    if (tab == state.currentTab) return;
    emit(state.copyWith(currentTab: tab));
    if (state.listOf(tab).isEmpty) {
      load(tab: tab, refresh: true);
    }
  }

  Future<void> ensureLoaded(CommTab tab) async {
    if (state.listOf(tab).isEmpty && !(state.isLoading[tab] ?? false)) {
      await load(tab: tab, refresh: true);
    }
  }

  Future<void> load({CommTab? tab, bool refresh = false}) async {
    final t = tab ?? state.currentTab;
    if ((state.isLoading[t] ?? false) || (state.isLoadingMore[t] ?? false))
      return;

    final isLoading = Map<CommTab, bool>.from(state.isLoading);
    final isLoadingMore = Map<CommTab, bool>.from(state.isLoadingMore);
    final hasMore = Map<CommTab, bool>.from(state.hasMore);
    final errors = Map<CommTab, String?>.from(state.errors);

    if (refresh) {
      isLoading[t] = true;
      hasMore[t] = true;
      _pages[t] = 0;
    } else if (_pages[t] == 0) {
      isLoading[t] = true;
    }

    errors[t] = null;
    emit(
      state.copyWith(
        isLoading: isLoading,
        isLoadingMore: isLoadingMore,
        hasMore: hasMore,
        errors: errors,
      ),
    );

    try {
      final results = await repo.fetch(
        page: _pages[t]!,
        pageSize: pageSize,
        tab: t,
      );
      final newList = refresh ? results : [...state.listOf(t), ...results];
      newList.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      final canLoadMore = results.length == pageSize;

      final items = Map<CommTab, List<CommMessage>>.from(state.items);
      items[t] = newList;

      isLoading[t] = false;
      isLoadingMore[t] = false;
      hasMore[t] = canLoadMore;

      emit(
        state.copyWith(
          items: items,
          isLoading: isLoading,
          isLoadingMore: isLoadingMore,
          hasMore: hasMore,
          errors: errors,
        ),
      );
      if (canLoadMore) _pages[t] = _pages[t]! + 1;
    } catch (e) {
      isLoading[t] = false;
      isLoadingMore[t] = false;
      errors[t] = e.toString();
      emit(
        state.copyWith(
          isLoading: isLoading,
          isLoadingMore: isLoadingMore,
          errors: errors,
        ),
      );
    }
  }

  Future<void> loadMore(CommTab tab) async {
    if (!(state.hasMore[tab] ?? false) ||
        (state.isLoading[tab] ?? false) ||
        (state.isLoadingMore[tab] ?? false))
      return;
    final isLoadingMore = Map<CommTab, bool>.from(state.isLoadingMore)
      ..[tab] = true;
    emit(state.copyWith(isLoadingMore: isLoadingMore));
    await load(tab: tab);
  }

  Future<void> refresh(CommTab tab) => load(tab: tab, refresh: true);
}
