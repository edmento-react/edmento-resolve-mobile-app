import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/style_constant.dart';

/// Enhanced TextWidget that integrates with the theme system
/// and provides more flexibility while maintaining your style system
class EnhancedTextWidget {
  // ===== HEADINGS =====

  static Widget heading1(
    String text, {
    Color? color,
    TextAlign? textAlign,
    FontWeight? fontWeight,
    double? fontSize,
    required BuildContext context,
    int? maxLines,
    TextOverflow? overflow,
    bool softWrap = true,
  }) {
    return Text(
      text,
      style: StyleConstant.heading1(context).copyWith(
        color: color ?? _getDefaultTextColor(context),
        fontWeight: fontWeight,
        fontSize: fontSize,
      ),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
    );
  }

  static Widget heading2(
    String text, {
    Color? color,
    TextAlign? textAlign,
    FontWeight? fontWeight,
    double? fontSize,
    required BuildContext context,
    int? maxLines,
    TextOverflow? overflow,
    bool softWrap = true,
  }) {
    return Text(
      text,
      style: StyleConstant.heading2(context).copyWith(
        color: color ?? _getDefaultTextColor(context),
        fontWeight: fontWeight,
        fontSize: fontSize,
      ),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
    );
  }

  static Widget heading3(
    String text, {
    Color? color,
    TextAlign? textAlign,
    FontWeight? fontWeight,
    double? fontSize,
    required BuildContext context,
    int? maxLines,
    TextOverflow? overflow,
    bool softWrap = true,
  }) {
    return Text(
      text,
      style: StyleConstant.heading3(context).copyWith(
        color: color ?? _getDefaultTextColor(context),
        fontWeight: fontWeight,
        fontSize: fontSize,
      ),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
    );
  }

  static Widget heading4(
    String text, {
    Color? color,
    TextAlign? textAlign,
    FontWeight? fontWeight,
    double? fontSize,
    required BuildContext context,
    int? maxLines,
    TextOverflow? overflow,
    bool softWrap = true,
  }) {
    return Text(
      text,
      style: StyleConstant.heading4(context).copyWith(
        color: color ?? _getDefaultTextColor(context),
        fontWeight: fontWeight,
        fontSize: fontSize,
      ),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
    );
  }

  // ===== BODY TEXT =====

  static Widget body(
    String text, {
    Color? color,
    TextAlign? textAlign,
    FontWeight? fontWeight,
    double? fontSize,
    required BuildContext context,
    int? maxLines,
    TextOverflow? overflow,
    bool softWrap = true,
  }) {
    return Text(
      text,
      style: StyleConstant.body(context).copyWith(
        color: color ?? _getDefaultTextColor(context),
        fontWeight: fontWeight,
        fontSize: fontSize,
      ),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
    );
  }

  static Widget bodyLarge(
    String text, {
    Color? color,
    TextAlign? textAlign,
    FontWeight? fontWeight,
    double? fontSize,
    required BuildContext context,
    int? maxLines,
    TextOverflow? overflow,
    bool softWrap = true,
  }) {
    return Text(
      text,
      style: StyleConstant.body(context).copyWith(
        color: color ?? _getDefaultTextColor(context),
        fontWeight: fontWeight,
        fontSize: fontSize ?? 18.sp,
      ),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
    );
  }

  static Widget bodyMedium(
    String text, {
    Color? color,
    TextAlign? textAlign,
    FontWeight? fontWeight,
    double? fontSize,
    required BuildContext context,
    int? maxLines,
    TextOverflow? overflow,
    bool softWrap = true,
  }) {
    return Text(
      text,
      style: StyleConstant.body(context).copyWith(
        color: color ?? _getDefaultTextColor(context),
        fontWeight: fontWeight,
        fontSize: fontSize ?? 16.sp,
      ),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
    );
  }

  static Widget bodySmall(
    String text, {
    Color? color,
    TextAlign? textAlign,
    FontWeight? fontWeight,
    double? fontSize,
    required BuildContext context,
    int? maxLines,
    TextOverflow? overflow,
    bool softWrap = true,
  }) {
    return Text(
      text,
      style: StyleConstant.body(context).copyWith(
        color: color ?? _getDefaultTextColor(context),
        fontWeight: fontWeight,
        fontSize: fontSize ?? 14.sp,
      ),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
    );
  }

