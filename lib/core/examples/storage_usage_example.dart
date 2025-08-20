// import 'package:edmentoresolve/core/constants/shared_preferences.dart';
// import 'package:edmentoresolve/core/database/database_service.dart';
// import 'package:edmentoresolve/core/database/entities/assignment_entity.dart';
// import 'package:edmentoresolve/core/database/entities/student_entity.dart';

// /// Example demonstrating the hybrid storage approach
// /// This shows how to use both SharedPreferences and Floor database
// class StorageUsageExample {
//   /// Example: Using SharedPreferences for simple data
//   static Future<void> exampleSharedPreferencesUsage() async {
//     // Get the SharedPreferences service instance
//     final sharedPrefsService = await SharedPrefsService.getInstance();

//     // Store authentication data
//     await sharedPrefsService.cacheSessionId('jwt_session_id_here');
//     await sharedPrefsService.cacheUser({
//       'id': 'user123',
//       'email': 'user@example.com',
//       'name': 'John Doe',
//       'roleId': 6, // Teacher role
//     });

//     // Store theme preference
//     await sharedPrefsService.setThemeMode('dark');

//     // Store app settings
//     await sharedPrefsService.setNotificationsEnabled(true);
//     await sharedPrefsService.setBiometricEnabled(false);

//     // Check if user is logged in
//     final isLoggedIn = await sharedPrefsService.isLoggedIn();
//     print('User is logged in: $isLoggedIn');

//     // Get user role
//     final roleId = await sharedPrefsService.getUserRoleId();
//     print('User role ID: $roleId');
//   }

//   /// Example: Using Floor database for complex data
//   static Future<void> exampleFloorDatabaseUsage() async {
//     // Initialize the database service
//     await DatabaseService.getInstance();

//     // Insert a student
//     final student = StudentEntity(
//       studentId: 'STU001',
//       userId: 'user123',
//       name: 'Alice Johnson',
//       email: 'alice@school.com',
//       classId: 'CLASS001',
//       parentId: 'parent123',
//       dateOfBirth: '2005-03-15',
//       address: '123 School Street',
//       phone: '+1234567890',
//       enrollmentDate: '2023-09-01',
//       isActive: true,
//       createdAt: DateTime.now().toString(),
//       updatedAt: DateTime.now().toString(),
//     );

//     await DatabaseService.studentDao.insertStudent(student);

//     // Insert an assignment
//     final assignment = AssignmentEntity(
//       assignmentId: 'ASS001',
//       title: 'Math Homework',
//       description: 'Complete exercises 1-10',
//       classId: 'CLASS001',
//       teacherId: 'teacher123',
//       dueDate: '2024-01-15',
//       maxScore: 100.0,
//       assignmentType: 'homework',
//       instructions: 'Show all your work',
//       attachments: null,
//       isPublished: true,
//       isSubmitted: false,
//       createdAt: DateTime.now().toString(),
//       updatedAt: DateTime.now().toString(),
//     );

//     await DatabaseService.assignmentDao.insertAssignment(assignment);

//     // Query students by class
//     final studentsInClass = await DatabaseService.studentDao
//         .getStudentsByClassId('CLASS001');
//     print('Students in class: ${studentsInClass.length}');

//     // Query assignments by teacher
//     final teacherAssignments = await DatabaseService.assignmentDao
//         .getAssignmentsByTeacherId('teacher123');
//     print('Teacher assignments: ${teacherAssignments.length}');

//     // Get database statistics
//     final stats = await DatabaseService.getDatabaseStats();
//     print('Database stats: $stats');
//   }

//   /// Example: Hybrid approach - using both storage types
//   static Future<void> exampleHybridUsage() async {
//     final sharedPrefsService = await SharedPrefsService.getInstance();
//     await DatabaseService.getInstance();

//     // Check if user is logged in (SharedPreferences)
//     final isLoggedIn = await sharedPrefsService.isLoggedIn();
//     if (!isLoggedIn) {
//       print('User not logged in');
//       return;
//     }

//     // Get user role (SharedPreferences)
//     final roleId = await sharedPrefsService.getUserRoleId();

//     // Based on role, load different data from database
//     switch (roleId) {
//       case 6: // Teacher
//         final teacherId = 'teacher123';
//         final classes = await DatabaseService.classDao.getClassesByTeacherId(
//           teacherId,
//         );
//         final assignments = await DatabaseService.assignmentDao
//             .getAssignmentsByTeacherId(teacherId);
//         print(
//           'Teacher has ${classes.length} classes and ${assignments.length} assignments',
//         );
//         break;

//       case 8: // Student
//         final studentId = 'STU001';
//         final grades = await DatabaseService.gradeDao.getGradesByStudentId(
//           studentId,
//         );
//         final attendance = await DatabaseService.attendanceDao
//             .getAttendanceByStudentId(studentId);
//         print(
//           'Student has ${grades.length} grades and ${attendance.length} attendance records',
//         );
//         break;

//       case 9: // Parent
//         final parentId = 'parent123';
//         final children = await DatabaseService.studentDao.getStudentsByParentId(
//           parentId,
//         );
//         print('Parent has ${children.length} children');
//         break;

//       default:
//         print('Unknown role: $roleId');
//     }

//     // Check if data needs sync (SharedPreferences)
//     final needsSync = await sharedPrefsService.needsSync();
//     if (needsSync) {
//       print('Data needs synchronization');
//       // Perform sync logic here
//       await sharedPrefsService.setLastSyncTimestamp(
//         DateTime.now().millisecondsSinceEpoch,
//       );
//     }
//   }

//   /// Example: Data synchronization
//   static Future<void> exampleDataSync() async {
//     final sharedPrefsService = await SharedPrefsService.getInstance();
//     await DatabaseService.getInstance();

//     // Check if database is empty
//     final isEmpty = await DatabaseService.isDatabaseEmpty();
//     if (isEmpty) {
//       print('Database is empty, loading initial data...');
//       // Load initial data from API or local cache
//     }

//     // Check last sync time
//     final lastSync = await sharedPrefsService.getLastSyncTimestamp();
//     final now = DateTime.now().millisecondsSinceEpoch;
//     final timeSinceLastSync = now - lastSync;

//     if (timeSinceLastSync > 3600000) {
//       // 1 hour
//       print('Performing data sync...');
//       // Perform sync operations
//       await sharedPrefsService.setLastSyncTimestamp(now);
//     }
//   }

//   /// Example: Error handling and cleanup
//   static Future<void> exampleErrorHandling() async {
//     try {
//       final sharedPrefsService = await SharedPrefsService.getInstance();
//       await DatabaseService.getInstance();

//       // Clear all data (useful for logout or reset)
//       await sharedPrefsService.clearAuthData();
//       await DatabaseService.clearAllData();

//       print('All data cleared successfully');
//     } catch (e) {
//       print('Error during data operations: $e');
//       // Handle error appropriately
//     }
//   }
// }
