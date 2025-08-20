import 'package:edmentoresolve/core/constants/color_constant.dart';
import 'package:edmentoresolve/core/constants/style_constant.dart';
import 'package:edmentoresolve/core/utils/screen_util.dart';
import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final Widget? leading;
  final Color backgroundColor;
  final Color foregroundColor;
  final bool automaticallyImplyLeading;
  final double elevation;
  final bool centerTitle;
  final Widget? titleWidget;

  const AppBarWidget({
    super.key,
    required this.title,
    this.actions,
    this.leading,
    this.backgroundColor = ColorConstant.primaryColorLight,
    this.foregroundColor = ColorConstant.white,
    this.automaticallyImplyLeading = true,
    this.elevation = 0,
    this.centerTitle = true,
    this.titleWidget,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title:
          titleWidget ??
          Text(
            title,
            style: StyleConstant.heading2(context).copyWith(
              fontWeight: FontWeight.w600,
              fontSize: ScreenUtil.getAdaptiveFontSize(18, 18, 20, 22),
              color: foregroundColor,
            ),
          ),
      surfaceTintColor: ColorConstant.transparent,
      actions: actions,
      leading: leading,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      automaticallyImplyLeading: automaticallyImplyLeading,
      elevation: elevation,
      centerTitle: centerTitle,
      toolbarHeight: ScreenUtil.getResponsiveValue(
        smallPhone: kToolbarHeight - 4,
        mobile: kToolbarHeight,
        tablet: kToolbarHeight + 8,
        largeTablet: kToolbarHeight + 16,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(
    ScreenUtil.getResponsiveValue(
      smallPhone: kToolbarHeight - 4,
      mobile: kToolbarHeight,
      tablet: kToolbarHeight + 8,
      largeTablet: kToolbarHeight + 16,
    ),
  );
}
