// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $AppDatabaseBuilderContract {
  /// Adds migrations to the builder.
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $AppDatabaseBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<AppDatabase> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder implements $AppDatabaseBuilderContract {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $AppDatabaseBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  StudentDao? _studentDaoInstance;

  AssignmentDao? _assignmentDaoInstance;

  GradeDao? _gradeDaoInstance;

  ClassDao? _classDaoInstance;

  AttendanceDao? _attendanceDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `students` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `student_id` TEXT NOT NULL, `user_id` TEXT NOT NULL, `name` TEXT NOT NULL, `email` TEXT NOT NULL, `class_id` TEXT, `parent_id` TEXT, `date_of_birth` TEXT, `address` TEXT, `phone` TEXT, `enrollment_date` TEXT, `is_active` INTEGER NOT NULL, `created_at` TEXT, `updated_at` TEXT)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `assignments` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `assignment_id` TEXT NOT NULL, `title` TEXT NOT NULL, `description` TEXT NOT NULL, `class_id` TEXT NOT NULL, `teacher_id` TEXT NOT NULL, `due_date` TEXT, `max_score` REAL, `assignment_type` TEXT, `instructions` TEXT, `attachments` TEXT, `is_published` INTEGER NOT NULL, `is_submitted` INTEGER NOT NULL, `created_at` TEXT, `updated_at` TEXT)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `grades` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `grade_id` TEXT NOT NULL, `student_id` TEXT NOT NULL, `assignment_id` TEXT NOT NULL, `class_id` TEXT NOT NULL, `score` REAL NOT NULL, `max_score` REAL NOT NULL, `comments` TEXT, `feedback` TEXT, `graded_by` TEXT, `graded_at` TEXT, `is_submitted` INTEGER NOT NULL, `submitted_at` TEXT, `created_at` TEXT, `updated_at` TEXT)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `classes` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `class_id` TEXT NOT NULL, `name` TEXT NOT NULL, `description` TEXT, `teacher_id` TEXT NOT NULL, `subject_id` TEXT, `academic_year` TEXT, `schedule` TEXT, `room` TEXT, `max_students` INTEGER, `is_active` INTEGER NOT NULL, `start_date` TEXT, `end_date` TEXT, `created_at` TEXT, `updated_at` TEXT)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `attendance` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `attendance_id` TEXT NOT NULL, `student_id` TEXT NOT NULL, `class_id` TEXT NOT NULL, `date` TEXT NOT NULL, `status` TEXT NOT NULL, `reason` TEXT, `notes` TEXT, `marked_by` TEXT, `marked_at` TEXT, `created_at` TEXT, `updated_at` TEXT)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  StudentDao get studentDao {
    return _studentDaoInstance ??= _$StudentDao(database, changeListener);
  }

  @override
  AssignmentDao get assignmentDao {
    return _assignmentDaoInstance ??= _$AssignmentDao(database, changeListener);
  }

  @override
  GradeDao get gradeDao {
    return _gradeDaoInstance ??= _$GradeDao(database, changeListener);
  }

  @override
  ClassDao get classDao {
    return _classDaoInstance ??= _$ClassDao(database, changeListener);
  }

  @override
  AttendanceDao get attendanceDao {
    return _attendanceDaoInstance ??= _$AttendanceDao(database, changeListener);
  }
}

