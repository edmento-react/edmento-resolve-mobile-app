import 'package:edmentoresolve/features/shared/domain/entities/task.dart';

/// Task model for data layer - shared across all user roles
class TaskModel extends Task {
  const TaskModel({
    required super.id,
    required super.title,
    super.description,
    super.dueAt,
    super.status,
    super.priority,
    super.assignedTo,
    super.assignedBy,
    required super.createdAt,
    required super.updatedAt,
    super.tags,
    super.metadata,
    super.commentsCount,
    super.attachmentsCount,
    super.assignees,
  });

  /// Create TaskModel from JSON
  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      dueAt: json['dueAt'] != null
          ? DateTime.parse(json['dueAt'] as String)
          : null,
      status: TaskStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => TaskStatus.pending,
      ),
      priority: TaskPriority.values.firstWhere(
        (e) => e.name == json['priority'],
        orElse: () => TaskPriority.medium,
      ),
      assignedTo: json['assignedTo'] as String?,
      assignedBy: json['assignedBy'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      tags: json['tags'] != null
          ? List<String>.from(json['tags'] as List)
          : null,
      metadata: json['metadata'] as Map<String, dynamic>?,
    );
  }

  /// Convert TaskModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'dueAt': dueAt?.toIso8601String(),
      'status': status.name,
      'priority': priority.name,
      'assignedTo': assignedTo,
      'assignedBy': assignedBy,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'tags': tags,
      'metadata': metadata,
    };
  }

  /// Create TaskModel from Task entity
  factory TaskModel.fromEntity(Task task) {
    return TaskModel(
      id: task.id,
      title: task.title,
      description: task.description,
      dueAt: task.dueAt,
      status: task.status,
      priority: task.priority,
      assignedTo: task.assignedTo,
      assignedBy: task.assignedBy,
      createdAt: task.createdAt,
      updatedAt: task.updatedAt,
      tags: task.tags,
      metadata: task.metadata,
    );
  }

  /// Convert TaskModel to Task entity
  Task toEntity() {
    return Task(
      id: id,
      title: title,
      description: description,
      dueAt: dueAt,
      status: status,
      priority: priority,
      assignedTo: assignedTo,
      assignedBy: assignedBy,
      createdAt: createdAt,
      updatedAt: updatedAt,
      tags: tags,
      metadata: metadata,
    );
  }
}
