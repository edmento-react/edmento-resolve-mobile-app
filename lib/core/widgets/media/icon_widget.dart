import 'package:edmentoresolve/core/constants/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IconWidget {
  static Widget large(IconData icon, {Color? color, double? size}) {
    return Icon(icon, color: color ?? ColorConstant.blue, size: size ?? 32.w);
  }

  static Widget medium(IconData icon, {Color? color, double? size}) {
    return Icon(icon, color: color ?? ColorConstant.blue, size: size ?? 24.w);
  }

  static Widget small(IconData icon, {Color? color, double? size}) {
    return Icon(icon, color: color ?? ColorConstant.blue, size: size ?? 16.w);
  }

  static Widget tiny(IconData icon, {Color? color, double? size}) {
    return Icon(icon, color: color ?? ColorConstant.blue, size: size ?? 12.w);
  }

  static Widget custom(
    IconData icon, {
    Color? color,
    double? size,
    Color? backgroundColor,
    EdgeInsetsGeometry? padding,
    double? borderRadius,
  }) {
    final iconWidget = Icon(
      icon,
      color: color ?? ColorConstant.blue,
      size: size ?? 24.w,
    );

    if (backgroundColor != null) {
      return Container(
        padding: padding ?? EdgeInsets.all(8.w),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius ?? 8.r),
        ),
        child: iconWidget,
      );
    }

    return iconWidget;
  }

  static Widget outlined(
    IconData icon, {
    Color? color,
    Color? borderColor,
    double? size,
    EdgeInsetsGeometry? padding,
    double? borderRadius,
  }) {
    return Container(
      padding: padding ?? EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        border: Border.all(
          color: borderColor ?? ColorConstant.blue,
          width: 1.w,
        ),
        borderRadius: BorderRadius.circular(borderRadius ?? 8.r),
      ),
      child: Icon(icon, color: color ?? ColorConstant.blue, size: size ?? 20.w),
    );
  }

  static Widget filled(
    IconData icon, {
    Color? color,
    Color? backgroundColor,
    double? size,
    EdgeInsetsGeometry? padding,
    double? borderRadius,
  }) {
    return Container(
      padding: padding ?? EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        color: backgroundColor ?? ColorConstant.blue,
        borderRadius: BorderRadius.circular(borderRadius ?? 8.r),
      ),
      child: Icon(
        icon,
        color: color ?? ColorConstant.white,
        size: size ?? 20.w,
      ),
    );
  }
}
