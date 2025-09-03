import 'package:edmentoresolve/core/widgets/sliver_bar_widget.dart';
import 'package:edmentoresolve/core/widgets/text_widget.dart';
import 'package:flutter/material.dart';

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
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
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
