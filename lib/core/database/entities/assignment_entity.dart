import 'package:floor/floor.dart';

@Entity(tableName: 'assignments')
class AssignmentEntity {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  @ColumnInfo(name: 'assignment_id')
  final String assignmentId;

  final String title;
  final String description;

  @ColumnInfo(name: 'class_id')
  final String classId;

  @ColumnInfo(name: 'teacher_id')
  final String teacherId;

  @ColumnInfo(name: 'due_date')
  final String? dueDate;

  @ColumnInfo(name: 'max_score')
  final double? maxScore;

  @ColumnInfo(name: 'assignment_type')
  final String? assignmentType; // homework, quiz, exam, project

  final String? instructions;
  final String? attachments;

  @ColumnInfo(name: 'is_published')
  final bool isPublished;

  @ColumnInfo(name: 'is_submitted')
  final bool isSubmitted;

  @ColumnInfo(name: 'created_at')
  final String? createdAt;

  @ColumnInfo(name: 'updated_at')
  final String? updatedAt;

  AssignmentEntity({
    this.id,
    required this.assignmentId,
    required this.title,
    required this.description,
    required this.classId,
    required this.teacherId,
    this.dueDate,
    this.maxScore,
    this.assignmentType,
    this.instructions,
    this.attachments,
    required this.isPublished,
    required this.isSubmitted,
    this.createdAt,
    this.updatedAt,
  });

  AssignmentEntity copyWith({
    int? id,
    String? assignmentId,
    String? title,
    String? description,
    String? classId,
    String? teacherId,
    String? dueDate,
    double? maxScore,
    String? assignmentType,
    String? instructions,
    String? attachments,
    bool? isPublished,
    bool? isSubmitted,
    String? createdAt,
    String? updatedAt,
  }) {
    return AssignmentEntity(
      id: id ?? this.id,
      assignmentId: assignmentId ?? this.assignmentId,
      title: title ?? this.title,
      description: description ?? this.description,
      classId: classId ?? this.classId,
      teacherId: teacherId ?? this.teacherId,
      dueDate: dueDate ?? this.dueDate,
      maxScore: maxScore ?? this.maxScore,
      assignmentType: assignmentType ?? this.assignmentType,
      instructions: instructions ?? this.instructions,
      attachments: attachments ?? this.attachments,
      isPublished: isPublished ?? this.isPublished,
      isSubmitted: isSubmitted ?? this.isSubmitted,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
