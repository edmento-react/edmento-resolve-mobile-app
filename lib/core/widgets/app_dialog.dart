import 'dart:io';

import 'package:edmentoresolve/core/constants/color_constant.dart';
import 'package:edmentoresolve/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:edmentoresolve/features/authentication/presentation/bloc/role_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'button_widget.dart';
import 'icon_widget.dart';
import 'spacer_widget.dart';
import 'text_widget.dart';

class AppDialog {
  static Future<T?> show<T>({
    required BuildContext context,
    required String title,
    required Widget child,
    bool barrierDismissible = true,
    EdgeInsets? padding,
  }) {
    if (Platform.isIOS) {
      return showCupertinoDialog<T>(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: TextWidget.heading3(title, context: context),
          content: Padding(
            padding: padding ?? EdgeInsets.all(16.w),
            child: child,
          ),
        ),
        barrierDismissible: barrierDismissible,
      );
    }

    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) => AlertDialog(
        title: TextWidget.heading3(title, context: context),
        content: Padding(
          padding: padding ?? EdgeInsets.all(16.w),
          child: child,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
    );
  }

  static Future<bool?> confirm({
    required BuildContext context,
    required String title,
    required String message,
    String confirmText = 'Confirm',
    String cancelText = 'Cancel',
    Color? confirmColor,
    bool barrierDismissible = true,
  }) {
    return show<bool>(
      context: context,
      title: title,
      barrierDismissible: barrierDismissible,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextWidget.body(message, context: context),
          SpacerWidget.medium(),
          Row(
            children: [
              Expanded(
                child: ButtonWidget.secondary(
                  label: cancelText,
                  onPressed: () => Navigator.of(context).pop(false),
                  context: context,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: ButtonWidget.primary(
                  label: confirmText,
                  backgroundColor: confirmColor,
                  onPressed: () => Navigator.of(context).pop(true),
                  context: context,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  static Future<void> info({
    required BuildContext context,
    required String title,
    required String message,
    String buttonText = 'OK',
  }) {
    return show<void>(
      context: context,
      title: title,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextWidget.body(message, context: context),
          SpacerWidget.medium(),
          ButtonWidget.primary(
            label: buttonText,
            onPressed: () => Navigator.of(context).pop(),
            context: context,
          ),
        ],
      ),
    );
  }

  static Future<void> error({
    required BuildContext context,
    required String title,
    required String message,
    String buttonText = 'OK',
  }) {
    return show<void>(
      context: context,
      title: title,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconWidget.large(Icons.error_outline, color: ColorConstant.red),
          SpacerWidget.small(),
          TextWidget.body(message, context: context),
          SpacerWidget.medium(),
          ButtonWidget.primary(
            label: buttonText,
            backgroundColor: ColorConstant.red,
            onPressed: () => Navigator.of(context).pop(),
            context: context,
          ),
        ],
      ),
    );
  }

  static Future<void> logout({required BuildContext context}) {
    return show<void>(
      context: context,
      title: 'Logout',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextWidget.body('Are you sure you want to logout?', context: context),
          SpacerWidget.medium(),
          Row(
            children: [
              Expanded(
                child: ButtonWidget.secondary(
                  label: 'Cancel',
                  onPressed: () => Navigator.of(context).pop(),
                  context: context,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: ButtonWidget.primary(
                  label: 'Logout',
                  backgroundColor: ColorConstant.red,
                  onPressed: () {
                    context.read<AuthBloc>().add(LogoutRequested());
                    context.read<RoleResolverCubit>().clearSavedRole();
                    Navigator.of(context).pop();
                    context.go('/login');
                  },
                  context: context,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
