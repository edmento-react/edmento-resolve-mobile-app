import 'package:edmentoresolve/features/shared/data/models/task_model.dart';
import 'package:edmentoresolve/features/shared/domain/entities/task.dart';

/// Abstract remote data source for tasks - shared across all user roles
abstract class ITasksRemoteDataSource {
  /// Get all tasks from remote API
  Future<List<TaskModel>> getTasks({
    int page = 1,
    int limit = 20,
    String? status,
    String? priority,
    String? searchQuery,
  });

  /// Get a specific task by ID from remote API
  Future<TaskModel?> getTaskById(String id);

  /// Create a new task via remote API
  Future<TaskModel> createTask(TaskModel task);

  /// Update an existing task via remote API
  Future<TaskModel> updateTask(TaskModel task);

  /// Delete a task via remote API
  Future<void> deleteTask(String id);

  /// Get tasks assigned to a specific user from remote API
  Future<List<TaskModel>> getTasksByAssignee(String userId);

  /// Get tasks created by a specific user from remote API
  Future<List<TaskModel>> getTasksByCreator(String userId);

  /// Get overdue tasks from remote API
  Future<List<TaskModel>> getOverdueTasks();

  /// Get tasks due today from remote API
  Future<List<TaskModel>> getTasksDueToday();

  /// Get tasks due this week from remote API
  Future<List<TaskModel>> getTasksDueThisWeek();

  /// Mark task as completed via remote API
  Future<TaskModel> markTaskCompleted(String id);

  /// Mark task as in progress via remote API
  Future<TaskModel> markTaskInProgress(String id);

  /// Assign task to user via remote API
  Future<TaskModel> assignTask(String taskId, String userId);

  /// Get task statistics from remote API
  Future<Map<String, int>> getTaskStatistics();
}

/// Concrete implementation of tasks remote data source
class TasksRemoteDataSource implements ITasksRemoteDataSource {
  // TODO: Implement with actual API calls
  // This is a placeholder implementation

