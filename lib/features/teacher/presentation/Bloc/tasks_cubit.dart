import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repositories/mock_tasks_repository.dart';
import '../../domain/entities/task.dart';
import '../../domain/repositories/tasks_repository.dart';

class TasksState extends Equatable {
  final List<Task> items;
  final bool isLoading;
  final bool isLoadingMore;
  final bool hasMore;
  final String? error;

  const TasksState({
    required this.items,
    required this.isLoading,
    required this.isLoadingMore,
    required this.hasMore,
    this.error,
  });

  factory TasksState.initial() => const TasksState(
    items: [],
    isLoading: false,
    isLoadingMore: false,
    hasMore: true,
    error: null,
  );

  TasksState copyWith({
    List<Task>? items,
    bool? isLoading,
    bool? isLoadingMore,
    bool? hasMore,
    String? error,
  }) {
    return TasksState(
      items: items ?? this.items,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasMore: hasMore ?? this.hasMore,
      error: error,
    );
  }

  @override
  List<Object?> get props => [items, isLoading, isLoadingMore, hasMore, error];
}

class TasksCubit extends Cubit<TasksState> {
  final ITasksRepository repo;
  final int pageSize;
  int _page = 0;

  TasksCubit([ITasksRepository? repository, this.pageSize = 15])
    : repo = repository ?? MockTasksRepository(),
      super(TasksState.initial());

  Future<void> load({bool refresh = false}) async {
    if (state.isLoading || state.isLoadingMore) return;

    try {
      if (refresh) {
        emit(state.copyWith(isLoading: true, error: null, hasMore: true));
        _page = 0;
      } else if (_page == 0) {
        emit(state.copyWith(isLoading: true, error: null));
      }

      final results = await repo.fetch(page: _page, pageSize: pageSize);
      final list = refresh ? results : [...state.items, ...results];
      final hasMore = results.length == pageSize;

      // Sort by due date (Today first), then those without due date
      list.sort((a, b) {
        if (a.dueAt == null && b.dueAt == null) return 0;
        if (a.dueAt == null) return 1;
        if (b.dueAt == null) return -1;
        return a.dueAt!.compareTo(b.dueAt!);
      });

      emit(
        state.copyWith(
          items: list,
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
}
