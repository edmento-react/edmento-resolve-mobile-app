import 'dart:ui';

import 'package:edmentoresolve/core/constants/color_constant.dart';
import 'package:flutter/material.dart';

class GlassContainer extends StatelessWidget {
  final Widget child;
  final double blur; // blur intensity
  final double opacity; // background color opacity
  final double borderRadius;
  final Gradient? gradient;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry? margin;
  final double? width;
  final double? height;
  final BoxBorder? border;

  const GlassContainer({
    super.key,
    required this.child,
    this.blur = 5,
    this.opacity = 0.2,
    this.borderRadius = 16,
    this.gradient,
    this.padding = const EdgeInsets.all(12),
    this.margin,
    this.width,
    this.height,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,

        boxShadow: [
          BoxShadow(
            color: ColorConstant.black.withOpacity(0.15),
            blurStyle: BlurStyle.outer,
            blurRadius: 8,
            offset: const Offset(0, 0),
            spreadRadius: 0,
          ),
        ],
      ),
      // margin: margin,
      width: width,
      height: height,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
          child: Container(
            // padding: padding,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius),
              border:
                  border ?? Border.all(color: Colors.white.withOpacity(0.8)),
              gradient:
                  gradient ??
                  LinearGradient(
                    colors: [
                      Colors.white.withOpacity(opacity),
                      Colors.white.withOpacity(opacity * 0.7),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
