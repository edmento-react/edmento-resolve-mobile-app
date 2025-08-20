import 'dart:io';

import 'package:edmentoresolve/core/constants/color_constant.dart';
import 'package:edmentoresolve/core/utils/screen_util.dart';
import 'package:edmentoresolve/core/widgets/button_widget.dart';
import 'package:edmentoresolve/core/widgets/icon_widget.dart';
import 'package:edmentoresolve/core/widgets/spacer_widget.dart';
import 'package:edmentoresolve/core/widgets/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EmptyStateWidget extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData? icon;
  final String? actionLabel;
  final VoidCallback? onActionPressed;
  final Color? iconColor;
  final Color? textColor;

  const EmptyStateWidget({
    super.key,
    required this.title,
    this.subtitle,
    this.icon,
    this.actionLabel,
    this.onActionPressed,
    this.iconColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: ScreenUtil.getAdaptivePadding(
          smallPhoneHorizontal: 24,
          smallPhoneVertical: 24,
          horizontal: 32,
          vertical: 32,
          tabletHorizontal: 48,
          tabletVertical: 48,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              IconWidget.large(
                Platform.isIOS ? CupertinoIcons.info : icon!,
                color: iconColor ?? ColorConstant.grey400,
              ),
              SpacerWidget.large(),
            ],
            TextWidget.heading3(
              title,
              color: textColor ?? ColorConstant.textSecondaryColorLight,
              textAlign: TextAlign.center,
              context: context,
            ),
            if (subtitle != null) ...[
              SpacerWidget.medium(),
              TextWidget.body(
                subtitle!,
                color:
                    textColor?.withOpacity(0.7) ??
                    ColorConstant.textCaptionColorLight,
                textAlign: TextAlign.center,
                context: context,
              ),
            ],
            if (actionLabel != null && onActionPressed != null) ...[
              SpacerWidget.xlarge(),
              ButtonWidget.secondary(
                label: actionLabel!,
                onPressed: onActionPressed,
                icon: Icons.add,
                context: context,
              ),
            ],
          ],
        ),
      ),
    );
  }

  static Widget withIcon({
    required String title,
    required IconData icon,
    String? subtitle,
    String? actionLabel,
    VoidCallback? onActionPressed,
    Color? iconColor,
    Color? textColor,
  }) {
    return EmptyStateWidget(
      title: title,
      subtitle: subtitle,
      icon: icon,
      actionLabel: actionLabel,
      onActionPressed: onActionPressed,
      iconColor: iconColor,
      textColor: textColor,
    );
  }

  static Widget noData({String? actionLabel, VoidCallback? onActionPressed}) {
    return EmptyStateWidget(
      title: 'No Data Available',
      subtitle: 'There are no items to display at the moment.',
      icon: Platform.isIOS ? CupertinoIcons.cube_box : Icons.inbox_outlined,
      actionLabel: actionLabel,
      onActionPressed: onActionPressed,
    );
  }

  static Widget noResults({
    String? actionLabel,
    VoidCallback? onActionPressed,
  }) {
    return EmptyStateWidget(
      title: 'No Results Found',
      subtitle: 'Try adjusting your search criteria.',
      icon: Platform.isIOS ? CupertinoIcons.search : Icons.search_off,
      actionLabel: actionLabel,
      onActionPressed: onActionPressed,
    );
  }

  static Widget error({String? actionLabel, VoidCallback? onActionPressed}) {
    return EmptyStateWidget(
      title: 'Something Went Wrong',
      subtitle: 'We encountered an error. Please try again.',
      icon: Platform.isIOS
          ? CupertinoIcons.exclamationmark_circle
          : Icons.error_outline,
      actionLabel: actionLabel,
      onActionPressed: onActionPressed,
    );
  }

  static Widget loading({
    String title = 'Loading...',
    String? subtitle,
    required BuildContext context,
  }) {
    return Center(
      child: Padding(
        padding: ScreenUtil.getAdaptivePadding(
          smallPhoneHorizontal: 24,
          smallPhoneVertical: 24,
          horizontal: 32,
          vertical: 32,
          tabletHorizontal: 48,
          tabletVertical: 48,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: ScreenUtil.getResponsiveValue(
                smallPhone: 40,
                mobile: 48,
                tablet: 56,
                largeTablet: 64,
              ),
              width: ScreenUtil.getResponsiveValue(
                smallPhone: 40,
                mobile: 48,
                tablet: 56,
                largeTablet: 64,
              ),
              child: CircularProgressIndicator(
                strokeWidth: ScreenUtil.getResponsiveValue(
                  smallPhone: 2,
                  mobile: 3,
                  tablet: 4,
                  largeTablet: 5,
                ),
              ),
            ),
            SpacerWidget.large(),
            TextWidget.heading3(
              title,
              textAlign: TextAlign.center,
              context: context,
            ),
            if (subtitle != null) ...[
              SpacerWidget.medium(),
              TextWidget.body(
                subtitle,
                color: ColorConstant.grey600,
                textAlign: TextAlign.center,
                context: context,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
