import 'package:edmentoresolve/core/constants/color_constant.dart';
import 'package:edmentoresolve/core/widgets/spacer_widget.dart';
import 'package:edmentoresolve/core/widgets/text_widget.dart';
import 'package:edmentoresolve/features/shared/domain/entities/task.dart';
import 'package:edmentoresolve/features/shared/presentation/widgets/task/avatar_stack.dart';
import 'package:edmentoresolve/features/shared/presentation/widgets/task/task_chips.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class TaskCard extends StatelessWidget {
  final Task task;
  final VoidCallback? onTap;

  const TaskCard({super.key, required this.task, this.onTap});

  String _dueLabel(DateTime d) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final td = DateTime(d.year, d.month, d.day);

    if (td == today) return 'Today';
    return DateFormat('MMM d').format(d); // e.g., Sep 5
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10.r),
      child: Container(
        decoration: BoxDecoration(
          color: theme.cardColor,
          border: Border.all(color: theme.dividerColor),
          borderRadius: BorderRadius.circular(10.r),
          boxShadow: [
            BoxShadow(
              color: ColorConstant.black.withOpacity(0.15),
              blurStyle: BlurStyle.outer,
              blurRadius: 2,
              offset: const Offset(0, 0),
              spreadRadius: 0,
            ),
          ],
        ),
        padding: const EdgeInsets.fromLTRB(16, 14, 14, 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            TextWidget.heading3(
              task.title,
              context: context,
              fontWeight: FontWeight.w800,
            ),
            SpacerWidget.custom(6),

            // Description
            TextWidget.caption(task.description ?? '', context: context),
            SpacerWidget.custom(12),

            // Chips + avatars
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // chips cluster
                Expanded(
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      if (task.priority == TaskPriority.high) const AlertChip(),
                      if (task.dueAt != null)
                        CalendarChip(
                          label: _dueLabel(task.dueAt!),
                          isToday: task.isDueToday,
                        ),
                      CountChip(
                        icon: CupertinoIcons.text_bubble,
                        count: task.commentsCount,
                      ),
                      CountChip(
                        icon: CupertinoIcons.paperclip,
                        count: task.attachmentsCount,
                      ),
                    ],
                  ),
                ),
                SpacerWidget.widthSmall(),
                AvatarStack(users: task.assignees),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
