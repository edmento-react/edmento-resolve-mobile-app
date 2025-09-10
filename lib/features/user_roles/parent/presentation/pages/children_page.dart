import 'package:edmentoresolve/core/widgets/navigation/app_bar_widget.dart';
import 'package:edmentoresolve/core/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class ParentChildrenPage extends StatelessWidget {
  const ParentChildrenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: 'Children'),
      body: Center(child: TextWidget.heading3('My Children', context: context)),
    );
  }
}
