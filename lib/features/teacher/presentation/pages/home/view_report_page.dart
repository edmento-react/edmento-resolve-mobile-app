import 'package:edmentoresolve/core/widgets/app_bar_widget.dart';
import 'package:edmentoresolve/core/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class ViewReportPage extends StatelessWidget {
  const ViewReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: 'View Report', centerTitle: false),
      body: Center(child: TextWidget.heading3('View Report', context: context)),
    );
  }
}
