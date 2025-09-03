import 'dart:async';

import 'package:intl/intl.dart';

import '../../domain/entities/task.dart';
import '../../domain/repositories/tasks_repository.dart';

class MockTasksRepository implements ITasksRepository {
  @override
  Future<List<Task>> fetch({required int page, required int pageSize}) async {
    await Future.delayed(const Duration(milliseconds: 500));

    // Make stable sample that looks like your screenshot
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day, 10, 0);
    final tomorrow = DateTime(now.year, now.month, now.day + 1, 10, 0);
    final sep5 = DateFormat('yyyy-MM-dd').parse('${now.year}-09-05');

    final people = [
      const TaskAssignee(
        id: '1',
        name: 'Alice',
        avatarUrl: 'https://i.pravatar.cc/100?img=11',
      ),
      const TaskAssignee(
        id: '2',
        name: 'Ken',
        avatarUrl: 'https://i.pravatar.cc/100?img=12',
      ),
      const TaskAssignee(
        id: '3',
        name: 'Mary',
        avatarUrl: 'https://i.pravatar.cc/100?img=13',
      ),
      const TaskAssignee(
        id: '4',
        name: 'John',
        avatarUrl: 'https://i.pravatar.cc/100?img=14',
      ),
      const TaskAssignee(
        id: '5',
        name: 'Leo',
        avatarUrl: 'https://i.pravatar.cc/100?img=15',
      ),
    ];

    final list = <Task>[
      Task(
        id: 't_1',
        title: 'Timetable',
        description:
            'Draft subject-wise exam dates with proper spacing and no clashes.',
        dueAt: today,
        commentsCount: 2,
        attachmentsCount: 3,
        priority: TaskPriority.normal,
        assignees: [people[0], people[1]],
      ),
      Task(
        id: 't_2',
        title: 'Worksheet',
        description:
            'Draft subject-wise exam dates with proper spacing and no clashes.',
        dueAt: sep5,
        commentsCount: 2,
        attachmentsCount: 0,
        priority: TaskPriority.high, // shows alert chip (red)
        assignees: [people[2], people[3], people[4]],
      ),
      Task(
        id: 't_3',
        title: 'Project',
        description:
            'Draft subject-wise exam dates with proper spacing and no clashes.',
        dueAt: tomorrow,
        commentsCount: 2,
        attachmentsCount: 3,
        priority: TaskPriority.normal,
        assignees: [people[0], people[1]],
      ),
      Task(
        id: 't_4',
        title: 'Prepare Exam Timetable',
        description:
            'Draft subject-wise exam dates with proper spacing and no clashes.',
        dueAt: today,
        commentsCount: 0,
        attachmentsCount: 0,
        priority: TaskPriority.normal,
        assignees: [people[0], people[1]],
      ),
    ];

    // paginate (static demo)
    final start = page * pageSize;
    final end = (start + pageSize).clamp(0, list.length);
    if (start >= list.length) return [];
    return list.sublist(start, end);
  }
}
