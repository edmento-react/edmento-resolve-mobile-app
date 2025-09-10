import 'package:edmentoresolve/core/constants/color_constant.dart';
import 'package:edmentoresolve/core/widgets/spacer_widget.dart';
import 'package:edmentoresolve/core/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FeatureCard extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData icon;
  final Color? iconColor;
  final Color? backgroundColor;
  final VoidCallback? onTap;
  final bool isEnabled;
  final Widget? trailing;

  const FeatureCard({
    super.key,
    required this.title,
    this.subtitle,
    required this.icon,
    this.iconColor,
    this.backgroundColor,
    this.onTap,
    this.isEnabled = true,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: InkWell(
        onTap: isEnabled ? onTap : null,
        borderRadius: BorderRadius.circular(12.r),
        child: Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: backgroundColor ?? colorScheme.surface,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: (iconColor ?? ColorConstant.blue).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(
                  icon,
                  size: 24.w,
                  color: iconColor ?? ColorConstant.blue,
                ),
              ),
              SpacerWidget.widthMedium(),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget.heading4(
                      title,
                      context: context,
                      color: isEnabled ? null : colorScheme.onSurfaceVariant,
                    ),
                    if (subtitle != null) ...[
                      SpacerWidget.tiny(),
                      TextWidget.caption(
                        subtitle!,
                        context: context,
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ],
                  ],
                ),
              ),
              if (trailing != null) ...[
                SpacerWidget.widthSmall(),
                trailing!,
              ] else if (onTap != null) ...[
                SpacerWidget.widthSmall(),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 16.w,
                  color: colorScheme.onSurfaceVariant,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  factory FeatureCard.action({
    required String title,
    String? subtitle,
    required IconData icon,
    required VoidCallback onTap,
    Color? iconColor,
    Color? backgroundColor,
  }) {
    return FeatureCard(
      title: title,
      subtitle: subtitle,
      icon: icon,
      iconColor: iconColor,
      backgroundColor: backgroundColor,
      onTap: onTap,
    );
  }

  factory FeatureCard.info({
    required String title,
    String? subtitle,
    required IconData icon,
    Color? iconColor,
    Color? backgroundColor,
    Widget? trailing,
  }) {
    return FeatureCard(
      title: title,
      subtitle: subtitle,
      icon: icon,
      iconColor: iconColor,
      backgroundColor: backgroundColor,
      trailing: trailing,
    );
  }

  factory FeatureCard.disabled({
    required String title,
    String? subtitle,
    required IconData icon,
    Color? backgroundColor,
  }) {
    return FeatureCard(
      title: title,
      subtitle: subtitle,
      icon: icon,
      iconColor: ColorConstant.grey400,
      backgroundColor: backgroundColor,
      isEnabled: false,
    );
  }
}
