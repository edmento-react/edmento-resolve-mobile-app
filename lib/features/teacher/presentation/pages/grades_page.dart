import 'package:edmentoresolve/core/constants/color_constant.dart';
import 'package:edmentoresolve/core/widgets/index.dart';
import 'package:flutter/material.dart';

class TeacherGradesPage extends StatelessWidget {
  const TeacherGradesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBarWidget(title: 'Grades'),
      body: Center(
        child: TextWidget.heading3(
          'Grade Management',
          context: context,
          color: isDark
              ? ColorConstant.textSecondaryColorDark
              : ColorConstant.textSecondaryColorLight,
        ),
      ),
    );
  }
}