class _$StudentDao extends StudentDao {
  _$StudentDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _studentEntityInsertionAdapter = InsertionAdapter(
            database,
            'students',
            (StudentEntity item) => <String, Object?>{
                  'id': item.id,
                  'student_id': item.studentId,
                  'user_id': item.userId,
                  'name': item.name,
                  'email': item.email,
                  'class_id': item.classId,
                  'parent_id': item.parentId,
                  'date_of_birth': item.dateOfBirth,
                  'address': item.address,
                  'phone': item.phone,
                  'enrollment_date': item.enrollmentDate,
                  'is_active': item.isActive ? 1 : 0,
                  'created_at': item.createdAt,
                  'updated_at': item.updatedAt
                }),
        _studentEntityUpdateAdapter = UpdateAdapter(
            database,
            'students',
            ['id'],
            (StudentEntity item) => <String, Object?>{
                  'id': item.id,
                  'student_id': item.studentId,
                  'user_id': item.userId,
                  'name': item.name,
                  'email': item.email,
                  'class_id': item.classId,
                  'parent_id': item.parentId,
                  'date_of_birth': item.dateOfBirth,
                  'address': item.address,
                  'phone': item.phone,
                  'enrollment_date': item.enrollmentDate,
                  'is_active': item.isActive ? 1 : 0,
                  'created_at': item.createdAt,
                  'updated_at': item.updatedAt
                }),
        _studentEntityDeletionAdapter = DeletionAdapter(
            database,
            'students',
            ['id'],
            (StudentEntity item) => <String, Object?>{
                  'id': item.id,
                  'student_id': item.studentId,
                  'user_id': item.userId,
                  'name': item.name,
                  'email': item.email,
                  'class_id': item.classId,
                  'parent_id': item.parentId,
                  'date_of_birth': item.dateOfBirth,
                  'address': item.address,
                  'phone': item.phone,
                  'enrollment_date': item.enrollmentDate,
                  'is_active': item.isActive ? 1 : 0,
                  'created_at': item.createdAt,
                  'updated_at': item.updatedAt
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<StudentEntity> _studentEntityInsertionAdapter;

  final UpdateAdapter<StudentEntity> _studentEntityUpdateAdapter;

  final DeletionAdapter<StudentEntity> _studentEntityDeletionAdapter;

  @override
  Future<List<StudentEntity>> getAllStudents() async {
    return _queryAdapter.queryList('SELECT * FROM students',
        mapper: (Map<String, Object?> row) => StudentEntity(
            id: row['id'] as int?,
            studentId: row['student_id'] as String,
            userId: row['user_id'] as String,
            name: row['name'] as String,
            email: row['email'] as String,
            classId: row['class_id'] as String?,
            parentId: row['parent_id'] as String?,
            dateOfBirth: row['date_of_birth'] as String?,
            address: row['address'] as String?,
            phone: row['phone'] as String?,
            enrollmentDate: row['enrollment_date'] as String?,
            isActive: (row['is_active'] as int) != 0,
            createdAt: row['created_at'] as String?,
            updatedAt: row['updated_at'] as String?));
  }

  @override
  Future<StudentEntity?> getStudentById(int id) async {
    return _queryAdapter.query('SELECT * FROM students WHERE id = ?1',
        mapper: (Map<String, Object?> row) => StudentEntity(
            id: row['id'] as int?,
            studentId: row['student_id'] as String,
            userId: row['user_id'] as String,
            name: row['name'] as String,
            email: row['email'] as String,
            classId: row['class_id'] as String?,
            parentId: row['parent_id'] as String?,
            dateOfBirth: row['date_of_birth'] as String?,
            address: row['address'] as String?,
            phone: row['phone'] as String?,
            enrollmentDate: row['enrollment_date'] as String?,
            isActive: (row['is_active'] as int) != 0,
            createdAt: row['created_at'] as String?,
            updatedAt: row['updated_at'] as String?),
        arguments: [id]);
  }

  @override
  Future<StudentEntity?> getStudentByStudentId(String studentId) async {
    return _queryAdapter.query('SELECT * FROM students WHERE student_id = ?1',
        mapper: (Map<String, Object?> row) => StudentEntity(
            id: row['id'] as int?,
            studentId: row['student_id'] as String,
            userId: row['user_id'] as String,
            name: row['name'] as String,
            email: row['email'] as String,
            classId: row['class_id'] as String?,
            parentId: row['parent_id'] as String?,
            dateOfBirth: row['date_of_birth'] as String?,
            address: row['address'] as String?,
            phone: row['phone'] as String?,
            enrollmentDate: row['enrollment_date'] as String?,
            isActive: (row['is_active'] as int) != 0,
            createdAt: row['created_at'] as String?,
            updatedAt: row['updated_at'] as String?),
        arguments: [studentId]);
  }

  @override
  Future<StudentEntity?> getStudentByUserId(String userId) async {
    return _queryAdapter.query('SELECT * FROM students WHERE user_id = ?1',
        mapper: (Map<String, Object?> row) => StudentEntity(
            id: row['id'] as int?,
            studentId: row['student_id'] as String,
            userId: row['user_id'] as String,
            name: row['name'] as String,
            email: row['email'] as String,
            classId: row['class_id'] as String?,
            parentId: row['parent_id'] as String?,
            dateOfBirth: row['date_of_birth'] as String?,
            address: row['address'] as String?,
            phone: row['phone'] as String?,
            enrollmentDate: row['enrollment_date'] as String?,
            isActive: (row['is_active'] as int) != 0,
            createdAt: row['created_at'] as String?,
            updatedAt: row['updated_at'] as String?),
        arguments: [userId]);
  }

  @override
  Future<List<StudentEntity>> getStudentsByClassId(String classId) async {
    return _queryAdapter.queryList('SELECT * FROM students WHERE class_id = ?1',
        mapper: (Map<String, Object?> row) => StudentEntity(
            id: row['id'] as int?,
            studentId: row['student_id'] as String,
            userId: row['user_id'] as String,
            name: row['name'] as String,
            email: row['email'] as String,
            classId: row['class_id'] as String?,
            parentId: row['parent_id'] as String?,
            dateOfBirth: row['date_of_birth'] as String?,
            address: row['address'] as String?,
            phone: row['phone'] as String?,
            enrollmentDate: row['enrollment_date'] as String?,
            isActive: (row['is_active'] as int) != 0,
            createdAt: row['created_at'] as String?,
            updatedAt: row['updated_at'] as String?),
        arguments: [classId]);
  }

  @override
  Future<List<StudentEntity>> getStudentsByParentId(String parentId) async {
    return _queryAdapter.queryList(
        'SELECT * FROM students WHERE parent_id = ?1',
        mapper: (Map<String, Object?> row) => StudentEntity(
            id: row['id'] as int?,
            studentId: row['student_id'] as String,
            userId: row['user_id'] as String,
            name: row['name'] as String,
            email: row['email'] as String,
            classId: row['class_id'] as String?,
            parentId: row['parent_id'] as String?,
            dateOfBirth: row['date_of_birth'] as String?,
            address: row['address'] as String?,
            phone: row['phone'] as String?,
            enrollmentDate: row['enrollment_date'] as String?,
            isActive: (row['is_active'] as int) != 0,
            createdAt: row['created_at'] as String?,
            updatedAt: row['updated_at'] as String?),
        arguments: [parentId]);
  }

  @override
  Future<List<StudentEntity>> getStudentsByActiveStatus(bool isActive) async {
    return _queryAdapter.queryList(
        'SELECT * FROM students WHERE is_active = ?1',
        mapper: (Map<String, Object?> row) => StudentEntity(
            id: row['id'] as int?,
            studentId: row['student_id'] as String,
            userId: row['user_id'] as String,
            name: row['name'] as String,
            email: row['email'] as String,
            classId: row['class_id'] as String?,
            parentId: row['parent_id'] as String?,
            dateOfBirth: row['date_of_birth'] as String?,
            address: row['address'] as String?,
            phone: row['phone'] as String?,
            enrollmentDate: row['enrollment_date'] as String?,
            isActive: (row['is_active'] as int) != 0,
            createdAt: row['created_at'] as String?,
            updatedAt: row['updated_at'] as String?),
        arguments: [isActive ? 1 : 0]);
  }

  @override
  Future<List<StudentEntity>> searchStudents(String searchTerm) async {
    return _queryAdapter.queryList(
        'SELECT * FROM students WHERE name LIKE ?1 OR email LIKE ?1',
        mapper: (Map<String, Object?> row) => StudentEntity(
            id: row['id'] as int?,
            studentId: row['student_id'] as String,
            userId: row['user_id'] as String,
            name: row['name'] as String,
            email: row['email'] as String,
            classId: row['class_id'] as String?,
            parentId: row['parent_id'] as String?,
            dateOfBirth: row['date_of_birth'] as String?,
            address: row['address'] as String?,
            phone: row['phone'] as String?,
            enrollmentDate: row['enrollment_date'] as String?,
            isActive: (row['is_active'] as int) != 0,
            createdAt: row['created_at'] as String?,
            updatedAt: row['updated_at'] as String?),
        arguments: [searchTerm]);
  }

  @override
  Future<void> deleteStudentById(int id) async {
    await _queryAdapter
        .queryNoReturn('DELETE FROM students WHERE id = ?1', arguments: [id]);
  }

  @override
  Future<void> deleteStudentByStudentId(String studentId) async {
    await _queryAdapter.queryNoReturn(
        'DELETE FROM students WHERE student_id = ?1',
        arguments: [studentId]);
  }

  @override
  Future<void> deleteAllStudents() async {
    await _queryAdapter.queryNoReturn('DELETE FROM students');
  }

  @override
  Future<int?> getStudentCount() async {
    return _queryAdapter.query('SELECT COUNT(*) FROM students',
        mapper: (Map<String, Object?> row) => row.values.first as int);
  }

  @override
  Future<int?> getStudentCountByClass(String classId) async {
    return _queryAdapter.query(
        'SELECT COUNT(*) FROM students WHERE class_id = ?1',
        mapper: (Map<String, Object?> row) => row.values.first as int,
        arguments: [classId]);
  }

  @override
  Future<int?> getStudentCountByActiveStatus(bool isActive) async {
    return _queryAdapter.query(
        'SELECT COUNT(*) FROM students WHERE is_active = ?1',
        mapper: (Map<String, Object?> row) => row.values.first as int,
        arguments: [isActive ? 1 : 0]);
  }

  @override
  Future<void> insertStudent(StudentEntity student) async {
    await _studentEntityInsertionAdapter.insert(
        student, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertStudents(List<StudentEntity> students) async {
    await _studentEntityInsertionAdapter.insertList(
        students, OnConflictStrategy.replace);
  }

  @override
  Future<void> updateStudent(StudentEntity student) async {
    await _studentEntityUpdateAdapter.update(student, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteStudent(StudentEntity student) async {
    await _studentEntityDeletionAdapter.delete(student);
  }
}

class _$AssignmentDao extends AssignmentDao {
  _$AssignmentDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _assignmentEntityInsertionAdapter = InsertionAdapter(
            database,
            'assignments',
            (AssignmentEntity item) => <String, Object?>{
                  'id': item.id,
                  'assignment_id': item.assignmentId,
                  'title': item.title,
                  'description': item.description,
                  'class_id': item.classId,
                  'teacher_id': item.teacherId,
                  'due_date': item.dueDate,
                  'max_score': item.maxScore,
                  'assignment_type': item.assignmentType,
                  'instructions': item.instructions,
                  'attachments': item.attachments,
                  'is_published': item.isPublished ? 1 : 0,
                  'is_submitted': item.isSubmitted ? 1 : 0,
                  'created_at': item.createdAt,
                  'updated_at': item.updatedAt
                }),
        _assignmentEntityUpdateAdapter = UpdateAdapter(
            database,
            'assignments',
            ['id'],
            (AssignmentEntity item) => <String, Object?>{
                  'id': item.id,
                  'assignment_id': item.assignmentId,
                  'title': item.title,
                  'description': item.description,
                  'class_id': item.classId,
                  'teacher_id': item.teacherId,
                  'due_date': item.dueDate,
                  'max_score': item.maxScore,
                  'assignment_type': item.assignmentType,
                  'instructions': item.instructions,
                  'attachments': item.attachments,
                  'is_published': item.isPublished ? 1 : 0,
                  'is_submitted': item.isSubmitted ? 1 : 0,
                  'created_at': item.createdAt,
                  'updated_at': item.updatedAt
                }),
        _assignmentEntityDeletionAdapter = DeletionAdapter(
            database,
            'assignments',
            ['id'],
            (AssignmentEntity item) => <String, Object?>{
                  'id': item.id,
                  'assignment_id': item.assignmentId,
                  'title': item.title,
                  'description': item.description,
                  'class_id': item.classId,
                  'teacher_id': item.teacherId,
                  'due_date': item.dueDate,
                  'max_score': item.maxScore,
                  'assignment_type': item.assignmentType,
                  'instructions': item.instructions,
                  'attachments': item.attachments,
                  'is_published': item.isPublished ? 1 : 0,
                  'is_submitted': item.isSubmitted ? 1 : 0,
                  'created_at': item.createdAt,
                  'updated_at': item.updatedAt
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<AssignmentEntity> _assignmentEntityInsertionAdapter;

  final UpdateAdapter<AssignmentEntity> _assignmentEntityUpdateAdapter;

  final DeletionAdapter<AssignmentEntity> _assignmentEntityDeletionAdapter;

  @override
  Future<List<AssignmentEntity>> getAllAssignments() async {
    return _queryAdapter.queryList('SELECT * FROM assignments',
        mapper: (Map<String, Object?> row) => AssignmentEntity(
            id: row['id'] as int?,
            assignmentId: row['assignment_id'] as String,
            title: row['title'] as String,
            description: row['description'] as String,
            classId: row['class_id'] as String,
            teacherId: row['teacher_id'] as String,
            dueDate: row['due_date'] as String?,
            maxScore: row['max_score'] as double?,
            assignmentType: row['assignment_type'] as String?,
            instructions: row['instructions'] as String?,
            attachments: row['attachments'] as String?,
            isPublished: (row['is_published'] as int) != 0,
            isSubmitted: (row['is_submitted'] as int) != 0,
            createdAt: row['created_at'] as String?,
            updatedAt: row['updated_at'] as String?));
  }

  @override
  Future<AssignmentEntity?> getAssignmentById(int id) async {
    return _queryAdapter.query('SELECT * FROM assignments WHERE id = ?1',
        mapper: (Map<String, Object?> row) => AssignmentEntity(
            id: row['id'] as int?,
            assignmentId: row['assignment_id'] as String,
            title: row['title'] as String,
            description: row['description'] as String,
            classId: row['class_id'] as String,
            teacherId: row['teacher_id'] as String,
            dueDate: row['due_date'] as String?,
            maxScore: row['max_score'] as double?,
            assignmentType: row['assignment_type'] as String?,
            instructions: row['instructions'] as String?,
            attachments: row['attachments'] as String?,
            isPublished: (row['is_published'] as int) != 0,
            isSubmitted: (row['is_submitted'] as int) != 0,
            createdAt: row['created_at'] as String?,
            updatedAt: row['updated_at'] as String?),
        arguments: [id]);
  }

  @override
  Future<AssignmentEntity?> getAssignmentByAssignmentId(
      String assignmentId) async {
    return _queryAdapter.query(
        'SELECT * FROM assignments WHERE assignment_id = ?1',
        mapper: (Map<String, Object?> row) => AssignmentEntity(
            id: row['id'] as int?,
            assignmentId: row['assignment_id'] as String,
            title: row['title'] as String,
            description: row['description'] as String,
            classId: row['class_id'] as String,
            teacherId: row['teacher_id'] as String,
            dueDate: row['due_date'] as String?,
            maxScore: row['max_score'] as double?,
            assignmentType: row['assignment_type'] as String?,
            instructions: row['instructions'] as String?,
            attachments: row['attachments'] as String?,
            isPublished: (row['is_published'] as int) != 0,
            isSubmitted: (row['is_submitted'] as int) != 0,
            createdAt: row['created_at'] as String?,
            updatedAt: row['updated_at'] as String?),
        arguments: [assignmentId]);
  }

  @override
  Future<List<AssignmentEntity>> getAssignmentsByClassId(String classId) async {
    return _queryAdapter.queryList(
        'SELECT * FROM assignments WHERE class_id = ?1',
        mapper: (Map<String, Object?> row) => AssignmentEntity(
            id: row['id'] as int?,
            assignmentId: row['assignment_id'] as String,
            title: row['title'] as String,
            description: row['description'] as String,
            classId: row['class_id'] as String,
            teacherId: row['teacher_id'] as String,
            dueDate: row['due_date'] as String?,
            maxScore: row['max_score'] as double?,
            assignmentType: row['assignment_type'] as String?,
            instructions: row['instructions'] as String?,
            attachments: row['attachments'] as String?,
            isPublished: (row['is_published'] as int) != 0,
            isSubmitted: (row['is_submitted'] as int) != 0,
            createdAt: row['created_at'] as String?,
            updatedAt: row['updated_at'] as String?),
        arguments: [classId]);
  }

  @override
  Future<List<AssignmentEntity>> getAssignmentsByTeacherId(
      String teacherId) async {
    return _queryAdapter.queryList(
        'SELECT * FROM assignments WHERE teacher_id = ?1',
        mapper: (Map<String, Object?> row) => AssignmentEntity(
            id: row['id'] as int?,
            assignmentId: row['assignment_id'] as String,
            title: row['title'] as String,
            description: row['description'] as String,
            classId: row['class_id'] as String,
            teacherId: row['teacher_id'] as String,
            dueDate: row['due_date'] as String?,
            maxScore: row['max_score'] as double?,
            assignmentType: row['assignment_type'] as String?,
            instructions: row['instructions'] as String?,
            attachments: row['attachments'] as String?,
            isPublished: (row['is_published'] as int) != 0,
            isSubmitted: (row['is_submitted'] as int) != 0,
            createdAt: row['created_at'] as String?,
            updatedAt: row['updated_at'] as String?),
        arguments: [teacherId]);
  }

  @override
  Future<List<AssignmentEntity>> getAssignmentsByPublishedStatus(
      bool isPublished) async {
    return _queryAdapter.queryList(
        'SELECT * FROM assignments WHERE is_published = ?1',
        mapper: (Map<String, Object?> row) => AssignmentEntity(
            id: row['id'] as int?,
            assignmentId: row['assignment_id'] as String,
            title: row['title'] as String,
            description: row['description'] as String,
            classId: row['class_id'] as String,
            teacherId: row['teacher_id'] as String,
            dueDate: row['due_date'] as String?,
            maxScore: row['max_score'] as double?,
            assignmentType: row['assignment_type'] as String?,
            instructions: row['instructions'] as String?,
            attachments: row['attachments'] as String?,
            isPublished: (row['is_published'] as int) != 0,
            isSubmitted: (row['is_submitted'] as int) != 0,
            createdAt: row['created_at'] as String?,
            updatedAt: row['updated_at'] as String?),
        arguments: [isPublished ? 1 : 0]);
  }

  @override
  Future<List<AssignmentEntity>> getAssignmentsBySubmittedStatus(
      bool isSubmitted) async {
    return _queryAdapter.queryList(
        'SELECT * FROM assignments WHERE is_submitted = ?1',
        mapper: (Map<String, Object?> row) => AssignmentEntity(
            id: row['id'] as int?,
            assignmentId: row['assignment_id'] as String,
            title: row['title'] as String,
            description: row['description'] as String,
            classId: row['class_id'] as String,
            teacherId: row['teacher_id'] as String,
            dueDate: row['due_date'] as String?,
            maxScore: row['max_score'] as double?,
            assignmentType: row['assignment_type'] as String?,
            instructions: row['instructions'] as String?,
            attachments: row['attachments'] as String?,
            isPublished: (row['is_published'] as int) != 0,
            isSubmitted: (row['is_submitted'] as int) != 0,
            createdAt: row['created_at'] as String?,
            updatedAt: row['updated_at'] as String?),
        arguments: [isSubmitted ? 1 : 0]);
  }

  @override
  Future<List<AssignmentEntity>> getAssignmentsByType(
      String assignmentType) async {
    return _queryAdapter.queryList(
        'SELECT * FROM assignments WHERE assignment_type = ?1',
        mapper: (Map<String, Object?> row) => AssignmentEntity(
            id: row['id'] as int?,
            assignmentId: row['assignment_id'] as String,
            title: row['title'] as String,
            description: row['description'] as String,
            classId: row['class_id'] as String,
            teacherId: row['teacher_id'] as String,
            dueDate: row['due_date'] as String?,
            maxScore: row['max_score'] as double?,
            assignmentType: row['assignment_type'] as String?,
            instructions: row['instructions'] as String?,
            attachments: row['attachments'] as String?,
            isPublished: (row['is_published'] as int) != 0,
            isSubmitted: (row['is_submitted'] as int) != 0,
            createdAt: row['created_at'] as String?,
            updatedAt: row['updated_at'] as String?),
        arguments: [assignmentType]);
  }

  @override
  Future<List<AssignmentEntity>> getAssignmentsDueAfter(String date) async {
    return _queryAdapter.queryList(
        'SELECT * FROM assignments WHERE due_date >= ?1',
        mapper: (Map<String, Object?> row) => AssignmentEntity(
            id: row['id'] as int?,
            assignmentId: row['assignment_id'] as String,
            title: row['title'] as String,
            description: row['description'] as String,
            classId: row['class_id'] as String,
            teacherId: row['teacher_id'] as String,
            dueDate: row['due_date'] as String?,
            maxScore: row['max_score'] as double?,
            assignmentType: row['assignment_type'] as String?,
            instructions: row['instructions'] as String?,
            attachments: row['attachments'] as String?,
            isPublished: (row['is_published'] as int) != 0,
            isSubmitted: (row['is_submitted'] as int) != 0,
            createdAt: row['created_at'] as String?,
            updatedAt: row['updated_at'] as String?),
        arguments: [date]);
  }

  @override
  Future<List<AssignmentEntity>> searchAssignments(String searchTerm) async {
    return _queryAdapter.queryList(
        'SELECT * FROM assignments WHERE title LIKE ?1 OR description LIKE ?1',
        mapper: (Map<String, Object?> row) => AssignmentEntity(
            id: row['id'] as int?,
            assignmentId: row['assignment_id'] as String,
            title: row['title'] as String,
            description: row['description'] as String,
            classId: row['class_id'] as String,
            teacherId: row['teacher_id'] as String,
            dueDate: row['due_date'] as String?,
            maxScore: row['max_score'] as double?,
            assignmentType: row['assignment_type'] as String?,
            instructions: row['instructions'] as String?,
            attachments: row['attachments'] as String?,
            isPublished: (row['is_published'] as int) != 0,
            isSubmitted: (row['is_submitted'] as int) != 0,
            createdAt: row['created_at'] as String?,
            updatedAt: row['updated_at'] as String?),
        arguments: [searchTerm]);
  }

  @override
  Future<void> deleteAssignmentById(int id) async {
    await _queryAdapter.queryNoReturn('DELETE FROM assignments WHERE id = ?1',
        arguments: [id]);
  }

  @override
  Future<void> deleteAssignmentByAssignmentId(String assignmentId) async {
    await _queryAdapter.queryNoReturn(
        'DELETE FROM assignments WHERE assignment_id = ?1',
        arguments: [assignmentId]);
  }

  @override
  Future<void> deleteAssignmentsByClassId(String classId) async {
    await _queryAdapter.queryNoReturn(
        'DELETE FROM assignments WHERE class_id = ?1',
        arguments: [classId]);
  }

  @override
  Future<void> deleteAllAssignments() async {
    await _queryAdapter.queryNoReturn('DELETE FROM assignments');
  }

  @override
  Future<int?> getAssignmentCount() async {
    return _queryAdapter.query('SELECT COUNT(*) FROM assignments',
        mapper: (Map<String, Object?> row) => row.values.first as int);
  }

  @override
  Future<int?> getAssignmentCountByClass(String classId) async {
    return _queryAdapter.query(
        'SELECT COUNT(*) FROM assignments WHERE class_id = ?1',
        mapper: (Map<String, Object?> row) => row.values.first as int,
        arguments: [classId]);
  }

  @override
  Future<int?> getAssignmentCountByTeacher(String teacherId) async {
    return _queryAdapter.query(
        'SELECT COUNT(*) FROM assignments WHERE teacher_id = ?1',
        mapper: (Map<String, Object?> row) => row.values.first as int,
        arguments: [teacherId]);
  }

  @override
  Future<int?> getAssignmentCountByPublishedStatus(bool isPublished) async {
    return _queryAdapter.query(
        'SELECT COUNT(*) FROM assignments WHERE is_published = ?1',
        mapper: (Map<String, Object?> row) => row.values.first as int,
        arguments: [isPublished ? 1 : 0]);
  }

  @override
  Future<void> insertAssignment(AssignmentEntity assignment) async {
    await _assignmentEntityInsertionAdapter.insert(
        assignment, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertAssignments(List<AssignmentEntity> assignments) async {
    await _assignmentEntityInsertionAdapter.insertList(
        assignments, OnConflictStrategy.replace);
  }

  @override
  Future<void> updateAssignment(AssignmentEntity assignment) async {
    await _assignmentEntityUpdateAdapter.update(
        assignment, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteAssignment(AssignmentEntity assignment) async {
    await _assignmentEntityDeletionAdapter.delete(assignment);
  }
}

class _$GradeDao extends GradeDao {
  _$GradeDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _gradeEntityInsertionAdapter = InsertionAdapter(
            database,
            'grades',
            (GradeEntity item) => <String, Object?>{
                  'id': item.id,
                  'grade_id': item.gradeId,
                  'student_id': item.studentId,
                  'assignment_id': item.assignmentId,
                  'class_id': item.classId,
                  'score': item.score,
                  'max_score': item.maxScore,
                  'comments': item.comments,
                  'feedback': item.feedback,
                  'graded_by': item.gradedBy,
                  'graded_at': item.gradedAt,
                  'is_submitted': item.isSubmitted ? 1 : 0,
                  'submitted_at': item.submittedAt,
                  'created_at': item.createdAt,
                  'updated_at': item.updatedAt
                }),
        _gradeEntityUpdateAdapter = UpdateAdapter(
            database,
            'grades',
            ['id'],
            (GradeEntity item) => <String, Object?>{
                  'id': item.id,
                  'grade_id': item.gradeId,
                  'student_id': item.studentId,
                  'assignment_id': item.assignmentId,
                  'class_id': item.classId,
                  'score': item.score,
                  'max_score': item.maxScore,
                  'comments': item.comments,
                  'feedback': item.feedback,
                  'graded_by': item.gradedBy,
                  'graded_at': item.gradedAt,
                  'is_submitted': item.isSubmitted ? 1 : 0,
                  'submitted_at': item.submittedAt,
                  'created_at': item.createdAt,
                  'updated_at': item.updatedAt
                }),
        _gradeEntityDeletionAdapter = DeletionAdapter(
            database,
            'grades',
            ['id'],
            (GradeEntity item) => <String, Object?>{
                  'id': item.id,
                  'grade_id': item.gradeId,
                  'student_id': item.studentId,
                  'assignment_id': item.assignmentId,
                  'class_id': item.classId,
                  'score': item.score,
                  'max_score': item.maxScore,
                  'comments': item.comments,
                  'feedback': item.feedback,
                  'graded_by': item.gradedBy,
                  'graded_at': item.gradedAt,
                  'is_submitted': item.isSubmitted ? 1 : 0,
                  'submitted_at': item.submittedAt,
                  'created_at': item.createdAt,
                  'updated_at': item.updatedAt
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<GradeEntity> _gradeEntityInsertionAdapter;

  final UpdateAdapter<GradeEntity> _gradeEntityUpdateAdapter;

  final DeletionAdapter<GradeEntity> _gradeEntityDeletionAdapter;

  @override
  Future<List<GradeEntity>> getAllGrades() async {
    return _queryAdapter.queryList('SELECT * FROM grades',
        mapper: (Map<String, Object?> row) => GradeEntity(
            id: row['id'] as int?,
            gradeId: row['grade_id'] as String,
            studentId: row['student_id'] as String,
            assignmentId: row['assignment_id'] as String,
            classId: row['class_id'] as String,
            score: row['score'] as double,
            maxScore: row['max_score'] as double,
            comments: row['comments'] as String?,
            feedback: row['feedback'] as String?,
            gradedBy: row['graded_by'] as String?,
            gradedAt: row['graded_at'] as String?,
            isSubmitted: (row['is_submitted'] as int) != 0,
            submittedAt: row['submitted_at'] as String?,
            createdAt: row['created_at'] as String?,
            updatedAt: row['updated_at'] as String?));
  }

  @override
  Future<GradeEntity?> getGradeById(int id) async {
    return _queryAdapter.query('SELECT * FROM grades WHERE id = ?1',
        mapper: (Map<String, Object?> row) => GradeEntity(
            id: row['id'] as int?,
            gradeId: row['grade_id'] as String,
            studentId: row['student_id'] as String,
            assignmentId: row['assignment_id'] as String,
            classId: row['class_id'] as String,
            score: row['score'] as double,
            maxScore: row['max_score'] as double,
            comments: row['comments'] as String?,
            feedback: row['feedback'] as String?,
            gradedBy: row['graded_by'] as String?,
            gradedAt: row['graded_at'] as String?,
            isSubmitted: (row['is_submitted'] as int) != 0,
            submittedAt: row['submitted_at'] as String?,
            createdAt: row['created_at'] as String?,
            updatedAt: row['updated_at'] as String?),
        arguments: [id]);
  }

  @override
  Future<GradeEntity?> getGradeByGradeId(String gradeId) async {
    return _queryAdapter.query('SELECT * FROM grades WHERE grade_id = ?1',
        mapper: (Map<String, Object?> row) => GradeEntity(
            id: row['id'] as int?,
            gradeId: row['grade_id'] as String,
            studentId: row['student_id'] as String,
            assignmentId: row['assignment_id'] as String,
            classId: row['class_id'] as String,
            score: row['score'] as double,
            maxScore: row['max_score'] as double,
            comments: row['comments'] as String?,
            feedback: row['feedback'] as String?,
            gradedBy: row['graded_by'] as String?,
            gradedAt: row['graded_at'] as String?,
            isSubmitted: (row['is_submitted'] as int) != 0,
            submittedAt: row['submitted_at'] as String?,
            createdAt: row['created_at'] as String?,
            updatedAt: row['updated_at'] as String?),
        arguments: [gradeId]);
  }

  @override
  Future<List<GradeEntity>> getGradesByStudentId(String studentId) async {
    return _queryAdapter.queryList('SELECT * FROM grades WHERE student_id = ?1',
        mapper: (Map<String, Object?> row) => GradeEntity(
            id: row['id'] as int?,
            gradeId: row['grade_id'] as String,
            studentId: row['student_id'] as String,
            assignmentId: row['assignment_id'] as String,
            classId: row['class_id'] as String,
            score: row['score'] as double,
            maxScore: row['max_score'] as double,
            comments: row['comments'] as String?,
            feedback: row['feedback'] as String?,
            gradedBy: row['graded_by'] as String?,
            gradedAt: row['graded_at'] as String?,
            isSubmitted: (row['is_submitted'] as int) != 0,
            submittedAt: row['submitted_at'] as String?,
            createdAt: row['created_at'] as String?,
            updatedAt: row['updated_at'] as String?),
        arguments: [studentId]);
  }

  @override
  Future<List<GradeEntity>> getGradesByAssignmentId(String assignmentId) async {
    return _queryAdapter.queryList(
        'SELECT * FROM grades WHERE assignment_id = ?1',
        mapper: (Map<String, Object?> row) => GradeEntity(
            id: row['id'] as int?,
            gradeId: row['grade_id'] as String,
            studentId: row['student_id'] as String,
            assignmentId: row['assignment_id'] as String,
            classId: row['class_id'] as String,
            score: row['score'] as double,
            maxScore: row['max_score'] as double,
            comments: row['comments'] as String?,
            feedback: row['feedback'] as String?,
            gradedBy: row['graded_by'] as String?,
            gradedAt: row['graded_at'] as String?,
            isSubmitted: (row['is_submitted'] as int) != 0,
            submittedAt: row['submitted_at'] as String?,
            createdAt: row['created_at'] as String?,
            updatedAt: row['updated_at'] as String?),
        arguments: [assignmentId]);
  }

  @override
  Future<List<GradeEntity>> getGradesByClassId(String classId) async {
    return _queryAdapter.queryList('SELECT * FROM grades WHERE class_id = ?1',
        mapper: (Map<String, Object?> row) => GradeEntity(
            id: row['id'] as int?,
            gradeId: row['grade_id'] as String,
            studentId: row['student_id'] as String,
            assignmentId: row['assignment_id'] as String,
            classId: row['class_id'] as String,
            score: row['score'] as double,
            maxScore: row['max_score'] as double,
            comments: row['comments'] as String?,
            feedback: row['feedback'] as String?,
            gradedBy: row['graded_by'] as String?,
            gradedAt: row['graded_at'] as String?,
            isSubmitted: (row['is_submitted'] as int) != 0,
            submittedAt: row['submitted_at'] as String?,
            createdAt: row['created_at'] as String?,
            updatedAt: row['updated_at'] as String?),
        arguments: [classId]);
  }

  @override
  Future<List<GradeEntity>> getGradesByStudentAndClass(
    String studentId,
    String classId,
  ) async {
    return _queryAdapter.queryList(
        'SELECT * FROM grades WHERE student_id = ?1 AND class_id = ?2',
        mapper: (Map<String, Object?> row) => GradeEntity(
            id: row['id'] as int?,
            gradeId: row['grade_id'] as String,
            studentId: row['student_id'] as String,
            assignmentId: row['assignment_id'] as String,
            classId: row['class_id'] as String,
            score: row['score'] as double,
            maxScore: row['max_score'] as double,
            comments: row['comments'] as String?,
            feedback: row['feedback'] as String?,
            gradedBy: row['graded_by'] as String?,
            gradedAt: row['graded_at'] as String?,
            isSubmitted: (row['is_submitted'] as int) != 0,
            submittedAt: row['submitted_at'] as String?,
            createdAt: row['created_at'] as String?,
            updatedAt: row['updated_at'] as String?),
        arguments: [studentId, classId]);
  }

  @override
  Future<List<GradeEntity>> getGradesBySubmittedStatus(bool isSubmitted) async {
    return _queryAdapter.queryList(
        'SELECT * FROM grades WHERE is_submitted = ?1',
        mapper: (Map<String, Object?> row) => GradeEntity(
            id: row['id'] as int?,
            gradeId: row['grade_id'] as String,
            studentId: row['student_id'] as String,
            assignmentId: row['assignment_id'] as String,
            classId: row['class_id'] as String,
            score: row['score'] as double,
            maxScore: row['max_score'] as double,
            comments: row['comments'] as String?,
            feedback: row['feedback'] as String?,
            gradedBy: row['graded_by'] as String?,
            gradedAt: row['graded_at'] as String?,
            isSubmitted: (row['is_submitted'] as int) != 0,
            submittedAt: row['submitted_at'] as String?,
            createdAt: row['created_at'] as String?,
            updatedAt: row['updated_at'] as String?),
        arguments: [isSubmitted ? 1 : 0]);
  }

  @override
  Future<List<GradeEntity>> getGradesAboveScore(double minScore) async {
    return _queryAdapter.queryList('SELECT * FROM grades WHERE score >= ?1',
        mapper: (Map<String, Object?> row) => GradeEntity(
            id: row['id'] as int?,
            gradeId: row['grade_id'] as String,
            studentId: row['student_id'] as String,
            assignmentId: row['assignment_id'] as String,
            classId: row['class_id'] as String,
            score: row['score'] as double,
            maxScore: row['max_score'] as double,
            comments: row['comments'] as String?,
            feedback: row['feedback'] as String?,
            gradedBy: row['graded_by'] as String?,
            gradedAt: row['graded_at'] as String?,
            isSubmitted: (row['is_submitted'] as int) != 0,
            submittedAt: row['submitted_at'] as String?,
            createdAt: row['created_at'] as String?,
            updatedAt: row['updated_at'] as String?),
        arguments: [minScore]);
  }

  @override
  Future<List<GradeEntity>> getGradesBelowScore(double maxScore) async {
    return _queryAdapter.queryList('SELECT * FROM grades WHERE score <= ?1',
        mapper: (Map<String, Object?> row) => GradeEntity(
            id: row['id'] as int?,
            gradeId: row['grade_id'] as String,
            studentId: row['student_id'] as String,
            assignmentId: row['assignment_id'] as String,
            classId: row['class_id'] as String,
            score: row['score'] as double,
            maxScore: row['max_score'] as double,
            comments: row['comments'] as String?,
            feedback: row['feedback'] as String?,
            gradedBy: row['graded_by'] as String?,
            gradedAt: row['graded_at'] as String?,
            isSubmitted: (row['is_submitted'] as int) != 0,
            submittedAt: row['submitted_at'] as String?,
            createdAt: row['created_at'] as String?,
            updatedAt: row['updated_at'] as String?),
        arguments: [maxScore]);
  }

  @override
  Future<double?> getAverageGradeByStudentAndClass(
    String studentId,
    String classId,
  ) async {
    return _queryAdapter.query(
        'SELECT AVG(score) FROM grades WHERE student_id = ?1 AND class_id = ?2',
        mapper: (Map<String, Object?> row) => row.values.first as double,
        arguments: [studentId, classId]);
  }

  @override
  Future<double?> getAverageGradeByClass(String classId) async {
    return _queryAdapter.query(
        'SELECT AVG(score) FROM grades WHERE class_id = ?1',
        mapper: (Map<String, Object?> row) => row.values.first as double,
        arguments: [classId]);
  }

  @override
  Future<double?> getAverageGradeByAssignment(String assignmentId) async {
    return _queryAdapter.query(
        'SELECT AVG(score) FROM grades WHERE assignment_id = ?1',
        mapper: (Map<String, Object?> row) => row.values.first as double,
        arguments: [assignmentId]);
  }

  @override
  Future<void> deleteGradeById(int id) async {
    await _queryAdapter
        .queryNoReturn('DELETE FROM grades WHERE id = ?1', arguments: [id]);
  }

  @override
  Future<void> deleteGradeByGradeId(String gradeId) async {
    await _queryAdapter.queryNoReturn('DELETE FROM grades WHERE grade_id = ?1',
        arguments: [gradeId]);
  }

  @override
  Future<void> deleteGradesByStudentId(String studentId) async {
    await _queryAdapter.queryNoReturn(
        'DELETE FROM grades WHERE student_id = ?1',
        arguments: [studentId]);
  }

  @override
  Future<void> deleteGradesByAssignmentId(String assignmentId) async {
    await _queryAdapter.queryNoReturn(
        'DELETE FROM grades WHERE assignment_id = ?1',
        arguments: [assignmentId]);
  }

  @override
  Future<void> deleteGradesByClassId(String classId) async {
    await _queryAdapter.queryNoReturn('DELETE FROM grades WHERE class_id = ?1',
        arguments: [classId]);
  }

  @override
  Future<void> deleteAllGrades() async {
    await _queryAdapter.queryNoReturn('DELETE FROM grades');
  }

  @override
  Future<int?> getGradeCount() async {
    return _queryAdapter.query('SELECT COUNT(*) FROM grades',
        mapper: (Map<String, Object?> row) => row.values.first as int);
  }

  @override
  Future<int?> getGradeCountByStudent(String studentId) async {
    return _queryAdapter.query(
        'SELECT COUNT(*) FROM grades WHERE student_id = ?1',
        mapper: (Map<String, Object?> row) => row.values.first as int,
        arguments: [studentId]);
  }

  @override
  Future<int?> getGradeCountByClass(String classId) async {
    return _queryAdapter.query(
        'SELECT COUNT(*) FROM grades WHERE class_id = ?1',
        mapper: (Map<String, Object?> row) => row.values.first as int,
        arguments: [classId]);
  }

  @override
  Future<int?> getGradeCountByAssignment(String assignmentId) async {
    return _queryAdapter.query(
        'SELECT COUNT(*) FROM grades WHERE assignment_id = ?1',
        mapper: (Map<String, Object?> row) => row.values.first as int,
        arguments: [assignmentId]);
  }

  @override
  Future<void> insertGrade(GradeEntity grade) async {
    await _gradeEntityInsertionAdapter.insert(
        grade, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertGrades(List<GradeEntity> grades) async {
    await _gradeEntityInsertionAdapter.insertList(
        grades, OnConflictStrategy.replace);
  }

  @override
  Future<void> updateGrade(GradeEntity grade) async {
    await _gradeEntityUpdateAdapter.update(grade, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteGrade(GradeEntity grade) async {
    await _gradeEntityDeletionAdapter.delete(grade);
  }
}

class _$ClassDao extends ClassDao {
  _$ClassDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _classEntityInsertionAdapter = InsertionAdapter(
            database,
            'classes',
            (ClassEntity item) => <String, Object?>{
                  'id': item.id,
                  'class_id': item.classId,
                  'name': item.name,
                  'description': item.description,
                  'teacher_id': item.teacherId,
                  'subject_id': item.subjectId,
                  'academic_year': item.academicYear,
                  'schedule': item.schedule,
                  'room': item.room,
                  'max_students': item.maxStudents,
                  'is_active': item.isActive ? 1 : 0,
                  'start_date': item.startDate,
                  'end_date': item.endDate,
                  'created_at': item.createdAt,
                  'updated_at': item.updatedAt
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<ClassEntity> _classEntityInsertionAdapter;

  @override
  Future<List<ClassEntity>> findAllClasses() async {
    return _queryAdapter.queryList('SELECT * FROM classes',
        mapper: (Map<String, Object?> row) => ClassEntity(
            id: row['id'] as int?,
            classId: row['class_id'] as String,
            name: row['name'] as String,
            description: row['description'] as String?,
            teacherId: row['teacher_id'] as String,
            subjectId: row['subject_id'] as String?,
            academicYear: row['academic_year'] as String?,
            schedule: row['schedule'] as String?,
            room: row['room'] as String?,
            maxStudents: row['max_students'] as int?,
            isActive: (row['is_active'] as int) != 0,
            startDate: row['start_date'] as String?,
            endDate: row['end_date'] as String?,
            createdAt: row['created_at'] as String?,
            updatedAt: row['updated_at'] as String?));
  }

  @override
  Future<void> deleteAllClasses() async {
    await _queryAdapter.queryNoReturn('DELETE FROM classes');
  }

  @override
  Future<int?> getClassCount() async {
    return _queryAdapter.query('SELECT COUNT(*) FROM classes',
        mapper: (Map<String, Object?> row) => row.values.first as int);
  }

  @override
  Future<List<ClassEntity>> getClassesByTeacherId(String teacherId) async {
    return _queryAdapter.queryList(
        'SELECT * FROM classes WHERE teacher_id = ?1',
        mapper: (Map<String, Object?> row) => ClassEntity(
            id: row['id'] as int?,
            classId: row['class_id'] as String,
            name: row['name'] as String,
            description: row['description'] as String?,
            teacherId: row['teacher_id'] as String,
            subjectId: row['subject_id'] as String?,
            academicYear: row['academic_year'] as String?,
            schedule: row['schedule'] as String?,
            room: row['room'] as String?,
            maxStudents: row['max_students'] as int?,
            isActive: (row['is_active'] as int) != 0,
            startDate: row['start_date'] as String?,
            endDate: row['end_date'] as String?,
            createdAt: row['created_at'] as String?,
            updatedAt: row['updated_at'] as String?),
        arguments: [teacherId]);
  }

  @override
  Future<void> insertClass(ClassEntity classEntity) async {
    await _classEntityInsertionAdapter.insert(
        classEntity, OnConflictStrategy.abort);
  }
}

class _$AttendanceDao extends AttendanceDao {
  _$AttendanceDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _attendanceEntityInsertionAdapter = InsertionAdapter(
            database,
            'attendance',
            (AttendanceEntity item) => <String, Object?>{
                  'id': item.id,
                  'attendance_id': item.attendanceId,
                  'student_id': item.studentId,
                  'class_id': item.classId,
                  'date': item.date,
                  'status': item.status,
                  'reason': item.reason,
                  'notes': item.notes,
                  'marked_by': item.markedBy,
                  'marked_at': item.markedAt,
                  'created_at': item.createdAt,
                  'updated_at': item.updatedAt
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<AttendanceEntity> _attendanceEntityInsertionAdapter;

  @override
  Future<List<AttendanceEntity>> findAllAttendance() async {
    return _queryAdapter.queryList('SELECT * FROM attendance',
        mapper: (Map<String, Object?> row) => AttendanceEntity(
            id: row['id'] as int?,
            attendanceId: row['attendance_id'] as String,
            studentId: row['student_id'] as String,
            classId: row['class_id'] as String,
            date: row['date'] as String,
            status: row['status'] as String,
            reason: row['reason'] as String?,
            notes: row['notes'] as String?,
            markedBy: row['marked_by'] as String?,
            markedAt: row['marked_at'] as String?,
            createdAt: row['created_at'] as String?,
            updatedAt: row['updated_at'] as String?));
  }

  @override
  Future<void> deleteAllAttendance() async {
    await _queryAdapter.queryNoReturn('DELETE FROM attendance');
  }

  @override
  Future<int?> getAttendanceCount() async {
    return _queryAdapter.query('SELECT COUNT(*) FROM attendance',
        mapper: (Map<String, Object?> row) => row.values.first as int);
  }

  @override
  Future<List<AttendanceEntity>> getAttendanceByStudentId(
      String studentId) async {
    return _queryAdapter.queryList(
        'SELECT * FROM attendance WHERE student_id = ?1',
        mapper: (Map<String, Object?> row) => AttendanceEntity(
            id: row['id'] as int?,
            attendanceId: row['attendance_id'] as String,
            studentId: row['student_id'] as String,
            classId: row['class_id'] as String,
            date: row['date'] as String,
            status: row['status'] as String,
            reason: row['reason'] as String?,
            notes: row['notes'] as String?,
            markedBy: row['marked_by'] as String?,
            markedAt: row['marked_at'] as String?,
            createdAt: row['created_at'] as String?,
            updatedAt: row['updated_at'] as String?),
        arguments: [studentId]);
  }

  @override
  Future<void> insertAttendance(AttendanceEntity attendanceEntity) async {
    await _attendanceEntityInsertionAdapter.insert(
        attendanceEntity, OnConflictStrategy.abort);
  }
}
