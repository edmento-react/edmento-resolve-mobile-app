import 'package:edmentoresolve/core/constants/color_constant.dart';
import 'package:edmentoresolve/core/widgets/buttons/button_widget.dart';
import 'package:edmentoresolve/core/widgets/media/icon_widget.dart';
import 'package:edmentoresolve/core/widgets/spacer_widget.dart';
import 'package:edmentoresolve/core/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmptyStateWidget extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData? icon;
  final String? actionLabel;
  final VoidCallback? onActionPressed;
  final Color? iconColor;
  final Color? textColor;
  final EdgeInsetsGeometry? padding;

  const EmptyStateWidget({
    super.key,
    required this.title,
    this.subtitle,
    this.icon,
    this.actionLabel,
    this.onActionPressed,
    this.iconColor,
    this.textColor,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: padding ?? EdgeInsets.all(32.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon
            if (icon != null)
              IconWidget.custom(
                icon!,
                size: 64.w,
                color: iconColor ?? ColorConstant.grey400,
              ),

            SpacerWidget.medium(),

            // Title
            TextWidget.heading3(
              title,
              context: context,
              textAlign: TextAlign.center,
              color: textColor,
            ),

            // Subtitle
            if (subtitle != null) ...[
              SpacerWidget.small(),
              TextWidget.body(
                subtitle!,
                context: context,
                textAlign: TextAlign.center,
                color: textColor?.withOpacity(0.7) ?? ColorConstant.grey600,
              ),
            ],

            // Action button
            if (actionLabel != null && onActionPressed != null) ...[
              SpacerWidget.large(),
              ButtonWidget.primary(
                label: actionLabel!,
                onPressed: onActionPressed,
                context: context,
              ),
            ],
          ],
        ),
      ),
    );
  }

  /// Factory for no data state
  factory EmptyStateWidget.noData({
    String title = 'No Data Available',
    String? subtitle = 'There\'s nothing to show here yet.',
    String? actionLabel,
    VoidCallback? onActionPressed,
  }) {
    return EmptyStateWidget(
      title: title,
      subtitle: subtitle,
      icon: Icons.inbox_outlined,
      actionLabel: actionLabel,
      onActionPressed: onActionPressed,
    );
  }

  /// Factory for no internet state
  factory EmptyStateWidget.noInternet({
    String title = 'No Internet Connection',
    String? subtitle = 'Please check your connection and try again.',
    String actionLabel = 'Retry',
    VoidCallback? onActionPressed,
  }) {
    return EmptyStateWidget(
      title: title,
      subtitle: subtitle,
      icon: Icons.wifi_off_outlined,
      actionLabel: actionLabel,
      onActionPressed: onActionPressed,
      iconColor: ColorConstant.orange,
    );
  }

  /// Factory for error state
  factory EmptyStateWidget.error({
    String title = 'Something went wrong',
    String? subtitle = 'An error occurred. Please try again.',
    String actionLabel = 'Retry',
    VoidCallback? onActionPressed,
  }) {
    return EmptyStateWidget(
      title: title,
      subtitle: subtitle,
      icon: Icons.error_outline,
      actionLabel: actionLabel,
      onActionPressed: onActionPressed,
      iconColor: ColorConstant.red,
    );
  }

  /// Factory for search no results
  factory EmptyStateWidget.searchEmpty({
    String title = 'No Results Found',
    String? subtitle = 'Try adjusting your search terms.',
    String? actionLabel,
    VoidCallback? onActionPressed,
  }) {
    return EmptyStateWidget(
      title: title,
      subtitle: subtitle,
      icon: Icons.search_off_outlined,
      actionLabel: actionLabel,
      onActionPressed: onActionPressed,
    );
  }

  /// Factory for loading state with shimmer
  factory EmptyStateWidget.loading({
    String title = 'Loading...',
    String? subtitle,
  }) {
    return EmptyStateWidget(
      title: title,
      subtitle: subtitle,
      icon: Icons.hourglass_empty,
      iconColor: ColorConstant.blue,
    );
  }
}
