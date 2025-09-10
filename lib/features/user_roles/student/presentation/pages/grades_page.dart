import 'package:edmentoresolve/core/widgets/navigation/sliver_bar_widget.dart';
import 'package:edmentoresolve/core/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StudentGradesPage extends StatelessWidget {
  const StudentGradesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: ClampingScrollPhysics(),
        slivers: [
          const SliverBarWidget(title: 'Grade'),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
            sliver: SliverToBoxAdapter(
              child: Center(
                child: TextWidget.heading3('My Grades', context: context),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
