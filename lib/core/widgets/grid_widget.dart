import 'package:edmentoresolve/core/widgets/feedback/empty_state_widget.dart';
import 'package:edmentoresolve/core/widgets/feedback/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GridWidget<T> extends StatelessWidget {
  final List<T> items;
  final Widget Function(BuildContext context, T item, int index) itemBuilder;
  final int crossAxisCount;
  final double mainAxisSpacing;
  final double crossAxisSpacing;
  final double childAspectRatio;
  final bool isLoading;
  final String? emptyTitle;
  final String? emptySubtitle;
  final IconData? emptyIcon;
  final VoidCallback? onRefresh;
  final EdgeInsetsGeometry? padding;
  final ScrollPhysics? physics;
  final bool shrinkWrap;
  final ScrollController? controller;

  const GridWidget({
    super.key,
    required this.items,
    required this.itemBuilder,
    this.crossAxisCount = 2,
    this.mainAxisSpacing = 8,
    this.crossAxisSpacing = 8,
    this.childAspectRatio = 1.0,
    this.isLoading = false,
    this.emptyTitle,
    this.emptySubtitle,
    this.emptyIcon,
    this.onRefresh,
    this.padding,
    this.physics,
    this.shrinkWrap = false,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: LoadingIndicator());
    }

    if (items.isEmpty) {
      return EmptyStateWidget(
        title: emptyTitle ?? 'No items available',
        subtitle: emptySubtitle,
        icon: emptyIcon ?? Icons.grid_view_outlined,
        actionLabel: onRefresh != null ? 'Refresh' : null,
        onActionPressed: onRefresh,
      );
    }

    Widget gridView = GridView.builder(
      controller: controller,
      padding: padding ?? EdgeInsets.all(16.w),
      physics: physics,
      shrinkWrap: shrinkWrap,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: _getResponsiveCrossAxisCount(context),
        mainAxisSpacing: mainAxisSpacing.h,
        crossAxisSpacing: crossAxisSpacing.w,
        childAspectRatio: childAspectRatio,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) =>
          itemBuilder(context, items[index], index),
    );

    if (onRefresh != null) {
      return RefreshIndicator(
        onRefresh: () async {
          onRefresh!();
        },
        child: gridView,
      );
    }

    return gridView;
  }

  int _getResponsiveCrossAxisCount(BuildContext context) {
    final screenWidth = ScreenUtil().screenWidth;
    if (screenWidth >= 900) {
      return crossAxisCount + 2; // Desktop: more columns
    } else if (screenWidth >= 600) {
      return crossAxisCount + 1; // Tablet: one more column
    } else {
      return crossAxisCount; // Mobile: original count
    }
  }

  factory GridWidget.builder({
    required List<T> items,
    required Widget Function(BuildContext context, T item, int index)
    itemBuilder,
    int crossAxisCount = 2,
    double mainAxisSpacing = 8,
    double crossAxisSpacing = 8,
    double childAspectRatio = 1.0,
    bool isLoading = false,
    String? emptyTitle,
    String? emptySubtitle,
    IconData? emptyIcon,
    VoidCallback? onRefresh,
    EdgeInsetsGeometry? padding,
    ScrollPhysics? physics,
    bool shrinkWrap = false,
    ScrollController? controller,
  }) {
    return GridWidget<T>(
      items: items,
      itemBuilder: itemBuilder,
      crossAxisCount: crossAxisCount,
      mainAxisSpacing: mainAxisSpacing,
      crossAxisSpacing: crossAxisSpacing,
      childAspectRatio: childAspectRatio,
      isLoading: isLoading,
      emptyTitle: emptyTitle,
      emptySubtitle: emptySubtitle,
      emptyIcon: emptyIcon,
      onRefresh: onRefresh,
      padding: padding,
      physics: physics,
      shrinkWrap: shrinkWrap,
      controller: controller,
    );
  }

  factory GridWidget.staggered({
    required List<T> items,
    required Widget Function(BuildContext context, T item, int index)
    itemBuilder,
    int crossAxisCount = 2,
    double mainAxisSpacing = 8,
    double crossAxisSpacing = 8,
    bool isLoading = false,
    String? emptyTitle,
    String? emptySubtitle,
    IconData? emptyIcon,
    VoidCallback? onRefresh,
    EdgeInsetsGeometry? padding,
    ScrollPhysics? physics,
    bool shrinkWrap = false,
    ScrollController? controller,
  }) {
    return GridWidget<T>(
      items: items,
      itemBuilder: itemBuilder,
      crossAxisCount: crossAxisCount,
      mainAxisSpacing: mainAxisSpacing,
      crossAxisSpacing: crossAxisSpacing,
      childAspectRatio: 0.8, // Slightly different aspect ratio
      isLoading: isLoading,
      emptyTitle: emptyTitle,
      emptySubtitle: emptySubtitle,
      emptyIcon: emptyIcon,
      onRefresh: onRefresh,
      padding: padding,
      physics: physics,
      shrinkWrap: shrinkWrap,
      controller: controller,
    );
  }
}
