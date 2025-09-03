import 'package:edmentoresolve/core/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Layout options for [AppCard].
enum AppCardLayout { vertical, horizontal }

/// A reusable card that can render content either vertically (image/icon -> text)
/// or horizontally (leading -> text -> trailing).
///
/// - Use [AppCard.vertical] for stacked/column content (good for dashboards/grids)
/// - Use [AppCard.horizontal] for list rows (good for lists with avatar + actions)
class AppCard extends StatelessWidget {
  final AppCardLayout layout;

  /// Core content
  final String? title;
  final String? subtitle;

  /// Optional widgets
  final Widget? leading; // avatar/icon/image
  final Widget? trailing; // button/value/icon
  final List<Widget>?
  badges; // small chips/pills under title/subtitle (vertical) or below title (horizontal)

  /// Behavior & visuals
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? padding;
  final double? width;
  final double? height;
  final Color? backgroundColor;
  final double borderRadius;
  final Gradient? gradient;
  final bool isLoading;
  final bool disabled;
  final BoxBorder? border;
  final double?
  elevation; // if null -> uses transparent Card “surfaceTint” look

  /// Named constructor: Vertical layout (Column)
  const AppCard.vertical({
    super.key,
    this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.badges,
    this.onTap,
    this.padding,
    this.width,
    this.height,
    this.gradient,
    this.backgroundColor,
    this.borderRadius = 10,
    this.isLoading = false,
    this.disabled = false,
    this.border,
    this.elevation,
  }) : layout = AppCardLayout.vertical;

  /// Named constructor: Horizontal layout (Row)
  const AppCard.horizontal({
    super.key,
    required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.badges,
    this.onTap,
    this.padding,
    this.width,
    this.height,
    this.gradient,
    this.backgroundColor,
    this.borderRadius = 10,
    this.isLoading = false,
    this.disabled = false,
    this.border,
    this.elevation,
  }) : layout = AppCardLayout.horizontal;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final effectiveBg = backgroundColor ?? Theme.of(context).cardColor;
    final isTappable = onTap != null && !disabled && !isLoading;

    final card = Material(
      color: gradient == null ? effectiveBg : Colors.transparent,
      elevation: elevation ?? 0,
      surfaceTintColor: elevation == null ? Colors.transparent : null,
      borderRadius: BorderRadius.circular(borderRadius),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(borderRadius),
          border: border ?? Border.all(color: scheme.outlineVariant, width: 1),
        ),
        padding: padding ?? EdgeInsets.all(20),
        child: _buildContent(context),
      ),
    );

    // Ripple + semantics
    if (isTappable) {
      return InkWell(
        borderRadius: BorderRadius.circular(borderRadius),
        onTap: onTap,
        child: card,
      );
    }
    return Opacity(opacity: disabled ? 0.6 : 1, child: card);
  }

  Widget _buildContent(BuildContext context) {
    if (isLoading) {
      return _Skeleton(layout: layout);
    }
    switch (layout) {
      case AppCardLayout.vertical:
        return _VerticalContent(
          title: title,
          subtitle: subtitle,
          leading: leading,
          trailing: trailing,
          badges: badges,
        );
      case AppCardLayout.horizontal:
        return _HorizontalContent(
          title: title,
          subtitle: subtitle,
          leading: leading,
          trailing: trailing,
          badges: badges,
        );
    }
  }
}

/// ---- Internal building blocks ----

class _VerticalContent extends StatelessWidget {
  const _VerticalContent({
    this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.badges,
  });

  final String? title;
  final String? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final List<Widget>? badges;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (leading != null)
          // Padding(
          //   padding: const EdgeInsets.only(bottom: 8),
          //   child: Align(alignment: Alignment.center, child: leading!),
          // ),
          Align(alignment: Alignment.center, child: leading!),
        if (title != null)
          TextWidget.heading4(
            context: context,
            title!,
            textAlign: TextAlign.center,
          ),
        if (subtitle != null) ...[
          const SizedBox(height: 4),
          TextWidget.body(
            subtitle!,
            context: context,
            textAlign: TextAlign.center,
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ],
        if (badges != null && badges!.isNotEmpty) ...[
          const SizedBox(height: 8),
          Wrap(
            spacing: 6,
            runSpacing: -6,
            alignment: WrapAlignment.center,
            children: badges!,
          ),
        ],
        if (trailing != null) ...[
          const SizedBox(height: 12),
          Align(alignment: Alignment.center, child: trailing!),
        ],
      ],
    );
  }
}

class _HorizontalContent extends StatelessWidget {
  const _HorizontalContent({
    this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.badges,
  });

  final String? title;
  final String? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final List<Widget>? badges;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (leading != null) ...[leading!, const SizedBox(width: 12)],
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (title != null)
                TextWidget.heading4(
                  context: context,
                  title!,
                  textAlign: TextAlign.center,
                ),
              if (subtitle != null)
                Padding(
                  padding: EdgeInsets.only(top: 2.h),
                  child: TextWidget.caption(context: context, subtitle!),
                ),
              if (badges != null && badges!.isNotEmpty) ...[
                const SizedBox(height: 8),
                Wrap(spacing: 6, runSpacing: -6, children: badges!),
              ],
            ],
          ),
        ),
        if (trailing != null) ...[const SizedBox(width: 12), trailing!],
      ],
    );
  }
}

class _Skeleton extends StatelessWidget {
  const _Skeleton({required this.layout});
  final AppCardLayout layout;

  @override
  Widget build(BuildContext context) {
    final base = Container(
      height: 12,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(6),
      ),
    );

    if (layout == AppCardLayout.vertical) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 8),
          Center(
            child: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                shape: BoxShape.circle,
              ),
            ),
          ),
          const SizedBox(height: 12),
          base,
          const SizedBox(height: 8),
          base,
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.center,
            child: Container(
              width: 80,
              height: 12,
              decoration: (base.decoration as BoxDecoration),
            ),
          ),
        ],
      );
    }

    // Horizontal
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(children: [base, const SizedBox(height: 8), base]),
        ),
        const SizedBox(width: 12),
        Container(
          width: 24,
          height: 24,
          decoration: (base.decoration as BoxDecoration),
        ),
      ],
    );
  }
}
