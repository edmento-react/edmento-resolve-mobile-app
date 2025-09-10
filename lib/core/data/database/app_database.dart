import 'dart:async';

import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'daos/assignment_dao.dart';
import 'daos/attendance_dao.dart';
import 'daos/class_dao.dart';
import 'daos/grade_dao.dart';
import 'daos/student_dao.dart';
import 'entities/assignment_entity.dart';
import 'entities/attendance_entity.dart';
import 'entities/class_entity.dart';
import 'entities/grade_entity.dart';
import 'entities/student_entity.dart';

part 'app_database.g.dart';

@Database(
  version: 1,
  entities: [
    // UserModel,
    StudentEntity,
    AssignmentEntity,
    GradeEntity,
    ClassEntity,
    AttendanceEntity,
  ],
)
abstract class AppDatabase extends FloorDatabase {
  // DAOs
  StudentDao get studentDao;
  AssignmentDao get assignmentDao;
  GradeDao get gradeDao;
  ClassDao get classDao;
  AttendanceDao get attendanceDao;
}
