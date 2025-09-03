import 'package:edmentoresolve/core/constants/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DividerWidget {
  static Widget horizontal({
    Color? color,
    double? thickness,
    double? height,
    double? indent,
    double? endIndent,
  }) {
    return Divider(
      color: color ?? ColorConstant.grey300,
      thickness: thickness ?? 1.h,
      height: height ?? 1.h,
      indent: indent,
      endIndent: endIndent,
    );
  }

  static Widget vertical({
    Color? color,
    double? thickness,
    double? width,
    double? indent,
    double? endIndent,
  }) {
    return VerticalDivider(
      color: color ?? ColorConstant.grey300,
      thickness: thickness ?? 1.w,
      width: width ?? 1.w,
      indent: indent,
      endIndent: endIndent,
    );
  }

  static Widget thick({Color? color, double? thickness, double? height}) {
    return Container(
      height: height ?? 8.h,
      color: color ?? ColorConstant.grey100,
    );
  }

  static Widget withText({
    required String text,
    Color? color,
    Color? textColor,
    double? thickness,
    TextStyle? textStyle,
  }) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            color: color ?? ColorConstant.grey300,
            thickness: thickness ?? 1.h,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Text(
            text,
            style:
                textStyle ??
                TextStyle(
                  color: textColor ?? ColorConstant.grey600,
                  fontSize: 14.sp,
                ),
          ),
        ),
        Expanded(
          child: Divider(
            color: color ?? ColorConstant.grey300,
            thickness: thickness ?? 1.h,
          ),
        ),
      ],
    );
  }

  static Widget dashed({
    Color? color,
    double? thickness,
    double? dashWidth,
    double? dashSpace,
  }) {
    return CustomPaint(
      painter: _DashedLinePainter(
        color: color ?? ColorConstant.grey300,
        thickness: thickness ?? 1.h,
        dashWidth: dashWidth ?? 4.w,
        dashSpace: dashSpace ?? 2.w,
      ),
      size: Size.fromHeight(thickness ?? 1.h),
    );
  }
}

class _DashedLinePainter extends CustomPainter {
  final Color color;
  final double thickness;
  final double dashWidth;
  final double dashSpace;

  _DashedLinePainter({
    required this.color,
    required this.thickness,
    required this.dashWidth,
    required this.dashSpace,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = thickness;

    double startX = 0;
    while (startX < size.width) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
