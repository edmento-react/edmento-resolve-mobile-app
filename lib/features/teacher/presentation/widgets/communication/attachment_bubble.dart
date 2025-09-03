import 'package:edmentoresolve/core/constants/color_constant.dart';
import 'package:edmentoresolve/core/widgets/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AttachmentBubble extends StatelessWidget {
  final String filename;
  const AttachmentBubble({super.key, required this.filename});

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: ColorConstant.blueDark.withOpacity(0.1), // soft blue
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 22,
            height: 22,
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
          const SizedBox(width: 8),
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
