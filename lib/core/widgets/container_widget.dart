import 'package:edmentoresolve/core/constants/color_constant.dart';
import 'package:edmentoresolve/core/utils/screen_util.dart';
import 'package:flutter/material.dart';

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
      padding: padding ?? ScreenUtil.getAdaptivePadding(),
      margin: margin,
      alignment: alignment,
      decoration: BoxDecoration(
        color: color,
        borderRadius: borderRadius != null
            ? BorderRadius.circular(ScreenUtil.getRadius(borderRadius))
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
      padding: padding ?? ScreenUtil.getAdaptivePadding(),
      margin: margin,
      alignment: alignment,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(ScreenUtil.getRadius(borderRadius)),
        border: border,
        boxShadow: shadow != null ? [shadow] : null,
        gradient: gradient,
      ),
      child: child,
    );
  }

  static Widget withShadow({
    required Widget child,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    Color? color,
    double? borderRadius,
    BoxBorder? border,
    Color? shadowColor,
    double? shadowBlurRadius,
    Offset? shadowOffset,
    double? width,
    double? height,
    AlignmentGeometry? alignment,
  }) {
    return Container(
      width: width,
      height: height,
      padding: padding ?? ScreenUtil.getAdaptivePadding(),
      margin: margin,
      alignment: alignment,
      decoration: BoxDecoration(
        color: color ?? ColorConstant.white,
        borderRadius: borderRadius != null
            ? BorderRadius.circular(ScreenUtil.getRadius(borderRadius))
            : BorderRadius.circular(ScreenUtil.getRadius(16)),
        border: border,
        boxShadow: [
          BoxShadow(
            color: shadowColor ?? ColorConstant.black.withOpacity(0.1),
            blurRadius: shadowBlurRadius ?? ScreenUtil.getResponsiveValue(
              smallPhone: 3,
              mobile: 4,
              tablet: 6,
              largeTablet: 8,
            ),
            offset: shadowOffset ?? Offset(
              0,
              ScreenUtil.getResponsiveValue(
                smallPhone: 1,
                mobile: 2,
                tablet: 3,
                largeTablet: 4,
              ),
            ),
          ),
        ],
      ),
      child: child,
    );
  }

  static Widget withGradient({
    required Widget child,
    required List<Color> colors,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    double? borderRadius,
    BoxBorder? border,
    BoxShadow? shadow,
    double? width,
    double? height,
    AlignmentGeometry? alignment,
    AlignmentGeometry? gradientBegin,
    AlignmentGeometry? gradientEnd,
  }) {
    return Container(
      width: width,
      height: height,
      padding: padding ?? ScreenUtil.getAdaptivePadding(),
      margin: margin,
      alignment: alignment,
      decoration: BoxDecoration(
        borderRadius: borderRadius != null
            ? BorderRadius.circular(ScreenUtil.getRadius(borderRadius))
            : BorderRadius.circular(ScreenUtil.getRadius(16)),
        border: border,
        boxShadow: shadow != null ? [shadow] : null,
        gradient: LinearGradient(
          begin: gradientBegin ?? Alignment.topLeft,
          end: gradientEnd ?? Alignment.bottomRight,
          colors: colors,
        ),
      ),
      child: child,
    );
  }

  static Widget responsive({
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
      padding: padding ?? ScreenUtil.getAdaptivePadding(
        horizontal: 16,
        vertical: 16,
        tabletHorizontal: 24,
        tabletVertical: 24,
      ),
      margin: margin,
      alignment: alignment,
      decoration: BoxDecoration(
        color: color,
        borderRadius: borderRadius != null
            ? BorderRadius.circular(ScreenUtil.getRadius(borderRadius))
            : BorderRadius.circular(ScreenUtil.getRadius(16)),
        border: border,
        boxShadow: shadow != null ? [shadow] : null,
        gradient: gradient,
      ),
      child: child,
    );
  }
} 