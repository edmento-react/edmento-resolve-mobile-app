import 'package:edmentoresolve/core/widgets/spacer_widget.dart';
import 'package:edmentoresolve/core/widgets/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmptyView extends StatelessWidget {
  final String message;
  const EmptyView({super.key, this.message = 'No messages'});

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              CupertinoIcons.chat_bubble_2,
              size: 56.w,
              color: t.dividerColor,
            ),
            SpacerWidget.custom(12),
            TextWidget.heading4(
              message,
              context: context,
              fontWeight: FontWeight.w700,
            ),
            SpacerWidget.custom(6),
            TextWidget.caption(
              context: context,
              'You’re all caught up. New messages will appear here.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
