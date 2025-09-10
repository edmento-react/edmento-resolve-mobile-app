import 'package:edmentoresolve/core/constants/style_constant.dart';
import 'package:flutter/material.dart';

/// A flexible underline decoration that supports gradient or solid color
/// and can draw shorter-than-tab underlines with rounded corners.
class UnderlineFlexIndicator extends Decoration {
  final Gradient? gradient; // Use this for gradient underline
  final Color? color; // Use this for solid underline
  final double thickness;
  final double radius;

  /// If [matchLabelWidth] is true and TabBar uses [indicatorSize = TabBarIndicatorSize.label],
  /// the underline will match the label (text) width. Otherwise, it will use [widthFactor]
  /// relative to the tab's box width.
  final bool matchLabelWidth;
  final double widthFactor; // 0..1 when matchLabelWidth == false

  const UnderlineFlexIndicator({
    this.gradient,
    this.color,
    this.thickness = 2,
    this.radius = 2,
    this.matchLabelWidth = true,
    this.widthFactor = 0.35,
  }) : assert(
         gradient != null || color != null,
         'Either gradient or color must be provided',
       );

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) =>
      _UnderlineFlexPainter(this);
}

class _UnderlineFlexPainter extends BoxPainter {
  _UnderlineFlexPainter(this.decoration);
  final UnderlineFlexIndicator decoration;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration cfg) {
    if (cfg.size == null) return;
    final rect = offset & cfg.size!;
    final w = decoration.matchLabelWidth
        ? rect.width
        : rect.width * decoration.widthFactor;

    final left = rect.left + (rect.width - w) / 2;
    final top = rect.bottom - decoration.thickness;

    final rrect = RRect.fromRectAndCorners(
      Rect.fromLTWH(left, top, w, decoration.thickness),
      topLeft: Radius.circular(decoration.radius),
      topRight: Radius.circular(decoration.radius),
      bottomLeft: Radius.circular(decoration.radius),
      bottomRight: Radius.circular(decoration.radius),
    );

    final paint = Paint()..isAntiAlias = true;
    if (decoration.gradient != null) {
      paint.shader = decoration.gradient!.createShader(rrect.outerRect);
    } else {
      paint.color = decoration.color!;
    }
    canvas.drawRRect(rrect, paint);
  }
}

/// Reusable TabBar with named constructors:
/// - [AppTabBar.gradient] : gradient underline
/// - [AppTabBar.solid]    : solid underline
///
/// Defaults:
/// - Left aligned (start), scrollable
/// - Indicator matches label (text) width
/// - Thin bottom divider
class AppTabBar extends StatelessWidget implements PreferredSizeWidget {
  final List<String> tabs;
  final TabController? controller;
  final ValueChanged<int>? onTap;
  final bool isScrollable;
  final bool leftAlign;
  final EdgeInsetsGeometry labelPadding;
  final TextStyle? labelStyle;
  final TextStyle? unselectedLabelStyle;
  final Color? labelColor;
  final Color? unselectedLabelColor;
  final Color? indicatorColor; // always initialized in both constructors
  final Decoration? indicator;
  final TabBarIndicatorSize indicatorSize;
  final bool matchLabelWidth;
  final bool showBottomBorder;
  final Color? bottomBorderColor;

  // ----- Named constructor: GRADIENT -----
  AppTabBar.gradient({
    super.key,
    required this.tabs,
    this.controller,
    this.onTap,
    this.isScrollable = true,
    this.leftAlign = true,
    this.labelPadding = const EdgeInsets.symmetric(horizontal: 10),
    this.labelStyle,
    this.unselectedLabelStyle,
    this.labelColor,
    this.unselectedLabelColor,
    Gradient indicatorGradient = const LinearGradient(
      colors: [Color(0xFF6D28D9), Color(0xFFEF4444)], // violet → red
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    ),
    double indicatorThickness = 3,
    double indicatorRadius = 2,
    this.matchLabelWidth = true,
    double indicatorWidthFactor = 0.45,
    this.indicatorSize = TabBarIndicatorSize.label,
    this.showBottomBorder = true,
    this.bottomBorderColor,
  }) : indicatorColor = null, // ✅ ensure initialized
       indicator = UnderlineFlexIndicator(
         gradient: indicatorGradient,
         thickness: indicatorThickness,
         radius: indicatorRadius,
         matchLabelWidth: matchLabelWidth,
         widthFactor: indicatorWidthFactor,
       );

  // ----- Named constructor: SOLID -----
  const AppTabBar.solid({
    super.key,
    required this.tabs,
    this.controller,
    this.onTap,
    this.isScrollable = true,
    this.leftAlign = true,
    this.labelPadding = const EdgeInsets.symmetric(horizontal: 10),
    this.labelStyle,
    this.unselectedLabelStyle,
    this.labelColor,
    this.unselectedLabelColor,
    this.indicatorColor,
    this.matchLabelWidth = true,
    this.indicatorSize = TabBarIndicatorSize.label,
    this.showBottomBorder = true,
    this.bottomBorderColor,
  }) : indicator = null;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final resolvedIndicator =
        indicator ??
        UnderlineTabIndicator(
          borderSide: BorderSide(
            color: indicatorColor ?? theme.colorScheme.onSurface,
            width: 2,
          ),
          insets: EdgeInsets.zero,
        );

    // 🔹 Measure total tabs width (rough) to decide edge padding side
    final screenWidth = MediaQuery.of(context).size.width;
    final textPainter = TextPainter(textDirection: TextDirection.ltr);
    double totalWidth = 0;
    for (final t in tabs) {
      textPainter.text = TextSpan(
        text: t,
        style: labelStyle ?? StyleConstant.heading4(context),
      );
      textPainter.layout();
      totalWidth += textPainter.width + 20; // ≈ labelPadding.h (10 + 10)
    }
    final needsEdgePadding = totalWidth >= screenWidth;

    // ✅ Single place to control the “edge” padding for BOTH tabs and indicator
    final tabStripEdgePadding = needsEdgePadding
        ? const EdgeInsets.symmetric(horizontal: 10) // when overflowing
        : const EdgeInsets.only(left: 10); // when not

    final tabBar = TabBar(
      controller: controller,
      isScrollable: isScrollable,
      tabAlignment: leftAlign ? TabAlignment.start : null,
      onTap: onTap,
      tabs: tabs.map((t) => Tab(text: t)).toList(),

      // spacing between labels
      labelPadding: labelPadding,

      // 🔑 This pads the whole tab row; indicator respects this too
      padding: tabStripEdgePadding,

      labelColor: labelColor ?? theme.colorScheme.onSurface,
      unselectedLabelColor:
          unselectedLabelColor ?? theme.colorScheme.onSurface.withOpacity(0.45),
      labelStyle: (labelStyle ?? StyleConstant.heading4(context)),
      unselectedLabelStyle:
          (unselectedLabelStyle ??
          StyleConstant.heading4(
            context,
          ).copyWith(fontWeight: FontWeight.normal)),
      indicator: resolvedIndicator,
      indicatorSize: indicatorSize,
      splashBorderRadius: BorderRadius.circular(8),
    );

    if (!showBottomBorder) return tabBar;

    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: bottomBorderColor ?? theme.dividerColor,
            width: 1,
          ),
        ),
      ),
      child: tabBar,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
