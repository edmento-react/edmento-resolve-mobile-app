import 'package:edmentoresolve/core/constants/color_constant.dart';
import 'package:edmentoresolve/core/widgets/index.dart';
import 'package:flutter/material.dart';

class TeacherAssignmentsPage extends StatelessWidget {
  const TeacherAssignmentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBarWidget(title: 'Assignments'),
      body: Center(
        child: TextWidget.heading3(
          'Assignment Management',
          context: context,
          color: isDark
              ? ColorConstant.textSecondaryColorDark
              : ColorConstant.textSecondaryColorLight,
        ),
      ),
    );
  }
}
