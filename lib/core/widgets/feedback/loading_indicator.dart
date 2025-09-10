import 'package:edmentoresolve/core/constants/color_constant.dart';
import 'package:edmentoresolve/core/widgets/spacer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoadingIndicator extends StatelessWidget {
  final Color? color;
  final double? size;
  final double? strokeWidth;
  final String? message;

  const LoadingIndicator({
    super.key,
    this.color,
    this.size,
    this.strokeWidth,
    this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: size ?? 24.w,
            height: size ?? 24.h,
            child: CircularProgressIndicator(
              strokeWidth: strokeWidth ?? 2.w,
              valueColor: AlwaysStoppedAnimation<Color>(
                color ?? ColorConstant.blue,
              ),
            ),
          ),
          if (message != null) ...[
            SpacerWidget.medium(),
            Text(
              message!,
              style: TextStyle(fontSize: 14.sp, color: ColorConstant.grey600),
            ),
          ],
        ],
      ),
    );
  }

  static Widget small({Color? color}) {
    return LoadingIndicator(size: 16.w, strokeWidth: 2.w, color: color);
  }

  static Widget large({Color? color, String? message}) {
    return LoadingIndicator(
      size: 32.w,
      strokeWidth: 3.w,
      color: color,
      message: message,
    );
  }
}
