import '../entities/task.dart';

abstract class ITasksRepository {
  Future<List<Task>> fetch({required int page, required int pageSize});
}
