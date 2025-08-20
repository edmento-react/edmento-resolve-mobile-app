import 'package:floor/floor.dart';

import '../entities/assignment_entity.dart';

@dao
abstract class AssignmentDao {
  @Query('SELECT * FROM assignments')
  Future<List<AssignmentEntity>> getAllAssignments();

  @Query('SELECT * FROM assignments WHERE id = :id')
  Future<AssignmentEntity?> getAssignmentById(int id);

  @Query('SELECT * FROM assignments WHERE assignment_id = :assignmentId')
  Future<AssignmentEntity?> getAssignmentByAssignmentId(String assignmentId);

  @Query('SELECT * FROM assignments WHERE class_id = :classId')
  Future<List<AssignmentEntity>> getAssignmentsByClassId(String classId);

  @Query('SELECT * FROM assignments WHERE teacher_id = :teacherId')
  Future<List<AssignmentEntity>> getAssignmentsByTeacherId(String teacherId);

  @Query('SELECT * FROM assignments WHERE is_published = :isPublished')
  Future<List<AssignmentEntity>> getAssignmentsByPublishedStatus(
    bool isPublished,
  );

  @Query('SELECT * FROM assignments WHERE is_submitted = :isSubmitted')
  Future<List<AssignmentEntity>> getAssignmentsBySubmittedStatus(
    bool isSubmitted,
  );

  @Query('SELECT * FROM assignments WHERE assignment_type = :assignmentType')
  Future<List<AssignmentEntity>> getAssignmentsByType(String assignmentType);

  @Query('SELECT * FROM assignments WHERE due_date >= :date')
  Future<List<AssignmentEntity>> getAssignmentsDueAfter(String date);

  @Query(
    'SELECT * FROM assignments WHERE title LIKE :searchTerm OR description LIKE :searchTerm',
  )
  Future<List<AssignmentEntity>> searchAssignments(String searchTerm);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertAssignment(AssignmentEntity assignment);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertAssignments(List<AssignmentEntity> assignments);

  @Update()
  Future<void> updateAssignment(AssignmentEntity assignment);

  @delete
  Future<void> deleteAssignment(AssignmentEntity assignment);

  @Query('DELETE FROM assignments WHERE id = :id')
  Future<void> deleteAssignmentById(int id);

  @Query('DELETE FROM assignments WHERE assignment_id = :assignmentId')
  Future<void> deleteAssignmentByAssignmentId(String assignmentId);

  @Query('DELETE FROM assignments WHERE class_id = :classId')
  Future<void> deleteAssignmentsByClassId(String classId);

  @Query('DELETE FROM assignments')
  Future<void> deleteAllAssignments();

  @Query('SELECT COUNT(*) FROM assignments')
  Future<int?> getAssignmentCount();

  @Query('SELECT COUNT(*) FROM assignments WHERE class_id = :classId')
  Future<int?> getAssignmentCountByClass(String classId);

  @Query('SELECT COUNT(*) FROM assignments WHERE teacher_id = :teacherId')
  Future<int?> getAssignmentCountByTeacher(String teacherId);

  @Query('SELECT COUNT(*) FROM assignments WHERE is_published = :isPublished')
  Future<int?> getAssignmentCountByPublishedStatus(bool isPublished);
}
