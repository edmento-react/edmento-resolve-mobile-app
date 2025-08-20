import 'package:floor/floor.dart';

import '../entities/class_entity.dart';

@dao
abstract class ClassDao {
  @Query('SELECT * FROM classes')
  Future<List<ClassEntity>> findAllClasses();

  @insert
  Future<void> insertClass(ClassEntity classEntity);

  @Query('DELETE FROM classes')
  Future<void> deleteAllClasses();

  @Query('SELECT COUNT(*) FROM classes')
  Future<int?> getClassCount();

  @Query('SELECT * FROM classes WHERE teacher_id = :teacherId')
  Future<List<ClassEntity>> getClassesByTeacherId(String teacherId);
}
