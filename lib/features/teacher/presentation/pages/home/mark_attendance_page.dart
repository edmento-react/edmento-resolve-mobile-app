import 'package:edmentoresolve/core/widgets/app_bar_widget.dart';
import 'package:edmentoresolve/core/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class MarkAttendancePage extends StatelessWidget {
  const MarkAttendancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: 'Mark Attendance', centerTitle: false),
      body: Center(
        child: TextWidget.heading3('Mark Attendance', context: context),
      ),
    );
  }
}
