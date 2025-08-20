import 'package:floor/floor.dart';

@Entity(tableName: 'attendance')
class AttendanceEntity {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  @ColumnInfo(name: 'attendance_id')
  final String attendanceId;

  @ColumnInfo(name: 'student_id')
  final String studentId;

  @ColumnInfo(name: 'class_id')
  final String classId;

  @ColumnInfo(name: 'date')
  final String date;

  @ColumnInfo(name: 'status')
  final String status; // present, absent, late, excused

  final String? reason;
  final String? notes;

  @ColumnInfo(name: 'marked_by')
  final String? markedBy;

  @ColumnInfo(name: 'marked_at')
  final String? markedAt;

  @ColumnInfo(name: 'created_at')
  final String? createdAt;

  @ColumnInfo(name: 'updated_at')
  final String? updatedAt;

  AttendanceEntity({
    this.id,
    required this.attendanceId,
    required this.studentId,
    required this.classId,
    required this.date,
    required this.status,
    this.reason,
    this.notes,
    this.markedBy,
    this.markedAt,
    this.createdAt,
    this.updatedAt,
  });

  AttendanceEntity copyWith({
    int? id,
    String? attendanceId,
    String? studentId,
    String? classId,
    String? date,
    String? status,
    String? reason,
    String? notes,
    String? markedBy,
    String? markedAt,
    String? createdAt,
    String? updatedAt,
  }) {
    return AttendanceEntity(
      id: id ?? this.id,
      attendanceId: attendanceId ?? this.attendanceId,
      studentId: studentId ?? this.studentId,
      classId: classId ?? this.classId,
      date: date ?? this.date,
      status: status ?? this.status,
      reason: reason ?? this.reason,
      notes: notes ?? this.notes,
      markedBy: markedBy ?? this.markedBy,
      markedAt: markedAt ?? this.markedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
