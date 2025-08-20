import 'dart:io';

import 'package:edmentoresolve/core/constants/color_constant.dart';
import 'package:edmentoresolve/core/utils/screen_util.dart';
import 'package:edmentoresolve/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:edmentoresolve/features/authentication/presentation/bloc/role_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
            padding:
                padding ??
                EdgeInsets.all(
                  ScreenUtil.getResponsiveValue(
                    smallPhone: 16,
                    mobile: 24,
                    tablet: 28,
                    largeTablet: 32,
                  ),
                ),
            child: child,
          ),
        ),
      );
    } else {
      return showDialog<T>(
        context: context,
        barrierDismissible: barrierDismissible,
        builder: (context) => Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              ScreenUtil.getResponsiveValue(
                smallPhone: 12,
                mobile: 16,
                tablet: 20,
                largeTablet: 24,
              ),
            ),
          ),
          child: Padding(
            padding:
                padding ??
                EdgeInsets.all(
                  ScreenUtil.getResponsiveValue(
                    smallPhone: 16,
                    mobile: 24,
                    tablet: 28,
                    largeTablet: 32,
                  ),
                ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextWidget.heading3(title, context: context),
                SizedBox(
                  height: ScreenUtil.getSpacing(smallPhone: 8, mobile: 16),
                ),
                child,
              ],
            ),
          ),
        ),
      );
    }
  }

  static Future<void> showThemed({
    required BuildContext context,
    required String title,
    required Widget child,
    bool barrierDismissible = true,
    Color? backgroundColor,
    Color? titleColor,
    Color? contentColor,
    List<Widget>? actions,
  }) async {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return showDialog<void>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) => AlertDialog(
        backgroundColor:
            backgroundColor ??
            (isDark
                ? ColorConstant.surfaceColorDark
                : ColorConstant.surfaceColorLight),
        title: Text(
          title,
          style: TextStyle(
            color:
                titleColor ??
                (isDark
                    ? ColorConstant.textPrimaryColorDark
                    : ColorConstant.textPrimaryColorLight),
            fontWeight: FontWeight.bold,
          ),
        ),
        content: DefaultTextStyle(
          style: TextStyle(
            color:
                contentColor ??
                (isDark
                    ? ColorConstant.textSecondaryColorDark
                    : ColorConstant.textSecondaryColorLight),
          ),
          child: child,
        ),
        actions: actions,
      ),
    );
  }

  // TEMPORARY: Add logout confirmation dialog
  static Future<bool?> showLogoutConfirmation(BuildContext context) {
    if (Platform.isIOS) {
      return showCupertinoDialog<bool>(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: TextWidget.heading3('Sign Out', context: context),
          content: TextWidget.body(
            'Are you sure you want to sign out?',
            textAlign: TextAlign.center,
            context: context,
          ),
          actions: [
            CupertinoDialogAction(
              child: TextWidget.body('Cancel', context: context),
              onPressed: () => context.pop(false),
            ),
            CupertinoDialogAction(
              isDestructiveAction: true,
              onPressed: () {
                context.pop(true);
                context.read<AuthBloc>().add(LogoutRequested());
                context.read<RoleResolverCubit>().clearSavedRole();
              },
              child: TextWidget.body('Sign Out', context: context),
            ),
          ],
        ),
      );
    } else {
      return showDialog<bool>(
        context: context,
        barrierDismissible: true,
        builder: (context) => Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              ScreenUtil.getResponsiveValue(
                smallPhone: 12,
                mobile: 16,
                tablet: 20,
                largeTablet: 24,
              ),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(
              ScreenUtil.getResponsiveValue(
                smallPhone: 16,
                mobile: 24,
                tablet: 28,
                largeTablet: 32,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconWidget.large(Icons.logout, color: ColorConstant.orange),
                SpacerWidget.medium(),
                TextWidget.heading3('Sign Out', context: context),
                SpacerWidget.small(),
                TextWidget.body(
                  'Are you sure you want to sign out?',
                  textAlign: TextAlign.center,
                  context: context,
                ),
                SpacerWidget.large(),
                Row(
                  children: [
                    Expanded(
                      child: ButtonWidget.secondary(
                        context: context,
                        label: 'Cancel',
                        onPressed: () => context.pop(false),
                      ),
                    ),
                    SpacerWidget.widthMedium(),
                    Expanded(
                      child: ButtonWidget.secondary(
                        context: context,
                        label: 'Sign Out',
                        onPressed: () {
                          context.pop(true);
                          context.read<AuthBloc>().add(LogoutRequested());
                        },
                        foregroundColor: ColorConstant.orange,
                        icon: Icons.logout,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}
