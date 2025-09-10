import 'package:edmentoresolve/core/constants/color_constant.dart';
import 'package:edmentoresolve/core/widgets/spacer_widget.dart';
import 'package:edmentoresolve/core/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GlobalSnackbar {
  static void show({
    required BuildContext context,
    required String message,
    SnackBarType type = SnackBarType.info,
    Duration duration = const Duration(seconds: 3),
    String? actionLabel,
    VoidCallback? onActionPressed,
  }) {
    final colors = _getColors(type);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(_getIcon(type), color: colors.iconColor, size: 20.w),
            SpacerWidget.widthCustom(12),
            Expanded(
              child: TextWidget.body(
                message,
                context: context,
                color: colors.textColor,
              ),
            ),
          ],
        ),
        backgroundColor: colors.backgroundColor,
        duration: duration,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(16.w),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
        action: actionLabel != null
            ? SnackBarAction(
                label: actionLabel,
                textColor: colors.actionColor,
                onPressed: onActionPressed ?? () {},
              )
            : null,
      ),
    );
  }

  static void success({
    required BuildContext context,
    required String message,
    Duration duration = const Duration(seconds: 3),
  }) {
    show(
      context: context,
      message: message,
      type: SnackBarType.success,
      duration: duration,
    );
  }

  static void error({
    required BuildContext context,
    required String message,
    Duration duration = const Duration(seconds: 4),
  }) {
    show(
      context: context,
      message: message,
      type: SnackBarType.error,
      duration: duration,
    );
  }

  static void warning({
    required BuildContext context,
    required String message,
    Duration duration = const Duration(seconds: 3),
  }) {
    show(
      context: context,
      message: message,
      type: SnackBarType.warning,
      duration: duration,
    );
  }

  static _SnackBarColors _getColors(SnackBarType type) {
    switch (type) {
      case SnackBarType.success:
        return _SnackBarColors(
          backgroundColor: ColorConstant.green,
          textColor: ColorConstant.white,
          iconColor: ColorConstant.white,
          actionColor: ColorConstant.white,
        );
      case SnackBarType.error:
        return _SnackBarColors(
          backgroundColor: ColorConstant.red,
          textColor: ColorConstant.white,
          iconColor: ColorConstant.white,
          actionColor: ColorConstant.white,
        );
      case SnackBarType.warning:
        return _SnackBarColors(
          backgroundColor: ColorConstant.orange,
          textColor: ColorConstant.white,
          iconColor: ColorConstant.white,
          actionColor: ColorConstant.white,
        );
      case SnackBarType.info:
      default:
        return _SnackBarColors(
          backgroundColor: ColorConstant.blue,
          textColor: ColorConstant.white,
          iconColor: ColorConstant.white,
          actionColor: ColorConstant.white,
        );
    }
  }

  static IconData _getIcon(SnackBarType type) {
    switch (type) {
      case SnackBarType.success:
        return Icons.check_circle;
      case SnackBarType.error:
        return Icons.error;
      case SnackBarType.warning:
        return Icons.warning;
      case SnackBarType.info:
      default:
        return Icons.info;
    }
  }
}

enum SnackBarType { success, error, warning, info }

class _SnackBarColors {
  final Color backgroundColor;
  final Color textColor;
  final Color iconColor;
  final Color actionColor;

  _SnackBarColors({
    required this.backgroundColor,
    required this.textColor,
    required this.iconColor,
    required this.actionColor,
  });
}
