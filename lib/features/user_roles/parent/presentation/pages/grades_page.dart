import 'package:edmentoresolve/core/widgets/index.dart';
import 'package:flutter/material.dart';

class ParentGradesPage extends StatelessWidget {
  const ParentGradesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: 'Grades'),
      body: Center(
        child: TextWidget.heading3('Children\'s Grades', context: context),
      ),
    );
  }
}
