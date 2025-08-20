import 'package:edmentoresolve/core/utils/screen_util.dart';
import 'package:flutter/material.dart';

class SpacerWidget {
  // Height spacers with small phone support
static Widget tiny() => SizedBox(
    height: ScreenUtil.getSpacing(smallPhone: 4, mobile: 4, tablet: 6, largeTablet: 8));

static Widget small() => SizedBox(
    height: ScreenUtil.getSpacing(smallPhone: 8, mobile: 8, tablet: 10, largeTablet: 12));

static Widget medium() => SizedBox(
    height: ScreenUtil.getSpacing(smallPhone: 12, mobile: 12, tablet: 14, largeTablet: 16));

static Widget large() => SizedBox(
    height: ScreenUtil.getSpacing(smallPhone: 16, mobile: 16, tablet: 18, largeTablet: 20));

static Widget xlarge() => SizedBox(
    height: ScreenUtil.getSpacing(smallPhone: 20, mobile: 20, tablet: 24, largeTablet: 28));

static Widget xxlarge() => SizedBox(
    height: ScreenUtil.getSpacing(smallPhone: 24, mobile: 24, tablet: 30, largeTablet: 36));


  // Width spacers with small phone support
  static Widget widthTiny() => SizedBox(width: ScreenUtil.getSpacing(smallPhone: 2, mobile: 4));
  static Widget widthSmall() => SizedBox(width: ScreenUtil.getSpacing(smallPhone: 4, mobile: 8));
  static Widget widthMedium() => SizedBox(width: ScreenUtil.getSpacing(smallPhone: 8, mobile: 16));
  static Widget widthLarge() => SizedBox(width: ScreenUtil.getSpacing(smallPhone: 12, mobile: 24));
  static Widget widthXlarge() => SizedBox(width: ScreenUtil.getSpacing(smallPhone: 16, mobile: 32));

  // Adaptive spacers with small phone support
  static Widget adaptive({
    double smallPhone = 12,
    double mobile = 16,
    double tablet = 24,
    double largeTablet = 32,
  }) => SizedBox(
    height: ScreenUtil.getResponsiveValue(
      smallPhone: smallPhone,
      mobile: mobile,
      tablet: tablet,
      largeTablet: largeTablet,
    ),
  );

  static Widget widthAdaptive({
    double smallPhone = 12,
    double mobile = 16,
    double tablet = 24,
    double largeTablet = 32,
  }) => SizedBox(
    width: ScreenUtil.getResponsiveValue(
      smallPhone: smallPhone,
      mobile: mobile,
      tablet: tablet,
      largeTablet: largeTablet,
    ),
  );

  static Widget custom(double height) => SizedBox(height: height);
  static Widget widthCustom(double width) => SizedBox(width: width);
} 