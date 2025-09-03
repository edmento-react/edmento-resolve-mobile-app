import 'package:edmentoresolve/core/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class SwipeBackground extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String text;
  final bool alignLeft;

  const SwipeBackground({
    super.key,
    required this.color,
    required this.icon,
    required this.text,
    required this.alignLeft,
  });

  @override
  Widget build(BuildContext context) {
    final child = Row(
      mainAxisAlignment: alignLeft
          ? MainAxisAlignment.start
          : MainAxisAlignment.end,
      children: [
        if (!alignLeft) const SizedBox(width: 12),
        Icon(icon, color: Colors.white),
        const SizedBox(width: 8),
        TextWidget.label(
          text,
          context: context,
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
        if (alignLeft) const SizedBox(width: 12),
      ],
    );
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Align(
        alignment: alignLeft ? Alignment.centerLeft : Alignment.centerRight,
        child: child,
      ),
    );
  }
}
