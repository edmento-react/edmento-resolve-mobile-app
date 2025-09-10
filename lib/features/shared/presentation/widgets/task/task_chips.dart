import 'package:edmentoresolve/core/constants/color_constant.dart';
import 'package:edmentoresolve/core/widgets/spacer_widget.dart';
import 'package:edmentoresolve/core/widgets/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CalendarChip extends StatelessWidget {
  final String label; // "Today" or "Sep 5"
  final bool isToday;

  const CalendarChip({super.key, required this.label, this.isToday = false});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bg = isToday
        ? ColorConstant.red.withOpacity(0.2) // soft red tint
        : theme.disabledColor.withOpacity(0.05);
    final iconColor = isToday
        ? Colors.red
        : theme.textTheme.headlineSmall?.color!.withOpacity(0.7);

    return _Pill(
      background: bg,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(CupertinoIcons.calendar, size: 16, color: iconColor),
          SpacerWidget.widthCustom(6),
          TextWidget.caption(
            label,
            context: context,
            fontWeight: FontWeight.w700,
            color: isToday
                ? Colors.red
                : theme.textTheme.headlineSmall?.color!.withOpacity(0.7),
          ),
        ],
      ),
    );
  }
}

class CountChip extends StatelessWidget {
  final IconData icon;
  final int count;

  const CountChip({super.key, required this.icon, required this.count});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return _Pill(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 16,
            color: theme.textTheme.headlineSmall?.color!.withOpacity(0.7),
          ),
          SpacerWidget.widthCustom(6),
          TextWidget.caption(
            '$count',
            context: context,
            fontWeight: FontWeight.w700,
            color: theme.textTheme.headlineSmall?.color!.withOpacity(0.7),
          ),
        ],
      ),
    );
  }
}

class AlertChip extends StatelessWidget {
  const AlertChip({super.key});

  @override
  Widget build(BuildContext context) {
    return _Pill(
      background: ColorConstant.red.withOpacity(0.2),
      child: Icon(
        Icons.notification_important_rounded,
        size: 16,
        color: ColorConstant.red,
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  final Widget child;
  final Color? background;

  const _Pill({required this.child, this.background});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: background ?? theme.disabledColor.withOpacity(0.05),
        borderRadius: BorderRadius.circular(10),
        // border: Border.all(color: theme.dividerColor),
      ),
      child: child,
    );
  }
}
