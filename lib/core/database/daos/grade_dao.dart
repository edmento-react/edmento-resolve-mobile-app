import 'package:floor/floor.dart';

import '../entities/grade_entity.dart';

@dao
abstract class GradeDao {
  @Query('SELECT * FROM grades')
  Future<List<GradeEntity>> getAllGrades();

  @Query('SELECT * FROM grades WHERE id = :id')
  Future<GradeEntity?> getGradeById(int id);

  @Query('SELECT * FROM grades WHERE grade_id = :gradeId')
  Future<GradeEntity?> getGradeByGradeId(String gradeId);

  @Query('SELECT * FROM grades WHERE student_id = :studentId')
  Future<List<GradeEntity>> getGradesByStudentId(String studentId);

  @Query('SELECT * FROM grades WHERE assignment_id = :assignmentId')
  Future<List<GradeEntity>> getGradesByAssignmentId(String assignmentId);

  @Query('SELECT * FROM grades WHERE class_id = :classId')
  Future<List<GradeEntity>> getGradesByClassId(String classId);

  @Query(
    'SELECT * FROM grades WHERE student_id = :studentId AND class_id = :classId',
  )
  Future<List<GradeEntity>> getGradesByStudentAndClass(
    String studentId,
    String classId,
  );

  @Query('SELECT * FROM grades WHERE is_submitted = :isSubmitted')
  Future<List<GradeEntity>> getGradesBySubmittedStatus(bool isSubmitted);

  @Query('SELECT * FROM grades WHERE score >= :minScore')
  Future<List<GradeEntity>> getGradesAboveScore(double minScore);

  @Query('SELECT * FROM grades WHERE score <= :maxScore')
  Future<List<GradeEntity>> getGradesBelowScore(double maxScore);

  @Query(
    'SELECT AVG(score) FROM grades WHERE student_id = :studentId AND class_id = :classId',
  )
  Future<double?> getAverageGradeByStudentAndClass(
    String studentId,
    String classId,
  );

  @Query('SELECT AVG(score) FROM grades WHERE class_id = :classId')
  Future<double?> getAverageGradeByClass(String classId);

  @Query('SELECT AVG(score) FROM grades WHERE assignment_id = :assignmentId')
  Future<double?> getAverageGradeByAssignment(String assignmentId);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertGrade(GradeEntity grade);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertGrades(List<GradeEntity> grades);

  @Update()
  Future<void> updateGrade(GradeEntity grade);

  @delete
  Future<void> deleteGrade(GradeEntity grade);

  @Query('DELETE FROM grades WHERE id = :id')
  Future<void> deleteGradeById(int id);

  @Query('DELETE FROM grades WHERE grade_id = :gradeId')
  Future<void> deleteGradeByGradeId(String gradeId);

  @Query('DELETE FROM grades WHERE student_id = :studentId')
  Future<void> deleteGradesByStudentId(String studentId);

  @Query('DELETE FROM grades WHERE assignment_id = :assignmentId')
  Future<void> deleteGradesByAssignmentId(String assignmentId);

  @Query('DELETE FROM grades WHERE class_id = :classId')
  Future<void> deleteGradesByClassId(String classId);

  @Query('DELETE FROM grades')
  Future<void> deleteAllGrades();

  @Query('SELECT COUNT(*) FROM grades')
  Future<int?> getGradeCount();

  @Query('SELECT COUNT(*) FROM grades WHERE student_id = :studentId')
  Future<int?> getGradeCountByStudent(String studentId);

  @Query('SELECT COUNT(*) FROM grades WHERE class_id = :classId')
  Future<int?> getGradeCountByClass(String classId);

  @Query('SELECT COUNT(*) FROM grades WHERE assignment_id = :assignmentId')
  Future<int?> getGradeCountByAssignment(String assignmentId);
}
