import 'package:equatable/equatable.dart';

/// Task assignee entity
class TaskAssignee extends Equatable {
  final String id;
  final String name;
  final String? avatarUrl;

  const TaskAssignee({required this.id, required this.name, this.avatarUrl});

  @override
  List<Object?> get props => [id, name, avatarUrl];
}

/// Shared task entity that works for all user roles
class Task extends Equatable {
  final String id;
  final String title;
  final String? description;
  final DateTime? dueAt;
  final TaskStatus status;
  final TaskPriority priority;
  final String? assignedTo;
  final String? assignedBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<String>? tags;
  final Map<String, dynamic>? metadata;
  final int commentsCount;
  final int attachmentsCount;
  final List<TaskAssignee> assignees;

  const Task({
    required this.id,
    required this.title,
    this.description,
    this.dueAt,
    this.status = TaskStatus.pending,
    this.priority = TaskPriority.medium,
    this.assignedTo,
    this.assignedBy,
    required this.createdAt,
    required this.updatedAt,
    this.tags,
    this.metadata,
    this.commentsCount = 0,
    this.attachmentsCount = 0,
    this.assignees = const [],
  });

  Task copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? dueAt,
    TaskStatus? status,
    TaskPriority? priority,
    String? assignedTo,
    String? assignedBy,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<String>? tags,
    Map<String, dynamic>? metadata,
    int? commentsCount,
    int? attachmentsCount,
    List<TaskAssignee>? assignees,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      dueAt: dueAt ?? this.dueAt,
      status: status ?? this.status,
      priority: priority ?? this.priority,
      assignedTo: assignedTo ?? this.assignedTo,
      assignedBy: assignedBy ?? this.assignedBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      tags: tags ?? this.tags,
      metadata: metadata ?? this.metadata,
      commentsCount: commentsCount ?? this.commentsCount,
      attachmentsCount: attachmentsCount ?? this.attachmentsCount,
      assignees: assignees ?? this.assignees,
    );
  }

  @override
  List<Object?> get props => [
    id,
    title,
    description,
    dueAt,
    status,
    priority,
    assignedTo,
    assignedBy,
    createdAt,
    updatedAt,
    tags,
    metadata,
    commentsCount,
    attachmentsCount,
    assignees,
  ];

  bool get isDueToday {
    if (dueAt == null) return false;
    final now = DateTime.now();
    return dueAt!.year == now.year &&
        dueAt!.month == now.month &&
        dueAt!.day == now.day;
  }
}

/// Task status enumeration
enum TaskStatus { pending, inProgress, completed, cancelled, overdue }

/// Task priority enumeration
enum TaskPriority { low, medium, high, urgent }