  // ===== CAPTION & SMALL TEXT =====

  static Widget caption(
    String text, {
    Color? color,
    TextAlign? textAlign,
    FontWeight? fontWeight,
    double? fontSize,
    required BuildContext context,
    int? maxLines,
    TextOverflow? overflow,
    bool softWrap = true,
  }) {
    return Text(
      text,
      style: StyleConstant.caption(context).copyWith(
        color: color ?? _getDefaultTextColor(context),
        fontWeight: fontWeight,
        fontSize: fontSize,
      ),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
    );
  }

  static Widget small(
    String text, {
    Color? color,
    TextAlign? textAlign,
    FontWeight? fontWeight,
    double? fontSize,
    required BuildContext context,
    int? maxLines,
    TextOverflow? overflow,
    bool softWrap = true,
  }) {
    return Text(
      text,
      style: StyleConstant.small(context).copyWith(
        color: color ?? _getDefaultTextColor(context),
        fontWeight: fontWeight,
        fontSize: fontSize,
      ),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
    );
  }

  // ===== LABELS =====

  static Widget label(
    String text, {
    Color? color,
    TextAlign? textAlign,
    FontWeight? fontWeight,
    double? fontSize,
    required BuildContext context,
    int? maxLines,
    TextOverflow? overflow,
    bool softWrap = true,
  }) {
    return Text(
      text,
      style: StyleConstant.label(context).copyWith(
        color: color ?? _getDefaultTextColor(context),
        fontWeight: fontWeight,
        fontSize: fontSize,
      ),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
    );
  }

  static Widget labelLarge(
    String text, {
    Color? color,
    TextAlign? textAlign,
    FontWeight? fontWeight,
    double? fontSize,
    required BuildContext context,
    int? maxLines,
    TextOverflow? overflow,
    bool softWrap = true,
  }) {
    return Text(
      text,
      style: StyleConstant.label(context).copyWith(
        color: color ?? _getDefaultTextColor(context),
        fontWeight: fontWeight,
        fontSize: fontSize ?? 16.sp,
      ),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
    );
  }

  static Widget labelSmall(
    String text, {
    Color? color,
    TextAlign? textAlign,
    FontWeight? fontWeight,
    double? fontSize,
    required BuildContext context,
    int? maxLines,
    TextOverflow? overflow,
    bool softWrap = true,
  }) {
    return Text(
      text,
      style: StyleConstant.label(context).copyWith(
        color: color ?? _getDefaultTextColor(context),
        fontWeight: fontWeight,
        fontSize: fontSize ?? 12.sp,
      ),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
    );
  }

  // ===== UTILITY METHODS =====

  /// Get default text color based on current theme
  static Color _getDefaultTextColor(BuildContext context) {
    final theme = Theme.of(context);
    return theme.colorScheme.onSurface;
  }

  /// Create a text widget with custom style that still follows your system
  static Widget custom(
    String text, {
    required BuildContext context,
    TextStyle? baseStyle,
    Color? color,
    TextAlign? textAlign,
    FontWeight? fontWeight,
    double? fontSize,
    int? maxLines,
    TextOverflow? overflow,
    bool softWrap = true,
  }) {
    final defaultStyle = baseStyle ?? StyleConstant.body(context);

    return Text(
      text,
      style: defaultStyle.copyWith(
        color: color ?? _getDefaultTextColor(context),
        fontWeight: fontWeight,
        fontSize: fontSize,
      ),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
    );
  }

  /// Create a text widget that automatically adapts to theme changes
  static Widget adaptive(
    String text, {
    required BuildContext context,
    TextStyle? lightStyle,
    TextStyle? darkStyle,
    Color? color,
    TextAlign? textAlign,
    FontWeight? fontWeight,
    double? fontSize,
    int? maxLines,
    TextOverflow? overflow,
    bool softWrap = true,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    final baseStyle = colorScheme.brightness == Brightness.dark
        ? darkStyle
        : lightStyle ?? StyleConstant.body(context);

    return Text(
      text,
      style:
          baseStyle?.copyWith(
            color: color ?? _getDefaultTextColor(context),
            fontWeight: fontWeight,
            fontSize: fontSize,
          ) ??
          TextStyle(
            color: color ?? _getDefaultTextColor(context),
            fontWeight: fontWeight,
            fontSize: fontSize,
          ),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
    );
  }
}
