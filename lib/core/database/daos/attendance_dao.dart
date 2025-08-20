import 'package:floor/floor.dart';

import '../entities/attendance_entity.dart';

@dao
abstract class AttendanceDao {
  @Query('SELECT * FROM attendance')
  Future<List<AttendanceEntity>> findAllAttendance();

  @insert
  Future<void> insertAttendance(AttendanceEntity attendanceEntity);

  @Query('DELETE FROM attendance')
  Future<void> deleteAllAttendance();

  @Query('SELECT COUNT(*) FROM attendance')
  Future<int?> getAttendanceCount();

  @Query('SELECT * FROM attendance WHERE student_id = :studentId')
  Future<List<AttendanceEntity>> getAttendanceByStudentId(String studentId);
}
