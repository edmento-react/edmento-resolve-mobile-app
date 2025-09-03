import 'package:edmentoresolve/core/constants/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ContainerWidget {
  static Widget withPadding({
    required Widget child,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    Color? color,
    double? borderRadius,
    BoxBorder? border,
    BoxShadow? shadow,
    Gradient? gradient,
    double? width,
    double? height,
    AlignmentGeometry? alignment,
  }) {
    return Container(
      width: width,
      height: height,
      padding: padding ?? EdgeInsets.all(16.w),
      margin: margin,
      alignment: alignment,
      decoration: BoxDecoration(
        color: color,
        borderRadius: borderRadius != null
            ? BorderRadius.circular(borderRadius.r)
            : null,
        border: border,
        boxShadow: shadow != null ? [shadow] : null,
        gradient: gradient,
      ),
      child: child,
    );
  }

  static Widget rounded({
    required Widget child,
    double borderRadius = 16,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    Color? color,
    BoxBorder? border,
    BoxShadow? shadow,
    Gradient? gradient,
    double? width,
    double? height,
    AlignmentGeometry? alignment,
  }) {
    return Container(
      width: width,
      height: height,
      padding: padding ?? EdgeInsets.all(16.w),
      margin: margin,
      alignment: alignment,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(borderRadius.r),
        border: border,
        boxShadow: shadow != null ? [shadow] : null,
        gradient: gradient,
      ),
      child: child,
    );
  }

  static Widget elevated({
    required Widget child,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    Color? color,
    double borderRadius = 12,
    double elevation = 4,
    Color? shadowColor,
    double? width,
    double? height,
    AlignmentGeometry? alignment,
  }) {
    return Container(
      width: width,
      height: height,
      padding: padding ?? EdgeInsets.all(16.w),
      margin: margin,
      alignment: alignment,
      decoration: BoxDecoration(
        color: color ?? Colors.white,
        borderRadius: BorderRadius.circular(borderRadius.r),
        boxShadow: [
          BoxShadow(
            color: (shadowColor ?? Colors.black).withOpacity(0.1),
            blurRadius: elevation.r,
            spreadRadius: 1.r,
            offset: Offset(0, elevation.h / 2),
          ),
        ],
      ),
      child: child,
    );
  }

  static Widget outlined({
    required Widget child,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    Color borderColor = ColorConstant.grey300,
    double borderWidth = 1,
    double borderRadius = 8,
    Color? backgroundColor,
    double? width,
    double? height,
    AlignmentGeometry? alignment,
  }) {
    return Container(
      width: width,
      height: height,
      padding: padding ?? EdgeInsets.all(16.w),
      margin: margin,
      alignment: alignment,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius.r),
        border: Border.all(color: borderColor, width: borderWidth.w),
      ),
      child: child,
    );
  }

  static Widget gradient({
    required Widget child,
    required Gradient gradient,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    double borderRadius = 12,
    BoxBorder? border,
    double? width,
    double? height,
    AlignmentGeometry? alignment,
  }) {
    return Container(
      width: width,
      height: height,
      padding: padding ?? EdgeInsets.all(16.w),
      margin: margin,
      alignment: alignment,
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(borderRadius.r),
        border: border,
      ),
      child: child,
    );
  }

  static Widget circle({
    required Widget child,
    double? size,
    Color? color,
    BoxBorder? border,
    BoxShadow? shadow,
    AlignmentGeometry? alignment,
  }) {
    final circleSize = size ?? 40.w;
    return Container(
      width: circleSize,
      height: circleSize,
      alignment: alignment ?? Alignment.center,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: border,
        boxShadow: shadow != null ? [shadow] : null,
      ),
      child: child,
    );
  }

  static Widget customBorder({
    required Widget child,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    Color? color,
    BorderRadius? borderRadius,
    BoxBorder? border,
    List<BoxShadow>? boxShadow,
    double? width,
    double? height,
    AlignmentGeometry? alignment,
  }) {
    return Container(
      width: width,
      height: height,
      padding: padding ?? EdgeInsets.all(16.w),
      margin: margin,
      alignment: alignment,
      decoration: BoxDecoration(
        color: color,
        borderRadius: borderRadius ?? BorderRadius.circular(8.r),
        border: border,
        boxShadow: boxShadow,
      ),
      child: child,
    );
  }
}
