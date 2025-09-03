import 'package:edmentoresolve/core/widgets/app_bar_widget.dart';
import 'package:edmentoresolve/core/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class AnnounceNowPage extends StatelessWidget {
  const AnnounceNowPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: 'Announce now', centerTitle: false),
      body: Center(
        child: TextWidget.heading3('Announce now', context: context),
      ),
    );
  }
}
