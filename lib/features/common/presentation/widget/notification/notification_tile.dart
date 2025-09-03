import 'package:cached_network_image/cached_network_image.dart';
import 'package:edmentoresolve/core/widgets/text_widget.dart';
import 'package:edmentoresolve/features/common/domain/entities/app_notification.dart';
import 'package:edmentoresolve/features/common/domain/enums/notification_type.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'swipe_background.dart';

class NotificationTile extends StatelessWidget {
  final AppNotification item;
  final VoidCallback onTap;
  final VoidCallback onToggleRead;
  final VoidCallback onDelete;

  const NotificationTile({
    super.key,
    required this.item,
    required this.onTap,
    required this.onToggleRead,
    required this.onDelete,
  });

  IconData _iconByType(NotificationType t) {
    switch (t) {
      case NotificationType.system:
        return CupertinoIcons.gear_alt_fill;
      case NotificationType.activity:
        return CupertinoIcons.bolt_fill;
      case NotificationType.message:
        return CupertinoIcons.chat_bubble_2_fill;
      case NotificationType.task:
        return CupertinoIcons.checkmark_square_fill;
      case NotificationType.alert:
        return CupertinoIcons.exclamationmark_triangle_fill;
    }
  }

  Color _tintByType(BuildContext context, NotificationType t) {
    final cs = Theme.of(context).colorScheme;
    switch (t) {
      case NotificationType.system:
        return cs.primary.withOpacity(.18);
      case NotificationType.activity:
        return Colors.indigo.withOpacity(.18);
      case NotificationType.message:
        return Colors.teal.withOpacity(.18);
      case NotificationType.task:
        return Colors.green.withOpacity(.18);
      case NotificationType.alert:
        return Colors.orange.withOpacity(.18);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final time = DateFormat('h:mm a').format(item.createdAt);
    final titleStyle = theme.textTheme.titleMedium?.copyWith(
      fontWeight: item.isRead ? FontWeight.w500 : FontWeight.w700,
    );
    final bodyStyle = theme.textTheme.bodyMedium?.copyWith(
      color: theme.textTheme.bodyMedium?.color?.withOpacity(.85),
    );

    return Dismissible(
      key: ValueKey(item.id),
      background: SwipeBackground(
        color: Colors.green,
        icon: item.isRead
            ? CupertinoIcons.envelope_badge
            : CupertinoIcons.envelope_open_fill,
        text: item.isRead ? 'Mark unread' : 'Mark read',
        alignLeft: true,
      ),
      secondaryBackground: const SwipeBackground(
        color: Colors.redAccent,
        icon: CupertinoIcons.delete_solid,
        text: 'Delete',
        alignLeft: false,
      ),
      confirmDismiss: (dir) async {
        if (dir == DismissDirection.startToEnd) {
          onToggleRead();
          return false; // Keep in list
        } else {
          onDelete();
          return true; // Remove
        }
      },
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            border: Border.all(color: theme.dividerColor),
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Leading
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: _tintByType(context, item.type),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: item.avatarUrl != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: CachedNetworkImage(
                          imageUrl: item.avatarUrl!,
                          fit: BoxFit.cover,
                          placeholder: (_, __) => const SizedBox.shrink(),
                          errorWidget: (_, __, ___) =>
                              Icon(_iconByType(item.type)),
                        ),
                      )
                    : Icon(_iconByType(item.type)),
              ),
              const SizedBox(width: 12),

              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title row
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: TextWidget.body(
                            item.title,
                            context: context,
                            fontWeight: item.isRead ? FontWeight.w500 : FontWeight.w700,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            TextWidget.small(time, context: context),
                            const SizedBox(height: 6),
                            if (!item.isRead)
                              Container(
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: theme.colorScheme.primary,
                                  shape: BoxShape.circle,
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    TextWidget.body(
                      item.body,
                      context: context,
                      color: theme.textTheme.bodyMedium?.color?.withOpacity(.85),
                    ),
                    const SizedBox(height: 10),

                    // Inline actions
                    Row(
                      children: [
                        TextButton.icon(
                          onPressed: onToggleRead,
                          icon: Icon(
                            item.isRead
                                ? CupertinoIcons.envelope_badge
                                : CupertinoIcons.envelope_open_fill,
                            size: 16,
                          ),
                          label: TextWidget.label(
                            item.isRead ? 'Mark unread' : 'Mark read',
                            context: context,
                          ),
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 6,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        TextButton.icon(
                          onPressed: onDelete,
                          icon: const Icon(CupertinoIcons.delete, size: 16),
                          label: TextWidget.label('Delete', context: context),
                          style: TextButton.styleFrom(
                            foregroundColor: theme.colorScheme.error,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 6,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
