import 'package:edmentoresolve/core/constants/color_constant.dart';
import 'package:edmentoresolve/core/constants/padding_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CardWidget extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? elevation;
  final double? borderRadius;
  final Color? backgroundColor;
  final Gradient? gradient;
  final VoidCallback? onTap;
  final bool enableShadow;
  final Border? border;
  final List<BoxShadow>? boxShadow;

  const CardWidget({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.elevation,
    this.borderRadius,
    this.backgroundColor,
    this.gradient,
    this.onTap,
    this.enableShadow = true,
    this.border,
    this.boxShadow,
  });

  @override
  Widget build(BuildContext context) {
    final Widget cardContent = Container(
      padding: padding ?? PaddingConstant.cardPadding,
      margin: margin,
      decoration: BoxDecoration(
        color: gradient == null ? (backgroundColor ?? Colors.white) : null,
        gradient: gradient,
        borderRadius: BorderRadius.circular(
          borderRadius?.r ?? PaddingConstant.cardBorderRadius,
        ),
        border: border,
        boxShadow: enableShadow
            ? (boxShadow ??
                  [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius:
                          (elevation ?? PaddingConstant.cardElevation).r,
                      spreadRadius: 1.r,
                      offset: Offset(0, 2.h),
                    ),
                  ])
            : null,
      ),
      child: child,
    );

    if (onTap != null) {
      return Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(
            borderRadius?.r ?? PaddingConstant.cardBorderRadius,
          ),
          child: cardContent,
        ),
      );
    }

    return cardContent;
  }

  /// Factory constructor for elevated card
  factory CardWidget.elevated({
    required Widget child,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    double? elevation,
    double? borderRadius,
    Color? backgroundColor,
    VoidCallback? onTap,
  }) {
    return CardWidget(
      padding: padding,
      margin: margin,
      elevation: elevation ?? 8,
      borderRadius: borderRadius,
      backgroundColor: backgroundColor,
      onTap: onTap,
      enableShadow: true,
      child: child,
    );
  }

  /// Factory constructor for flat card
  factory CardWidget.flat({
    required Widget child,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    double? borderRadius,
    Color? backgroundColor,
    Border? border,
    VoidCallback? onTap,
  }) {
    return CardWidget(
      padding: padding,
      margin: margin,
      borderRadius: borderRadius,
      backgroundColor: backgroundColor,
      border: border ?? Border.all(color: ColorConstant.grey300),
      onTap: onTap,
      enableShadow: false,
      child: child,
    );
  }

  /// Factory constructor for gradient card
  factory CardWidget.gradient({
    required Widget child,
    required Gradient gradient,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    double? borderRadius,
    VoidCallback? onTap,
  }) {
    return CardWidget(
      padding: padding,
      margin: margin,
      borderRadius: borderRadius,
      gradient: gradient,
      onTap: onTap,
      child: child,
    );
  }
}
