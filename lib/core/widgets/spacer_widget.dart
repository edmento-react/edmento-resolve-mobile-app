import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SpacerWidget {
  // Height spacers
  static Widget tiny() => SizedBox(height: 4.h);
  static Widget small() => SizedBox(height: 8.h);
  static Widget medium() => SizedBox(height: 16.h);
  static Widget large() => SizedBox(height: 24.h);
  static Widget xlarge() => SizedBox(height: 32.h);
  static Widget xxlarge() => SizedBox(height: 48.h);

  // Width spacers
  static Widget widthTiny() => SizedBox(width: 4.w);
  static Widget widthSmall() => SizedBox(width: 8.w);
  static Widget widthMedium() => SizedBox(width: 16.w);
  static Widget widthLarge() => SizedBox(width: 24.w);
  static Widget widthXlarge() => SizedBox(width: 32.w);

  // Adaptive spacers
  static Widget adaptive({
    double smallPhone = 12,
    double mobile = 16,
    double tablet = 24,
    double largeTablet = 32,
  }) {
    final screenWidth = ScreenUtil().screenWidth;
    double size;
    if (screenWidth >= 900) {
      size = largeTablet;
    } else if (screenWidth >= 600) {
      size = tablet;
    } else if (screenWidth <= 411) {
      size = smallPhone;
    } else {
      size = mobile;
    }
    return SizedBox(height: size.h);
  }

  static Widget widthAdaptive({
    double smallPhone = 12,
    double mobile = 16,
    double tablet = 24,
    double largeTablet = 32,
  }) {
    final screenWidth = ScreenUtil().screenWidth;
    double size;
    if (screenWidth >= 900) {
      size = largeTablet;
    } else if (screenWidth >= 600) {
      size = tablet;
    } else if (screenWidth <= 411) {
      size = smallPhone;
    } else {
      size = mobile;
    }
    return SizedBox(width: size.w);
  }

  static Widget custom(double height) => SizedBox(height: height.h);
  static Widget widthCustom(double width) => SizedBox(width: width.w);
}
