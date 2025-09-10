import 'package:edmentoresolve/features/shared/domain/entities/task.dart';

/// Abstract repository interface for tasks - shared across all user roles
abstract class ITasksRepository {
  /// Get all tasks for the current user
  Future<List<Task>> getTasks({
    int page = 1,
    int limit = 20,
    TaskStatus? status,
    TaskPriority? priority,
    String? searchQuery,
  });

  /// Get a specific task by ID
  Future<Task?> getTaskById(String id);

  /// Create a new task
  Future<Task> createTask(Task task);

  /// Update an existing task
  Future<Task> updateTask(Task task);

  /// Delete a task
  Future<void> deleteTask(String id);

  /// Get tasks assigned to a specific user
  Future<List<Task>> getTasksByAssignee(String userId);

  /// Get tasks created by a specific user
  Future<List<Task>> getTasksByCreator(String userId);

  /// Get overdue tasks
  Future<List<Task>> getOverdueTasks();

  /// Get tasks due today
  Future<List<Task>> getTasksDueToday();

  /// Get tasks due this week
  Future<List<Task>> getTasksDueThisWeek();

  /// Mark task as completed
  Future<Task> markTaskCompleted(String id);

  /// Mark task as in progress
  Future<Task> markTaskInProgress(String id);

  /// Assign task to user
  Future<Task> assignTask(String taskId, String userId);

  /// Get task statistics
  Future<Map<String, int>> getTaskStatistics();
}
