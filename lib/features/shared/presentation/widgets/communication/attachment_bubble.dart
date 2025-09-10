import 'package:edmentoresolve/core/constants/color_constant.dart';
import 'package:edmentoresolve/core/widgets/spacer_widget.dart';
import 'package:edmentoresolve/core/widgets/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AttachmentBubble extends StatelessWidget {
  final String filename;
  const AttachmentBubble({super.key, required this.filename});

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: ColorConstant.blueDark.withOpacity(0.1), // soft blue
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 22.w,
            height: 22.h,
            decoration: const BoxDecoration(
              color: ColorConstant.blueDark,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Icon(
              CupertinoIcons.doc_fill,
              size: 14,
              color: ColorConstant.white,
            ),
          ),
          SpacerWidget.widthSmall(),
          TextWidget.caption(
            filename,
            context: context,
            fontWeight: FontWeight.w700,
            color: t.colorScheme.onSurface.withOpacity(.9),
          ),
        ],
      ),
    );
  }
}
