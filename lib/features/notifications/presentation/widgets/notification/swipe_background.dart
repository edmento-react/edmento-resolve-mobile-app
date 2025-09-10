import 'package:edmentoresolve/core/widgets/spacer_widget.dart';
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
        if (!alignLeft) SpacerWidget.widthCustom(12),
        Icon(icon, color: Colors.white),
        SpacerWidget.widthSmall(),
        TextWidget.label(
          text,
          context: context,
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
        if (alignLeft) SpacerWidget.widthCustom(12),
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
