import 'package:edmentoresolve/core/widgets/index.dart';
import 'package:flutter/material.dart';

class CoordinatorReportsPage extends StatelessWidget {
  const CoordinatorReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBarWidget(title: 'Reports'),
      body: Center(
        child: TextWidget.heading3(
          'Academic Reports',
          context: context,
          color: colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
}
