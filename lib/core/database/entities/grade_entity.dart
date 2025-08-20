import 'package:floor/floor.dart';

@Entity(tableName: 'grades')
class GradeEntity {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  @ColumnInfo(name: 'grade_id')
  final String gradeId;

  @ColumnInfo(name: 'student_id')
  final String studentId;

  @ColumnInfo(name: 'assignment_id')
  final String assignmentId;

  @ColumnInfo(name: 'class_id')
  final String classId;

  final double score;

  @ColumnInfo(name: 'max_score')
  final double maxScore;

  final String? comments;
  final String? feedback;

  @ColumnInfo(name: 'graded_by')
  final String? gradedBy;

  @ColumnInfo(name: 'graded_at')
  final String? gradedAt;

  @ColumnInfo(name: 'is_submitted')
  final bool isSubmitted;

  @ColumnInfo(name: 'submitted_at')
  final String? submittedAt;

  @ColumnInfo(name: 'created_at')
  final String? createdAt;

  @ColumnInfo(name: 'updated_at')
  final String? updatedAt;

  GradeEntity({
    this.id,
    required this.gradeId,
    required this.studentId,
    required this.assignmentId,
    required this.classId,
    required this.score,
    required this.maxScore,
    this.comments,
    this.feedback,
    this.gradedBy,
    this.gradedAt,
    required this.isSubmitted,
    this.submittedAt,
    this.createdAt,
    this.updatedAt,
  });

  GradeEntity copyWith({
    int? id,
    String? gradeId,
    String? studentId,
    String? assignmentId,
    String? classId,
    double? score,
    double? maxScore,
    String? comments,
    String? feedback,
    String? gradedBy,
    String? gradedAt,
    bool? isSubmitted,
    String? submittedAt,
    String? createdAt,
    String? updatedAt,
  }) {
    return GradeEntity(
      id: id ?? this.id,
      gradeId: gradeId ?? this.gradeId,
      studentId: studentId ?? this.studentId,
      assignmentId: assignmentId ?? this.assignmentId,
      classId: classId ?? this.classId,
      score: score ?? this.score,
      maxScore: maxScore ?? this.maxScore,
      comments: comments ?? this.comments,
      feedback: feedback ?? this.feedback,
      gradedBy: gradedBy ?? this.gradedBy,
      gradedAt: gradedAt ?? this.gradedAt,
      isSubmitted: isSubmitted ?? this.isSubmitted,
      submittedAt: submittedAt ?? this.submittedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
