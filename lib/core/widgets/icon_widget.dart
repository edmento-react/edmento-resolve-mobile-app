import 'package:edmentoresolve/core/constants/color_constant.dart';
import 'package:edmentoresolve/core/utils/screen_util.dart';
import 'package:flutter/cupertino.dart';

class IconWidget {
  static Widget large(IconData icon, {Color? color, double? size}) {
    return Icon(
      // Platform.isIOS ? CupertinoIcons.info :
      icon,
      color: color ?? ColorConstant.blue,
      size:
          size ??
          ScreenUtil.getIconSize(
            smallPhone: 60,
            mobile: 80,
            tablet: 100,
            largeTablet: 120,
          ),
    );
  }

  static Widget medium(IconData icon, {Color? color, double? size}) {
    return Icon(
      // Platform.isIOS ? CupertinoIcons.info :
      icon,
      color: color ?? ColorConstant.blue,
      size:
          size ??
          ScreenUtil.getIconSize(
            smallPhone: 24,
            mobile: 32,
            tablet: 36,
            largeTablet: 40,
          ),
    );
  }

  static Widget small(IconData icon, {Color? color, double? size}) {
    return Icon(
      // Platform.isIOS ? CupertinoIcons.info :
      icon,
      color: color ?? ColorConstant.blue,
      size:
          size ??
          ScreenUtil.getIconSize(
            smallPhone: 18,
            mobile: 24,
            tablet: 28,
            largeTablet: 32,
          ),
    );
  }

  static Widget tiny(IconData icon, {Color? color, double? size}) {
    return Icon(
      // Platform.isIOS ? CupertinoIcons.info :
      icon,
      color: color ?? ColorConstant.blue,
      size:
          size ??
          ScreenUtil.getIconSize(
            smallPhone: 12,
            mobile: 16,
            tablet: 18,
            largeTablet: 20,
          ),
    );
  }

  static Widget withContainer(
    IconData icon, {
    Color? iconColor,
    Color? backgroundColor,
    double? iconSize,
    double? containerSize,
    double? borderRadius,
    EdgeInsetsGeometry? padding,
  }) {
    return Container(
      width:
          containerSize ??
          ScreenUtil.getResponsiveValue(
            smallPhone: 40,
            mobile: 48,
            tablet: 56,
            largeTablet: 64,
          ),
      height:
          containerSize ??
          ScreenUtil.getResponsiveValue(
            smallPhone: 40,
            mobile: 48,
            tablet: 56,
            largeTablet: 64,
          ),
      decoration: BoxDecoration(
        color: backgroundColor ?? ColorConstant.blue.withOpacity(0.1),
        borderRadius: BorderRadius.circular(
          borderRadius ?? ScreenUtil.getRadius(12),
        ),
      ),
      padding:
          padding ??
          EdgeInsets.all(
            ScreenUtil.getResponsiveValue(
              smallPhone: 8,
              mobile: 12,
              tablet: 16,
              largeTablet: 20,
            ),
          ),
      child: Icon(
        // Platform.isIOS ? CupertinoIcons.info :
        icon,
        color: iconColor ?? ColorConstant.blue,
        size:
            iconSize ??
            ScreenUtil.getResponsiveValue(
              smallPhone: 18,
              mobile: 24,
              tablet: 28,
              largeTablet: 32,
            ),
      ),
    );
  }
}
