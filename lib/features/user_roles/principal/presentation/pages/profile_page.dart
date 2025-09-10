import 'package:edmentoresolve/core/widgets/navigation/app_bar_widget.dart';
import 'package:edmentoresolve/core/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class PrincipalProfilePage extends StatelessWidget {
  const PrincipalProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: 'Profile'),
      body: Center(
        child: TextWidget.heading3('Principal Profile', context: context),
      ),
    );
  }
}
