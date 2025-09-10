import 'package:edmentoresolve/features/shared/domain/entities/task.dart';
import 'package:edmentoresolve/features/shared/domain/repositories/tasks_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Shared tasks cubit that works for all user roles
class TasksCubit extends Cubit<TasksState> {
  final ITasksRepository? _repository;

  TasksCubit(this._repository) : super(const TasksState());

  /// Load tasks with optional refresh
  Future<void> load({bool refresh = false}) async {
    if (refresh) {
      emit(state.copyWith(isLoading: true, error: null));
    } else if (state.items.isEmpty) {
      emit(state.copyWith(isLoading: true));
    }

    try {
      final tasks = await _repository?.getTasks() ?? [];
      emit(state.copyWith(items: tasks, isLoading: false, error: null));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  /// Load more tasks (pagination)
  Future<void> loadMore() async {
    if (state.isLoadingMore) return;

    emit(state.copyWith(isLoadingMore: true));

    try {
      // TODO: Implement pagination
      final moreTasks = await _repository?.getTasks() ?? [];
      emit(
        state.copyWith(
          items: [...state.items, ...moreTasks],
          isLoadingMore: false,
        ),
      );
    } catch (e) {
      emit(state.copyWith(isLoadingMore: false, error: e.toString()));
    }
  }

  /// Refresh tasks
  Future<void> refresh() async {
    await load(refresh: true);
  }

  /// Create a new task
  Future<void> createTask(Task task) async {
    try {
      final createdTask = await _repository?.createTask(task);
      if (createdTask != null) {
        emit(state.copyWith(items: [createdTask, ...state.items]));
      }
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }

  /// Update an existing task
  Future<void> updateTask(Task task) async {
    try {
      final updatedTask = await _repository?.updateTask(task);
      if (updatedTask != null) {
        final updatedItems = state.items
            .map((t) => t.id == task.id ? updatedTask : t)
            .toList();
        emit(state.copyWith(items: updatedItems));
      }
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }

  /// Delete a task
  Future<void> deleteTask(String id) async {
    try {
      await _repository?.deleteTask(id);
      final updatedItems = state.items.where((t) => t.id != id).toList();
      emit(state.copyWith(items: updatedItems));
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }

  /// Mark task as completed
  Future<void> markTaskCompleted(String id) async {
    try {
      final completedTask = await _repository?.markTaskCompleted(id);
      if (completedTask != null) {
        final updatedItems = state.items
            .map((t) => t.id == id ? completedTask : t)
            .toList();
        emit(state.copyWith(items: updatedItems));
      }
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }
}

/// Tasks state
class TasksState {
  final List<Task> items;
  final bool isLoading;
  final bool isLoadingMore;
  final String? error;

  const TasksState({
    this.items = const [],
    this.isLoading = false,
    this.isLoadingMore = false,
    this.error,
  });

  TasksState copyWith({
    List<Task>? items,
    bool? isLoading,
    bool? isLoadingMore,
    String? error,
  }) {
    return TasksState(
      items: items ?? this.items,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      error: error,
    );
  }
}
