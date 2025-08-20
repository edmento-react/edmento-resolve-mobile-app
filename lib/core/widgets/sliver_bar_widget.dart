import 'package:edmentoresolve/core/constants/color_constant.dart';
import 'package:edmentoresolve/core/utils/screen_util.dart';
import 'package:edmentoresolve/core/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class CustomSliverAppBar extends StatelessWidget {
  final String title;
  final List<Widget>? actions;
  final bool pinned;
  final bool floating;
  final Color backgroundColor;
  final Color foregroundColor;
  final bool snap;
  final double? expandedHeight;
  final Widget? flexibleSpace;
  final Widget? leading;
  final bool centerTitle;

  const CustomSliverAppBar({
    super.key,
    required this.title,
    this.actions,
    this.pinned = true,
    this.floating = false,
    this.snap = false,
    this.backgroundColor = ColorConstant.primaryColorLight,
    this.foregroundColor = ColorConstant.white,
    this.expandedHeight,
    this.flexibleSpace,
    this.leading,
    this.centerTitle = true,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: backgroundColor,
      foregroundColor: ColorConstant.white,
      surfaceTintColor: ColorConstant.transparent,
      pinned: pinned,
      floating: floating,
      snap: snap,
      expandedHeight: expandedHeight,
      toolbarHeight: ScreenUtil.getResponsiveValue(
        smallPhone: kToolbarHeight - 4,
        mobile: kToolbarHeight,
        tablet: kToolbarHeight + 8,
        largeTablet: kToolbarHeight + 16,
      ),
      actions: actions,
      leading: leading,
      centerTitle: centerTitle,
      title: TextWidget.heading3(title, context: context),
      flexibleSpace: flexibleSpace ?? const SizedBox(),
    );
  }
}