  @override
  Future<List<TaskModel>> getTasks({
    int page = 1,
    int limit = 20,
    String? status,
    String? priority,
    String? searchQuery,
  }) async {
    // Mock implementation with sample data
    await Future.delayed(
      const Duration(milliseconds: 500),
    ); // Simulate network delay

    final mockTasks = [
      TaskModel(
        id: '1',
        title: 'Complete project documentation',
        description: 'Write comprehensive documentation for the new feature',
        dueAt: DateTime.now().add(const Duration(days: 1)), // Due tomorrow
        status: TaskStatus.pending,
        priority: TaskPriority.high,
        assignedTo: 'user1',
        assignedBy: 'user2',
        createdAt: DateTime.now().subtract(const Duration(days: 3)),
        updatedAt: DateTime.now().subtract(const Duration(hours: 2)),
        tags: ['documentation', 'project'],
        metadata: {'projectId': 'proj_123'},
        commentsCount: 3,
        attachmentsCount: 1,
        assignees: [
          TaskAssignee(id: 'user1', name: 'John Doe', avatarUrl: null),
        ],
      ),
      TaskModel(
        id: '2',
        title: 'Review code changes',
        description:
            'Review the latest pull request for the authentication module',
        dueAt: DateTime.now().add(const Duration(days: 5)), // Due in 5 days
        status: TaskStatus.inProgress,
        priority: TaskPriority.medium,
        assignedTo: 'user3',
        assignedBy: 'user1',
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
        updatedAt: DateTime.now().subtract(const Duration(hours: 1)),
        tags: ['code-review', 'authentication'],
        metadata: {'prId': 'pr_456'},
        commentsCount: 7,
        attachmentsCount: 0,
        assignees: [
          TaskAssignee(id: 'user3', name: 'Jane Smith', avatarUrl: null),
        ],
      ),
      TaskModel(
        id: '3',
        title: 'Update user interface',
        description: 'Improve the user interface based on feedback',
        dueAt: DateTime.now().add(const Duration(days: 2)), // Due in 2 days
        status: TaskStatus.pending,
        priority: TaskPriority.low,
        assignedTo: 'user4',
        assignedBy: 'user2',
        createdAt: DateTime.now().subtract(const Duration(hours: 6)),
        updatedAt: DateTime.now().subtract(const Duration(minutes: 30)),
        tags: ['ui', 'improvement'],
        metadata: {'version': '2.1.0'},
        commentsCount: 1,
        attachmentsCount: 2,
        assignees: [
          TaskAssignee(id: 'user4', name: 'Mike Johnson', avatarUrl: null),
        ],
      ),
      TaskModel(
        id: '4',
        title: 'Review documentation',
        description: 'Review and approve the updated user manual',
        dueAt: DateTime.now().subtract(
          const Duration(days: 1),
        ), // Completed yesterday
        status: TaskStatus.completed,
        priority: TaskPriority.medium,
        assignedTo: 'user1',
        assignedBy: 'user3',
        createdAt: DateTime.now().subtract(const Duration(days: 3)),
        updatedAt: DateTime.now().subtract(
          const Duration(hours: 2),
        ), // Completed yesterday
        tags: ['documentation', 'review'],
        metadata: {'version': '1.2.0'},
        commentsCount: 2,
        attachmentsCount: 1,
        assignees: [
          TaskAssignee(id: 'user1', name: 'John Doe', avatarUrl: null),
        ],
      ),
      TaskModel(
        id: '5',
        title: 'Update database schema',
        description: 'Migrate the database to the new schema version',
        dueAt: DateTime.now().subtract(
          const Duration(days: 2),
        ), // Completed 2 days ago
        status: TaskStatus.completed,
        priority: TaskPriority.high,
        assignedTo: 'user2',
        assignedBy: 'user1',
        createdAt: DateTime.now().subtract(const Duration(days: 5)),
        updatedAt: DateTime.now().subtract(
          const Duration(days: 2, hours: 1),
        ), // Completed 2 days ago
        tags: ['database', 'migration'],
        metadata: {'schemaVersion': '2.1'},
        commentsCount: 5,
        attachmentsCount: 0,
        assignees: [
          TaskAssignee(id: 'user2', name: 'Jane Smith', avatarUrl: null),
        ],
      ),
      TaskModel(
        id: '6',
        title: 'Fix authentication bug',
        description: 'Resolve the login issue reported by users',
        dueAt: DateTime.now().subtract(
          const Duration(days: 3),
        ), // Completed 3 days ago
        status: TaskStatus.completed,
        priority: TaskPriority.high,
        assignedTo: 'user3',
        assignedBy: 'user1',
        createdAt: DateTime.now().subtract(const Duration(days: 7)),
        updatedAt: DateTime.now().subtract(
          const Duration(days: 3, hours: 2),
        ), // Completed 3 days ago
        tags: ['bug-fix', 'authentication'],
        metadata: {'bugId': 'BUG-123'},
        commentsCount: 8,
        attachmentsCount: 1,
        assignees: [
          TaskAssignee(id: 'user3', name: 'Mike Johnson', avatarUrl: null),
        ],
      ),
    ];

    // Apply filters
    var filteredTasks = mockTasks;

    if (status != null) {
      filteredTasks = filteredTasks
          .where((task) => task.status == status)
          .toList();
    }

    if (priority != null) {
      filteredTasks = filteredTasks
          .where((task) => task.priority == priority)
          .toList();
    }

    if (searchQuery != null && searchQuery.isNotEmpty) {
      filteredTasks = filteredTasks
          .where(
            (task) =>
                task.title.toLowerCase().contains(searchQuery.toLowerCase()) ||
                (task.description?.toLowerCase().contains(
                      searchQuery.toLowerCase(),
                    ) ??
                    false),
          )
          .toList();
    }

    // Sort tasks based on status
    filteredTasks.sort((a, b) {
      // For completed tasks, sort by completion date (most recent first)
      if (a.status == TaskStatus.completed &&
          b.status == TaskStatus.completed) {
        // Use updatedAt as completion date (most recent first)
        return b.updatedAt.compareTo(a.updatedAt);
      }

      // For pending/in-progress tasks, sort by due date (earliest first)
      if (a.status != TaskStatus.completed &&
          b.status != TaskStatus.completed) {
        // First, sort by due date (null dates go to the end)
        if (a.dueAt == null && b.dueAt == null) {
          // Both have no due date, sort by creation date (newest first)
          return b.createdAt.compareTo(a.createdAt);
        } else if (a.dueAt == null) {
          return 1; // a has no due date, put it after b
        } else if (b.dueAt == null) {
          return -1; // b has no due date, put it after a
        } else {
          // Both have due dates, sort by due date (earliest first)
          final dueComparison = a.dueAt!.compareTo(b.dueAt!);
          if (dueComparison != 0) {
            return dueComparison;
          }
          // If due dates are the same, sort by creation date (newest first)
          return b.createdAt.compareTo(a.createdAt);
        }
      }

      // Mixed statuses: completed tasks go after pending tasks
      if (a.status == TaskStatus.completed &&
          b.status != TaskStatus.completed) {
        return 1; // a is completed, put it after b
      } else if (a.status != TaskStatus.completed &&
          b.status == TaskStatus.completed) {
        return -1; // b is completed, put it after a
      }

      return 0; // Should not reach here
    });

    // Apply pagination
    final startIndex = (page - 1) * limit;
    final endIndex = startIndex + limit;

    if (startIndex >= filteredTasks.length) {
      return [];
    }

    return filteredTasks.sublist(
      startIndex,
      endIndex > filteredTasks.length ? filteredTasks.length : endIndex,
    );
  }

