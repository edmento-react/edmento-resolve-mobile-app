import 'package:edmentoresolve/core/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  final String label;
  const SectionHeader({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 12, 4, 8),
      child: TextWidget.heading4(
        label,
        context: context,
        color: t.textTheme.titleSmall?.color?.withOpacity(.75),
        fontWeight: FontWeight.w800,
      ),
    );
  }
}
