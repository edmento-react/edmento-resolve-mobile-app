import 'package:edmentoresolve/core/widgets/cards/app_card.dart';
import 'package:edmentoresolve/core/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:timeline_tile/timeline_tile.dart';

/// A reusable wrapper around [TimelineTile] with common styling.
class AppTimelineTile extends StatelessWidget {
  final String schedules;
  final String timeBlocks;
  final String? subtitle;
  final bool isFirst;
  final bool isLast;
  final bool isPast;
  final bool isDisabled;
  final Color? activeColor;
  final Color? nonActiveColor;
  final double indicatorSize;
  final Widget? leading; // custom child inside indicator
  final EdgeInsetsGeometry? padding;

  const AppTimelineTile({
    super.key,
    required this.schedules,
    required this.timeBlocks,
    this.subtitle,
    this.isFirst = false,
    this.isLast = false,
    this.isPast = false,
    this.isDisabled = false,
    this.activeColor,
    this.nonActiveColor,
    this.indicatorSize = 15,
    this.leading,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final Color effectiveActiveColor = activeColor ?? colorScheme.primary;

    final Color effectiveNonActiveColor = nonActiveColor ?? colorScheme.outline;

    final Color finalColor = isPast
        ? effectiveActiveColor
        : effectiveNonActiveColor;

    return SizedBox(
      height: ScreenUtil().screenHeight * 0.1,
      child: TimelineTile(
        alignment: TimelineAlign.start,
        isFirst: isFirst,
        isLast: isLast,

        beforeLineStyle: LineStyle(color: finalColor, thickness: 1.5),
        afterLineStyle: LineStyle(color: finalColor, thickness: 1.5),
        indicatorStyle: IndicatorStyle(
          padding: EdgeInsets.symmetric(vertical: 5.h),
          width: indicatorSize,
          height: indicatorSize,
          color: finalColor,
          indicator: leading, // if provided, overrides color circle
        ),
        endChild: Padding(
          padding: padding ?? EdgeInsets.only(left: 10.w),
          // child: Column(
          //   mainAxisSize: MainAxisSize.min,
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: [
          //     Text(
          //       title,
          //       style: theme.textTheme.titleMedium?.copyWith(
          //         fontWeight: FontWeight.w600,
          //       ),
          //     ),
          //     if (subtitle != null) ...[
          //       const SizedBox(height: 4),
          //       Text(
          //         subtitle!,
          //         style: theme.textTheme.bodyMedium?.copyWith(
          //           color: theme.colorScheme.onSurface.withOpacity(0.7),
          //         ),
          //       ),
          //     ],
          //   ],
          // ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: ScreenUtil().screenWidth * 0.20,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 300),
                  opacity: isDisabled || isPast ? 0.5 : 1.0,
                  child: TextWidget.body(
                    timeBlocks,
                    context: context,
                    // color: isDisabled || isPast
                    //     ? isDark
                    //           ? ColorConstant.textCaptionDark
                    //           : ColorConstant.textCaptionLight
                    //     : isDark
                    //     ? ColorConstant.textPrimaryDark
                    //     : ColorConstant.textPrimaryLight,
                  ),
                ),
              ),
              SpacerWidget.widthLarge(),
              Expanded(
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 300),
                  opacity: isDisabled || isPast ? 0.5 : 1.0,
                  child: AppCard.horizontal(
                    border: Border.all(color: colorScheme.outline),
                    elevation: 2,
                    height: ScreenUtil().screenHeight * 0.06,
                    title: schedules,
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
