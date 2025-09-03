import 'package:edmentoresolve/core/widgets/card_widget.dart';
import 'package:edmentoresolve/core/widgets/icon_widget.dart';
import 'package:edmentoresolve/core/widgets/spacer_widget.dart';
import 'package:edmentoresolve/core/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget cardContent({
  required BuildContext context,
  required IconData icon,
  required String title,
  String? value,
  required Color color,
  required String subtitle,
  VoidCallback? onTap,
}) {
  final colorScheme = Theme.of(context).colorScheme;
  return CardWidget(
    onTap: onTap,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconWidget.custom(
          icon,
          color: color,
          backgroundColor: color.withOpacity(0.1),
          size: 32.w,
          padding: EdgeInsets.all(12.w),
        ),
        SpacerWidget.medium(),
        if (value != null)
          TextWidget.heading2(
            value,
            color: colorScheme.onSurface,
            textAlign: TextAlign.center,
            context: context,
          ),
        SpacerWidget.tiny(),
        TextWidget.body(
          title,
          fontWeight: FontWeight.w600,
          color: colorScheme.onSurface,
          textAlign: TextAlign.center,
          context: context,
        ),
        SpacerWidget.tiny(),
        TextWidget.caption(
          subtitle,
          color: colorScheme.onSurfaceVariant,
          textAlign: TextAlign.center,
          context: context,
        ),
      ],
    ),
  );
}

class ContentWidget extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? backgroundColor;
  final bool addSafeArea;

  const ContentWidget({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.backgroundColor,
    this.addSafeArea = true,
  });

  @override
  Widget build(BuildContext context) {
    Widget content = Container(
      width: double.infinity,
      padding: padding ?? EdgeInsets.all(16.w),
      margin: margin,
      decoration: BoxDecoration(color: backgroundColor),
      child: child,
    );

    if (addSafeArea) {
      content = SafeArea(child: content);
    }

    return content;
  }

  factory ContentWidget.scrollable({
    required Widget child,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    Color? backgroundColor,
    bool addSafeArea = true,
    ScrollPhysics? physics,
  }) {
    return ContentWidget(
      padding: EdgeInsets.zero,
      margin: margin,
      backgroundColor: backgroundColor,
      addSafeArea: addSafeArea,
      child: SingleChildScrollView(
        physics: physics,
        padding: padding ?? EdgeInsets.all(16.w),
        child: child,
      ),
    );
  }

  factory ContentWidget.centeredColumn({
    required List<Widget> children,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    Color? backgroundColor,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.center,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
  }) {
    return ContentWidget(
      padding: padding,
      margin: margin,
      backgroundColor: backgroundColor,
      child: Column(
        mainAxisAlignment: mainAxisAlignment,
        crossAxisAlignment: crossAxisAlignment,
        children: children,
      ),
    );
  }

  factory ContentWidget.centeredRow({
    required List<Widget> children,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    Color? backgroundColor,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.center,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
  }) {
    return ContentWidget(
      padding: padding,
      margin: margin,
      backgroundColor: backgroundColor,
      child: Row(
        mainAxisAlignment: mainAxisAlignment,
        crossAxisAlignment: crossAxisAlignment,
        children: children,
      ),
    );
  }
}
