import 'package:floor/floor.dart';

@Entity(tableName: 'classes')
class ClassEntity {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  @ColumnInfo(name: 'class_id')
  final String classId;

  final String name;
  final String? description;

  @ColumnInfo(name: 'teacher_id')
  final String teacherId;

  @ColumnInfo(name: 'subject_id')
  final String? subjectId;

  @ColumnInfo(name: 'academic_year')
  final String? academicYear;

  final String? schedule;
  final String? room;

  @ColumnInfo(name: 'max_students')
  final int? maxStudents;

  @ColumnInfo(name: 'is_active')
  final bool isActive;

  @ColumnInfo(name: 'start_date')
  final String? startDate;

  @ColumnInfo(name: 'end_date')
  final String? endDate;

  @ColumnInfo(name: 'created_at')
  final String? createdAt;

  @ColumnInfo(name: 'updated_at')
  final String? updatedAt;

  ClassEntity({
    this.id,
    required this.classId,
    required this.name,
    this.description,
    required this.teacherId,
    this.subjectId,
    this.academicYear,
    this.schedule,
    this.room,
    this.maxStudents,
    required this.isActive,
    this.startDate,
    this.endDate,
    this.createdAt,
    this.updatedAt,
  });

  ClassEntity copyWith({
    int? id,
    String? classId,
    String? name,
    String? description,
    String? teacherId,
    String? subjectId,
    String? academicYear,
    String? schedule,
    String? room,
    int? maxStudents,
    bool? isActive,
    String? startDate,
    String? endDate,
    String? createdAt,
    String? updatedAt,
  }) {
    return ClassEntity(
      id: id ?? this.id,
      classId: classId ?? this.classId,
      name: name ?? this.name,
      description: description ?? this.description,
      teacherId: teacherId ?? this.teacherId,
      subjectId: subjectId ?? this.subjectId,
      academicYear: academicYear ?? this.academicYear,
      schedule: schedule ?? this.schedule,
      room: room ?? this.room,
      maxStudents: maxStudents ?? this.maxStudents,
      isActive: isActive ?? this.isActive,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