  @override
  Future<TaskModel?> getTaskById(String id) async {
    // TODO: Implement API call
    throw UnimplementedError('getTaskById not implemented');
  }

  @override
  Future<TaskModel> createTask(TaskModel task) async {
    // TODO: Implement API call
    throw UnimplementedError('createTask not implemented');
  }

  @override
  Future<TaskModel> updateTask(TaskModel task) async {
    // TODO: Implement API call
    throw UnimplementedError('updateTask not implemented');
  }

  @override
  Future<void> deleteTask(String id) async {
    // TODO: Implement API call
    throw UnimplementedError('deleteTask not implemented');
  }

  @override
  Future<List<TaskModel>> getTasksByAssignee(String userId) async {
    // TODO: Implement API call
    throw UnimplementedError('getTasksByAssignee not implemented');
  }

  @override
  Future<List<TaskModel>> getTasksByCreator(String userId) async {
    // TODO: Implement API call
    throw UnimplementedError('getTasksByCreator not implemented');
  }

  @override
  Future<List<TaskModel>> getOverdueTasks() async {
    // TODO: Implement API call
    throw UnimplementedError('getOverdueTasks not implemented');
  }

  @override
  Future<List<TaskModel>> getTasksDueToday() async {
    // TODO: Implement API call
    throw UnimplementedError('getTasksDueToday not implemented');
  }

  @override
  Future<List<TaskModel>> getTasksDueThisWeek() async {
    // TODO: Implement API call
    throw UnimplementedError('getTasksDueThisWeek not implemented');
  }

  @override
  Future<TaskModel> markTaskCompleted(String id) async {
    // TODO: Implement API call
    throw UnimplementedError('markTaskCompleted not implemented');
  }

  @override
  Future<TaskModel> markTaskInProgress(String id) async {
    // TODO: Implement API call
    throw UnimplementedError('markTaskInProgress not implemented');
  }

  @override
  Future<TaskModel> assignTask(String taskId, String userId) async {
    // TODO: Implement API call
    throw UnimplementedError('assignTask not implemented');
  }

  @override
  Future<Map<String, int>> getTaskStatistics() async {
    // TODO: Implement API call
    throw UnimplementedError('getTaskStatistics not implemented');
  }
}
