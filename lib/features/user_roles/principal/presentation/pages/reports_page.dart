import 'package:edmentoresolve/core/widgets/navigation/app_bar_widget.dart';
import 'package:edmentoresolve/core/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class PrincipalReportsPage extends StatelessWidget {
  const PrincipalReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: 'Reports'),
      body: Center(
        child: TextWidget.heading3('School Reports', context: context),
      ),
    );
  }
}
