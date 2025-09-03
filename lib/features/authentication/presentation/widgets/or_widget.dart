import 'package:edmentoresolve/core/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class OrWidget extends StatelessWidget {
  const OrWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      children: [
        Expanded(child: Divider(endIndent: 16, color: colorScheme.outline)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: TextWidget.caption(
            'OR',
            context: context,
            color: colorScheme.onSurfaceVariant,
          ),
        ),
        Expanded(child: Divider(indent: 16, color: colorScheme.outline)),
      ],
    );
  }
}
