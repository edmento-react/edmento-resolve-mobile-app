import 'package:floor/floor.dart';

import '../entities/student_entity.dart';

@dao
abstract class StudentDao {
  @Query('SELECT * FROM students')
  Future<List<StudentEntity>> getAllStudents();

  @Query('SELECT * FROM students WHERE id = :id')
  Future<StudentEntity?> getStudentById(int id);

  @Query('SELECT * FROM students WHERE student_id = :studentId')
  Future<StudentEntity?> getStudentByStudentId(String studentId);

  @Query('SELECT * FROM students WHERE user_id = :userId')
  Future<StudentEntity?> getStudentByUserId(String userId);

  @Query('SELECT * FROM students WHERE class_id = :classId')
  Future<List<StudentEntity>> getStudentsByClassId(String classId);

  @Query('SELECT * FROM students WHERE parent_id = :parentId')
  Future<List<StudentEntity>> getStudentsByParentId(String parentId);

  @Query('SELECT * FROM students WHERE is_active = :isActive')
  Future<List<StudentEntity>> getStudentsByActiveStatus(bool isActive);

  @Query(
    'SELECT * FROM students WHERE name LIKE :searchTerm OR email LIKE :searchTerm',
  )
  Future<List<StudentEntity>> searchStudents(String searchTerm);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertStudent(StudentEntity student);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertStudents(List<StudentEntity> students);

  @Update()
  Future<void> updateStudent(StudentEntity student);

  @delete
  Future<void> deleteStudent(StudentEntity student);

  @Query('DELETE FROM students WHERE id = :id')
  Future<void> deleteStudentById(int id);

  @Query('DELETE FROM students WHERE student_id = :studentId')
  Future<void> deleteStudentByStudentId(String studentId);

  @Query('DELETE FROM students')
  Future<void> deleteAllStudents();

  @Query('SELECT COUNT(*) FROM students')
  Future<int?> getStudentCount();

  @Query('SELECT COUNT(*) FROM students WHERE class_id = :classId')
  Future<int?> getStudentCountByClass(String classId);

  @Query('SELECT COUNT(*) FROM students WHERE is_active = :isActive')
  Future<int?> getStudentCountByActiveStatus(bool isActive);
}
