import 'package:edmentoresolve/core/widgets/feedback/empty_state_widget.dart';
import 'package:edmentoresolve/core/widgets/feedback/loading_indicator.dart';
import 'package:edmentoresolve/core/widgets/spacer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ListWidget<T> extends StatelessWidget {
  final List<T> items;
  final Widget Function(BuildContext context, T item, int index) itemBuilder;
  final Widget? separator;
  final bool isLoading;
  final String? emptyTitle;
  final String? emptySubtitle;
  final IconData? emptyIcon;
  final VoidCallback? onRefresh;
  final EdgeInsetsGeometry? padding;
  final ScrollPhysics? physics;
  final bool shrinkWrap;
  final ScrollController? controller;

  const ListWidget({
    super.key,
    required this.items,
    required this.itemBuilder,
    this.separator,
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
        icon: emptyIcon ?? Icons.inbox_outlined,
        actionLabel: onRefresh != null ? 'Refresh' : null,
        onActionPressed: onRefresh,
      );
    }

    Widget listView = ListView.separated(
      controller: controller,
      padding: padding ?? EdgeInsets.all(16.w),
      physics: physics,
      shrinkWrap: shrinkWrap,
      itemCount: items.length,
      separatorBuilder: (context, index) => separator ?? SpacerWidget.small(),
      itemBuilder: (context, index) =>
          itemBuilder(context, items[index], index),
    );

    if (onRefresh != null) {
      return RefreshIndicator(
        onRefresh: () async {
          onRefresh!();
        },
        child: listView,
      );
    }

    return listView;
  }

  factory ListWidget.builder({
    required List<T> items,
    required Widget Function(BuildContext context, T item, int index)
    itemBuilder,
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
    return ListWidget<T>(
      items: items,
      itemBuilder: itemBuilder,
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

  factory ListWidget.separated({
    required List<T> items,
    required Widget Function(BuildContext context, T item, int index)
    itemBuilder,
    Widget? separator,
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
    return ListWidget<T>(
      items: items,
      itemBuilder: itemBuilder,
      separator: separator,
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
