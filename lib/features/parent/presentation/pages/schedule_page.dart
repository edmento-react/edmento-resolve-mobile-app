import 'package:edmentoresolve/core/widgets/index.dart';
import 'package:flutter/material.dart';

class ParentSchedulePage extends StatelessWidget {
  const ParentSchedulePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: 'Schedule'),
      body: Center(
        child: TextWidget.heading3('Children\'s Schedule', context: context),
      ),
    );
  }
}
