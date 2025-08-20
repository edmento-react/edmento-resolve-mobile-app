import 'package:edmentoresolve/core/utils/screen_util.dart';
import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double elevation;
  final double borderRadius;
  final Color? backgroundColor;
  final Gradient? gradient;
  final VoidCallback? onTap;
  final bool enableShadow;

  const CardWidget({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.elevation = 4,
    this.borderRadius = 16,
    this.backgroundColor,
    this.gradient,
    this.onTap,
    this.enableShadow = true,
  });

  @override
  Widget build(BuildContext context) {
    final card = Card(
      elevation: enableShadow ? ScreenUtil.getResponsiveValue(
        smallPhone: elevation - 1,
        mobile: elevation,
        tablet: elevation + 1,
        largeTablet: elevation + 2,
      ) : 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          ScreenUtil.getResponsiveValue(
            smallPhone: borderRadius * 0.75,
            mobile: borderRadius,
            tablet: borderRadius * 1.25,
            largeTablet: borderRadius * 1.5,
          ),
        ),
      ),
      color: backgroundColor,
      child: Container(
        decoration: gradient != null ? BoxDecoration(
          borderRadius: BorderRadius.circular(
            ScreenUtil.getResponsiveValue(
              smallPhone: borderRadius * 0.75,
              mobile: borderRadius,
              tablet: borderRadius * 1.25,
              largeTablet: borderRadius * 1.5,
            ),
          ),
          gradient: gradient,
        ) : null,
        padding: padding ?? ScreenUtil.getAdaptivePadding(
          smallPhoneHorizontal: 16,
          smallPhoneVertical: 16,
          horizontal: 24,
          vertical: 24,
          tabletHorizontal: 32,
          tabletVertical: 32,
        ),
        margin: margin,
        child: child,
      ),
    );

    if (onTap != null) {
      return InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(
          ScreenUtil.getResponsiveValue(
            smallPhone: borderRadius * 0.75,
            mobile: borderRadius,
            tablet: borderRadius * 1.25,
            largeTablet: borderRadius * 1.5,
          ),
        ),
        child: card,
      );
    }

    return card;
  }
} 