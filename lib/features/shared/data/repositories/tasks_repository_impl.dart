import 'package:edmentoresolve/features/shared/data/datasources/tasks_remote_data_source.dart';
import 'package:edmentoresolve/features/shared/data/models/task_model.dart';
import 'package:edmentoresolve/features/shared/domain/entities/task.dart';
import 'package:edmentoresolve/features/shared/domain/repositories/tasks_repository.dart';

/// Implementation of tasks repository - shared across all user roles
class TasksRepositoryImpl implements ITasksRepository {
  final ITasksRemoteDataSource _remoteDataSource;

  const TasksRepositoryImpl({required ITasksRemoteDataSource remoteDataSource})
    : _remoteDataSource = remoteDataSource;

  @override
  Future<List<Task>> getTasks({
    int page = 1,
    int limit = 20,
    TaskStatus? status,
    TaskPriority? priority,
    String? searchQuery,
  }) async {
    try {
      final taskModels = await _remoteDataSource.getTasks(
        page: page,
        limit: limit,
        status: status?.name,
        priority: priority?.name,
        searchQuery: searchQuery,
      );
      return taskModels.map((model) => model.toEntity()).toList();
    } catch (e) {
      throw Exception('Failed to get tasks: $e');
    }
  }

  @override
  Future<Task?> getTaskById(String id) async {
    try {
      final taskModel = await _remoteDataSource.getTaskById(id);
      return taskModel?.toEntity();
    } catch (e) {
      throw Exception('Failed to get task by id: $e');
    }
  }

  @override
  Future<Task> createTask(Task task) async {
    try {
      final taskModel = TaskModel.fromEntity(task);
      final createdTaskModel = await _remoteDataSource.createTask(taskModel);
      return createdTaskModel.toEntity();
    } catch (e) {
      throw Exception('Failed to create task: $e');
    }
  }

  @override
  Future<Task> updateTask(Task task) async {
    try {
      final taskModel = TaskModel.fromEntity(task);
      final updatedTaskModel = await _remoteDataSource.updateTask(taskModel);
      return updatedTaskModel.toEntity();
    } catch (e) {
      throw Exception('Failed to update task: $e');
    }
  }

  @override
  Future<void> deleteTask(String id) async {
    try {
      await _remoteDataSource.deleteTask(id);
    } catch (e) {
      throw Exception('Failed to delete task: $e');
    }
  }

  @override
  Future<List<Task>> getTasksByAssignee(String userId) async {
    try {
      final taskModels = await _remoteDataSource.getTasksByAssignee(userId);
      return taskModels.map((model) => model.toEntity()).toList();
    } catch (e) {
      throw Exception('Failed to get tasks by assignee: $e');
    }
  }

  @override
  Future<List<Task>> getTasksByCreator(String userId) async {
    try {
      final taskModels = await _remoteDataSource.getTasksByCreator(userId);
      return taskModels.map((model) => model.toEntity()).toList();
    } catch (e) {
      throw Exception('Failed to get tasks by creator: $e');
    }
  }

  @override
  Future<List<Task>> getOverdueTasks() async {
    try {
      final taskModels = await _remoteDataSource.getOverdueTasks();
      return taskModels.map((model) => model.toEntity()).toList();
    } catch (e) {
      throw Exception('Failed to get overdue tasks: $e');
    }
  }

  @override
  Future<List<Task>> getTasksDueToday() async {
    try {
      final taskModels = await _remoteDataSource.getTasksDueToday();
      return taskModels.map((model) => model.toEntity()).toList();
    } catch (e) {
      throw Exception('Failed to get tasks due today: $e');
    }
  }

  @override
  Future<List<Task>> getTasksDueThisWeek() async {
    try {
      final taskModels = await _remoteDataSource.getTasksDueThisWeek();
      return taskModels.map((model) => model.toEntity()).toList();
    } catch (e) {
      throw Exception('Failed to get tasks due this week: $e');
    }
  }

  @override
  Future<Task> markTaskCompleted(String id) async {
    try {
      final taskModel = await _remoteDataSource.markTaskCompleted(id);
      return taskModel.toEntity();
    } catch (e) {
      throw Exception('Failed to mark task as completed: $e');
    }
  }

  @override
  Future<Task> markTaskInProgress(String id) async {
    try {
      final taskModel = await _remoteDataSource.markTaskInProgress(id);
      return taskModel.toEntity();
    } catch (e) {
      throw Exception('Failed to mark task as in progress: $e');
    }
  }

  @override
  Future<Task> assignTask(String taskId, String userId) async {
    try {
      final taskModel = await _remoteDataSource.assignTask(taskId, userId);
      return taskModel.toEntity();
    } catch (e) {
      throw Exception('Failed to assign task: $e');
    }
  }

  @override
  Future<Map<String, int>> getTaskStatistics() async {
    try {
      return await _remoteDataSource.getTaskStatistics();
    } catch (e) {
      throw Exception('Failed to get task statistics: $e');
    }
  }
}
