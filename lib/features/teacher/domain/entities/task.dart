import 'package:equatable/equatable.dart';

enum TaskPriority { normal, high }

class TaskAssignee extends Equatable {
  final String id;
  final String name;
  final String? avatarUrl;

  const TaskAssignee({required this.id, required this.name, this.avatarUrl});

  @override
  List<Object?> get props => [id, name, avatarUrl];
}

class Task extends Equatable {
  final String id;
  final String title;
  final String description;
  final DateTime? dueAt; // null = no due date
  final int commentsCount;
  final int attachmentsCount;
  final TaskPriority priority; // high shows red alert chip
  final List<TaskAssignee> assignees;

  const Task({
    required this.id,
    required this.title,
    required this.description,
    required this.dueAt,
    required this.commentsCount,
    required this.attachmentsCount,
    required this.priority,
    required this.assignees,
  });

  bool get isDueToday {
    if (dueAt == null) return false;
    final now = DateTime.now();
    return dueAt!.year == now.year &&
        dueAt!.month == now.month &&
        dueAt!.day == now.day;
  }

  @override
  List<Object?> get props => [
    id,
    title,
    description,
    dueAt,
    commentsCount,
    attachmentsCount,
    priority,
    assignees,
  ];
}
