import 'package:edmentoresolve/core/constants/color_constant.dart';
import 'package:edmentoresolve/core/widgets/index.dart';
import 'package:flutter/material.dart';

class CoordinatorReportsPage extends StatelessWidget {
  const CoordinatorReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBarWidget(title: 'Reports'),
      body: Center(
        child: TextWidget.heading3(
          'Academic Reports',
          context: context,
          color: isDark
              ? ColorConstant.textSecondaryColorDark
              : ColorConstant.textSecondaryColorLight,
        ),
      ),
    );
  }
}
