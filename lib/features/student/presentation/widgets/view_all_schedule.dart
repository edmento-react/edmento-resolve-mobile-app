import 'package:edmentoresolve/core/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class ViewAllScheduleButton extends StatelessWidget {
  const ViewAllScheduleButton({super.key, required this.onPressed});
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: TextWidget.body(context: context, 'View all schedule'),
    );
  }
}
