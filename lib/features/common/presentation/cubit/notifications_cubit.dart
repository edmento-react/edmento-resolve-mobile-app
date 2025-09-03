import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repositories/mock_notifications_repository.dart';
import '../../notifications.dart';

class NotificationsState extends Equatable {
  final List<AppNotification> items;
  final bool isLoading;
  final bool isLoadingMore;
  final bool hasMore;
  final NotificationFilter filter;
  final String? error;

  const NotificationsState({
    required this.items,
    required this.isLoading,
    required this.isLoadingMore,
    required this.hasMore,
    required this.filter,
    this.error,
  });

  factory NotificationsState.initial() => const NotificationsState(
    items: [],
    isLoading: false,
    isLoadingMore: false,
    hasMore: true,
    filter: NotificationFilter.all,
    error: null,
  );

  NotificationsState copyWith({
    List<AppNotification>? items,
    bool? isLoading,
    bool? isLoadingMore,
    bool? hasMore,
    NotificationFilter? filter,
    String? error,
  }) {
    return NotificationsState(
      items: items ?? this.items,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasMore: hasMore ?? this.hasMore,
      filter: filter ?? this.filter,
      error: error,
    );
  }

  int get unreadCount => items.where((e) => !e.isRead).length;

  @override
  List<Object?> get props => [
    items,
    isLoading,
    isLoadingMore,
    hasMore,
    filter,
    error,
  ];
}

class NotificationsCubit extends Cubit<NotificationsState> {
  final INotificationsRepository repo;
  final int pageSize;
  int _page = 0;

  // Default to Mock repo; swap via DI (get_it) in production
  NotificationsCubit([INotificationsRepository? repository, this.pageSize = 15])
    : repo = repository ?? MockNotificationsRepository(),
      super(NotificationsState.initial());

  Future<void> load({bool refresh = false}) async {
    if (state.isLoading || state.isLoadingMore) return;

    try {
      if (refresh) {
        emit(state.copyWith(isLoading: true, error: null, hasMore: true));
        _page = 0;
      } else if (_page == 0) {
        emit(state.copyWith(isLoading: true, error: null));
      }

      final results = await repo.fetch(
        page: _page,
        pageSize: pageSize,
        filter: state.filter,
      );
      final newList = refresh ? results : [...state.items, ...results];
      final hasMore = results.length == pageSize;

      newList.sort((a, b) => b.createdAt.compareTo(a.createdAt));

      emit(
        state.copyWith(
          items: newList,
          isLoading: false,
          isLoadingMore: false,
          hasMore: hasMore,
          error: null,
        ),
      );
      if (hasMore) _page++;
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          isLoadingMore: false,
          error: e.toString(),
        ),
      );
    }
  }

  Future<void> loadMore() async {
    if (!state.hasMore || state.isLoading || state.isLoadingMore) return;
    emit(state.copyWith(isLoadingMore: true));
    await load();
  }

  Future<void> refresh() => load(refresh: true);

  Future<void> setFilter(NotificationFilter filter) async {
    if (filter == state.filter) return;
    emit(state.copyWith(filter: filter));
    await load(refresh: true);
  }

  void toggleRead(String id) {
    final idx = state.items.indexWhere((e) => e.id == id);
    if (idx == -1) return;
    final changed = state.items[idx].copyWith(isRead: !state.items[idx].isRead);
    final updated = [...state.items]..[idx] = changed;
    emit(state.copyWith(items: updated));
  }

  void deleteById(String id) {
    final updated = state.items.where((e) => e.id != id).toList();
    emit(state.copyWith(items: updated, hasMore: updated.length >= pageSize));
  }

  void markAllAsRead() {
    final updated = state.items.map((e) => e.copyWith(isRead: true)).toList();
    emit(state.copyWith(items: updated));
  }
}
