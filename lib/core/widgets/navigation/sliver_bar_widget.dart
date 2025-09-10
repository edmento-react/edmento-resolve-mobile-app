import 'package:edmentoresolve/core/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SliverBarWidget extends StatelessWidget {
  final String title;
  final String? subtitle;
  final List<Widget>? actions;
  final Widget? leading;
  final bool pinned;
  final bool floating;
  final bool snap;
  final double? expandedHeight;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final FlexibleSpaceBar? flexibleSpace;
  final Widget? bottom;

  const SliverBarWidget({
    super.key,
    required this.title,
    this.subtitle,
    this.actions,
    this.leading,
    this.pinned = true,
    this.floating = false,
    this.snap = false,
    this.expandedHeight,
    this.backgroundColor,
    this.foregroundColor,
    this.flexibleSpace,
    this.bottom,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SliverAppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextWidget.heading3(
            title,
            context: context,
            color: foregroundColor ?? theme.appBarTheme.foregroundColor,
          ),
          if (subtitle != null)
            TextWidget.caption(
              subtitle!,
              context: context,
              color: (foregroundColor ?? theme.appBarTheme.foregroundColor)
                  ?.withOpacity(0.7),
            ),
        ],
      ),
      actions: actions,
      leading: leading,
      pinned: pinned,
      floating: floating,
      snap: snap,
      expandedHeight: expandedHeight ?? 120.h,
      backgroundColor: backgroundColor ?? theme.appBarTheme.backgroundColor,
      foregroundColor: foregroundColor ?? theme.appBarTheme.foregroundColor,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      flexibleSpace: flexibleSpace,
      bottom: bottom as PreferredSizeWidget?,
    );
  }

  factory SliverBarWidget.large({
    required String title,
    String? subtitle,
    List<Widget>? actions,
    Widget? leading,
    Color? backgroundColor,
    Color? foregroundColor,
    Widget? backgroundImage,
  }) {
    return SliverBarWidget(
      title: title,
      subtitle: subtitle,
      actions: actions,
      leading: leading,
      expandedHeight: 200.h,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      flexibleSpace: backgroundImage != null
          ? FlexibleSpaceBar(background: backgroundImage)
          : null,
    );
  }

  factory SliverBarWidget.collapsible({
    required String title,
    String? subtitle,
    List<Widget>? actions,
    Widget? leading,
    bool pinned = true,
    bool floating = true,
    bool snap = true,
    Color? backgroundColor,
    Color? foregroundColor,
  }) {
    return SliverBarWidget(
      title: title,
      subtitle: subtitle,
      actions: actions,
      leading: leading,
      pinned: pinned,
      floating: floating,
      snap: snap,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
    );
  }
}
