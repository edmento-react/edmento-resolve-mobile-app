import 'package:cached_network_image/cached_network_image.dart';
import 'package:edmentoresolve/core/widgets/text_widget.dart';
import 'package:edmentoresolve/features/teacher/domain/entities/comm_message.dart';
import 'package:flutter/material.dart';

import 'attachment_bubble.dart';

class MessageTile extends StatelessWidget {
  final CommMessage item;
  const MessageTile({super.key, required this.item});

  String _timeAgo(DateTime dt) {
    final diff = DateTime.now().difference(dt);
    if (diff.inMinutes < 1) return 'now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    return '${diff.inDays}d ago';
  }

  Color _statusColor(CommStatusDot s) =>
      s == CommStatusDot.red ? Colors.red : Colors.amber;

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () => ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: TextWidget.body('Open: ${item.subject}', context: context),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipOval(
              child: CachedNetworkImage(
                imageUrl: item.senderAvatar,
                width: 44,
                height: 44,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name + time
                  Row(
                    children: [
                      Expanded(
                        child: TextWidget.caption(
                          fontWeight: FontWeight.w600,
                          context: context,
                          item.senderName,
                        ),
                      ),
                      TextWidget.small(
                        _timeAgo(item.createdAt),
                        context: context,
                        color: t.textTheme.bodyMedium?.color?.withOpacity(.7),
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  // Subject + status dot
                  Row(
                    children: [
                      Expanded(
                        child: TextWidget.heading4(
                          item.subject,
                          context: context,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: _statusColor(item.status),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  // Preview
                  TextWidget.caption(item.preview, context: context),
                  if (item.attachmentName != null) const SizedBox(height: 10),
                  if (item.attachmentName != null)
                    Row(
                      children: [
                        AttachmentBubble(filename: item.attachmentName!),
                        if (item.extraAttachments > 0) ...[
                          const SizedBox(width: 8),
                          TextWidget.caption(
                            '+${item.extraAttachments}',
                            context: context,
                            color: t.textTheme.bodyMedium?.color?.withOpacity(
                              .7,
                            ),
                            fontWeight: FontWeight.w700,
                          ),
                        ],
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
