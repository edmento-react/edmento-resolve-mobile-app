import 'package:edmentoresolve/core/constants/color_constant.dart';
import 'package:edmentoresolve/core/utils/screen_util.dart';
import 'package:edmentoresolve/core/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class GlobalSnackBar {
  static void show(
    BuildContext context, {
    required String message,
    Color backgroundColor = ColorConstant.black87,
    Duration duration = const Duration(seconds: 3),
    SnackBarAction? action,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: TextWidget.caption(
          message,
          context: context,
          color: ColorConstant.textPrimaryColorDark,
        ),
        backgroundColor: backgroundColor,

        duration: duration,
        action: action,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            ScreenUtil.getResponsiveValue(
              smallPhone: 8,
              mobile: 12,
              tablet: 16,
              largeTablet: 20,
            ),
          ),
        ),
      ),
    );
  }
}
