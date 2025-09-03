import '../entities/app_notification.dart';

enum NotificationFilter { all, unread, system, activity }

abstract class INotificationsRepository {
  Future<List<AppNotification>> fetch({
    required int page,
    required int pageSize,
    required NotificationFilter filter,
  });
}
