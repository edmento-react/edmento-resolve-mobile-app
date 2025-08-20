import 'package:flutter/material.dart';

import '../utils/screen_util.dart';
import 'color_constant.dart';

class StyleConstant {
  static TextStyle heading1(BuildContext context) => TextStyle(
    fontSize: ScreenUtil.getAdaptiveFontSize(24, 32, 40, 48),
    fontWeight: FontWeight.w700,
    color:
        Theme.of(context).textTheme.displayLarge?.color ??
        (Theme.of(context).brightness == Brightness.dark
            ? ColorConstant.white
            : ColorConstant.textPrimaryColorLight),
  );

  static TextStyle heading2(BuildContext context) => TextStyle(
    fontSize: ScreenUtil.getAdaptiveFontSize(20, 24, 28, 32),
    fontWeight: FontWeight.w700,
    color:
        Theme.of(context).textTheme.displayMedium?.color ??
        (Theme.of(context).brightness == Brightness.dark
            ? ColorConstant.white
            : ColorConstant.textPrimaryColorLight),
  );

  static TextStyle heading3(BuildContext context) => TextStyle(
    fontSize: ScreenUtil.getAdaptiveFontSize(18, 20, 24, 28),
    fontWeight: FontWeight.w600,
    color:
        Theme.of(context).textTheme.displaySmall?.color ??
        (Theme.of(context).brightness == Brightness.dark
            ? ColorConstant.white
            : ColorConstant.textPrimaryColorLight),
  );

  static TextStyle body(BuildContext context) => TextStyle(
    fontSize: ScreenUtil.getAdaptiveFontSize(14, 16, 18, 20),
    fontWeight: FontWeight.normal,
    color:
        Theme.of(context).textTheme.bodyLarge?.color ??
        (Theme.of(context).brightness == Brightness.dark
            ? ColorConstant.white
            : ColorConstant.textPrimaryColorLight),
  );

  static TextStyle caption(BuildContext context) => TextStyle(
    fontSize: ScreenUtil.getAdaptiveFontSize(12, 14, 16, 18),
    fontWeight: FontWeight.normal,
    color:
        Theme.of(context).textTheme.bodySmall?.color ??
        (Theme.of(context).brightness == Brightness.dark
            ? ColorConstant.grey400
            : ColorConstant.textCaptionColorLight),
  );

  static TextStyle small(BuildContext context) => TextStyle(
    fontSize: ScreenUtil.getAdaptiveFontSize(10, 12, 14, 16),
    fontWeight: FontWeight.normal,
    color:
        Theme.of(context).textTheme.bodyMedium?.color ??
        (Theme.of(context).brightness == Brightness.dark
            ? ColorConstant.grey400
            : ColorConstant.textSecondaryColorLight),
  );

  static TextStyle label(BuildContext context) => TextStyle(
    fontSize: ScreenUtil.getAdaptiveFontSize(12, 14, 16, 18),
    fontWeight: FontWeight.w500,
    color:
        Theme.of(context).textTheme.bodyLarge?.color ??
        (Theme.of(context).brightness == Brightness.dark
            ? ColorConstant.white
            : ColorConstant.textLabelColorLight),
  );

  // Add more as needed for buttons, app bar, etc.
}
