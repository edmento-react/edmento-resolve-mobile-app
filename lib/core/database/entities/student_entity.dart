import 'package:floor/floor.dart';

@Entity(tableName: 'students')
class StudentEntity {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  @ColumnInfo(name: 'student_id')
  final String studentId;

  @ColumnInfo(name: 'user_id')
  final String userId;

  final String name;
  final String email;

  @ColumnInfo(name: 'class_id')
  final String? classId;

  @ColumnInfo(name: 'parent_id')
  final String? parentId;

  @ColumnInfo(name: 'date_of_birth')
  final String? dateOfBirth;

  final String? address;
  final String? phone;

  @ColumnInfo(name: 'enrollment_date')
  final String? enrollmentDate;

  @ColumnInfo(name: 'is_active')
  final bool isActive;

  @ColumnInfo(name: 'created_at')
  final String? createdAt;

  @ColumnInfo(name: 'updated_at')
  final String? updatedAt;

  StudentEntity({
    this.id,
    required this.studentId,
    required this.userId,
    required this.name,
    required this.email,
    this.classId,
    this.parentId,
    this.dateOfBirth,
    this.address,
    this.phone,
    this.enrollmentDate,
    required this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  StudentEntity copyWith({
    int? id,
    String? studentId,
    String? userId,
    String? name,
    String? email,
    String? classId,
    String? parentId,
    String? dateOfBirth,
    String? address,
    String? phone,
    String? enrollmentDate,
    bool? isActive,
    String? createdAt,
    String? updatedAt,
  }) {
    return StudentEntity(
      id: id ?? this.id,
      studentId: studentId ?? this.studentId,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      email: email ?? this.email,
      classId: classId ?? this.classId,
      parentId: parentId ?? this.parentId,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      address: address ?? this.address,
      phone: phone ?? this.phone,
      enrollmentDate: enrollmentDate ?? this.enrollmentDate,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
