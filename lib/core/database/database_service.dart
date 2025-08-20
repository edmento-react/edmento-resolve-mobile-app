import 'package:edmentoresolve/core/database/daos/assignment_dao.dart';
import 'package:edmentoresolve/core/database/daos/attendance_dao.dart';
import 'package:edmentoresolve/core/database/daos/class_dao.dart';
import 'package:edmentoresolve/core/database/daos/grade_dao.dart';
import 'package:edmentoresolve/core/database/daos/student_dao.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'app_database.dart';

/// Service class to manage the Floor database instance
class DatabaseService {
  static DatabaseService? _instance;
  static AppDatabase? _database;

  DatabaseService._();

  static Future<DatabaseService> getInstance() async {
    if (_instance == null) {
      _instance = DatabaseService._();
      await _initializeDatabase();
    }
    return _instance!;
  }

  static Future<void> _initializeDatabase() async {
    final databasePath = await sqflite.getDatabasesPath();
    final path = join(databasePath, 'edmentor_database.db');

    _database = await $FloorAppDatabase.databaseBuilder(path).build();
  }

  /// Get the database instance
  static AppDatabase get database {
    if (_database == null) {
      throw Exception('Database not initialized. Call getInstance() first.');
    }
    return _database!;
  }

  /// Get Student DAO
  static StudentDao get studentDao => database.studentDao;

  /// Get Assignment DAO
  static AssignmentDao get assignmentDao => database.assignmentDao;

  /// Get Grade DAO
  static GradeDao get gradeDao => database.gradeDao;

  /// Get Class DAO
  static ClassDao get classDao => database.classDao;

  /// Get Attendance DAO
  static AttendanceDao get attendanceDao => database.attendanceDao;

  /// Close the database
  static Future<void> close() async {
    if (_database != null) {
      await _database!.close();
      _database = null;
      _instance = null;
    }
  }

  /// Clear all data from all tables
  static Future<void> clearAllData() async {
    await studentDao.deleteAllStudents();
    await assignmentDao.deleteAllAssignments();
    await gradeDao.deleteAllGrades();
    await classDao.deleteAllClasses();
    await attendanceDao.deleteAllAttendance();
  }

  /// Get database statistics
  static Future<Map<String, int>> getDatabaseStats() async {
    return {
      'students': await studentDao.getStudentCount() ?? 0,
      'assignments': await assignmentDao.getAssignmentCount() ?? 0,
      'grades': await gradeDao.getGradeCount() ?? 0,
      'classes': await classDao.getClassCount() ?? 0,
      'attendance': await attendanceDao.getAttendanceCount() ?? 0,
    };
  }

  /// Check if database is empty
  static Future<bool> isDatabaseEmpty() async {
    final stats = await getDatabaseStats();
    return stats.values.every((count) => count == 0);
  }

  /// Initialize database with sample data (for testing)
  static Future<void> initializeWithSampleData() async {
    // This method can be used to populate the database with sample data
    // Implementation would depend on your specific needs
    // Intentionally no-op in production
  }
}
