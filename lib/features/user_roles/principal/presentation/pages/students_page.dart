import 'package:edmentoresolve/core/widgets/index.dart';
import 'package:flutter/material.dart';

class PrincipalStudentsPage extends StatelessWidget {
  const PrincipalStudentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: 'Students'),
      body: Center(
        child: TextWidget.heading3('Students Management', context: context),
      ),
    );
  }
}
