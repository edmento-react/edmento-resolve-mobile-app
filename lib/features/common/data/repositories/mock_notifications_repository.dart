import 'dart:async';

import '../../notifications.dart'
    show
        AppNotification,
        INotificationsRepository,
        NotificationFilter,
        NotificationType;

class MockNotificationsRepository implements INotificationsRepository {
  final _avatars = const [
    'https://i.pravatar.cc/100?img=10',
    'https://i.pravatar.cc/100?img=12',
    'https://i.pravatar.cc/100?img=14',
    'https://i.pravatar.cc/100?img=15',
    'https://i.pravatar.cc/100?img=18',
  ];

  NotificationType _typeByIndex(int i) {
    switch (i % 5) {
      case 0:
        return NotificationType.system;
      case 1:
        return NotificationType.activity;
      case 2:
        return NotificationType.message;
      case 3:
        return NotificationType.task;
      default:
        return NotificationType.alert;
    }
  }

  @override
  Future<List<AppNotification>> fetch({
    required int page,
    required int pageSize,
    required NotificationFilter filter,
  }) async {
    await Future.delayed(const Duration(milliseconds: 700));

    final startIndex = page * pageSize;
    final items = List.generate(pageSize, (i) {
      final idx = startIndex + i;
      final dt = DateTime.now().subtract(
        Duration(hours: (idx % 30) + (page * 2), minutes: idx % 60),
      );
      final t = _typeByIndex(idx);
      final isRead = idx % 4 != 0; // ~25% unread

      return AppNotification(
        id: 'n_$idx',
        title: switch (t) {
          NotificationType.system => 'System maintenance scheduled',
          NotificationType.activity => 'New comment on your post',
          NotificationType.message => 'New message from Parent',
          NotificationType.task => 'Task assigned: Prepare Syllabus',
          NotificationType.alert => 'Attendance alert for Class 7A',
        },
        body: 'This is a sample notification body for item #$idx.',
        createdAt: dt,
        isRead: isRead,
        type: t,
        avatarUrl: idx % 3 == 0 ? _avatars[idx % _avatars.length] : null,
      );
    });

    // Apply filter
    final filtered = items.where((n) {
      switch (filter) {
        case NotificationFilter.all:
          return true;
        case NotificationFilter.unread:
          return !n.isRead;
        case NotificationFilter.system:
          return n.type == NotificationType.system ||
              n.type == NotificationType.alert;
        case NotificationFilter.activity:
          return n.type == NotificationType.activity ||
              n.type == NotificationType.task ||
              n.type == NotificationType.message;
      }
    }).toList();

    return filtered;
  }
}
