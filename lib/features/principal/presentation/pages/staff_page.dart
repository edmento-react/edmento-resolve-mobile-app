import 'package:edmentoresolve/core/widgets/index.dart';
import 'package:flutter/material.dart';

class PrincipalStaffPage extends StatelessWidget {
  const PrincipalStaffPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: 'Staff'),
      body: Center(
        child: TextWidget.heading3('Staff Management', context: context),
      ),
    );
  }
}
