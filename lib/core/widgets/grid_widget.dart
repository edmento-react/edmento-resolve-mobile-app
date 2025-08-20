import 'package:edmentoresolve/core/utils/screen_util.dart';
import 'package:flutter/material.dart';

class GridWidget {
  static Widget responsive({
    required List<Widget> children,
    int? crossAxisCount,
    double? crossAxisSpacing,
    double? mainAxisSpacing,
    EdgeInsetsGeometry? padding,
    ScrollPhysics? physics,
    bool shrinkWrap = false,
    double? childAspectRatio,
  }) {
    return GridView.count(
      crossAxisCount: crossAxisCount ?? ScreenUtil.getGridCrossAxisCount(),
      crossAxisSpacing: crossAxisSpacing ?? ScreenUtil.getGridSpacing(),
      mainAxisSpacing: mainAxisSpacing ?? ScreenUtil.getGridSpacing(),
      padding: padding ?? ScreenUtil.getAdaptivePadding(),
      physics: physics,
      shrinkWrap: shrinkWrap,
      childAspectRatio: childAspectRatio ?? 1.0,
      children: children,
    );
  }

  static Widget builder({
    required Widget Function(BuildContext, int) itemBuilder,
    required int itemCount,
    int? crossAxisCount,
    double? crossAxisSpacing,
    double? mainAxisSpacing,
    EdgeInsetsGeometry? padding,
    ScrollPhysics? physics,
    bool shrinkWrap = false,
    double? childAspectRatio,
    double? mainAxisExtent,
  }) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount ?? ScreenUtil.getGridCrossAxisCount(),
        crossAxisSpacing: crossAxisSpacing ?? ScreenUtil.getGridSpacing(),
        mainAxisSpacing: mainAxisSpacing ?? ScreenUtil.getGridSpacing(),
        childAspectRatio: childAspectRatio ?? 1.0,
        mainAxisExtent: mainAxisExtent,
      ),
      itemCount: itemCount,
      itemBuilder: itemBuilder,
      padding: padding ?? ScreenUtil.getAdaptivePadding(),
      physics: physics,
      shrinkWrap: shrinkWrap,
    );
  }

  static Widget custom({
    required List<Widget> children,
    required SliverGridDelegate gridDelegate,
    EdgeInsetsGeometry? padding,
    ScrollPhysics? physics,
    bool shrinkWrap = false,
  }) {
    return GridView(
      gridDelegate: gridDelegate,
      padding: padding ?? ScreenUtil.getAdaptivePadding(),
      physics: physics,
      shrinkWrap: shrinkWrap,
      children: children,
    );
  }

  static Widget withMaxCrossAxisExtent({
    required List<Widget> children,
    required double maxCrossAxisExtent,
    double? crossAxisSpacing,
    double? mainAxisSpacing,
    double? childAspectRatio,
    EdgeInsetsGeometry? padding,
    ScrollPhysics? physics,
    bool shrinkWrap = false,
  }) {
    return GridView.extent(
      maxCrossAxisExtent: maxCrossAxisExtent,
      crossAxisSpacing: crossAxisSpacing ?? ScreenUtil.getGridSpacing(),
      mainAxisSpacing: mainAxisSpacing ?? ScreenUtil.getGridSpacing(),
      childAspectRatio: childAspectRatio ?? 1.0,
      padding: padding ?? ScreenUtil.getAdaptivePadding(),
      physics: physics,
      shrinkWrap: shrinkWrap,
      children: children,
    );
  }

  static SliverGridDelegateWithFixedCrossAxisCount fixedCrossAxisCount({
    required int crossAxisCount,
    double? crossAxisSpacing,
    double? mainAxisSpacing,
    double? childAspectRatio,
    double? mainAxisExtent,
  }) {
    return SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: crossAxisCount,
      crossAxisSpacing: crossAxisSpacing ?? ScreenUtil.getGridSpacing(),
      mainAxisSpacing: mainAxisSpacing ?? ScreenUtil.getGridSpacing(),
      childAspectRatio: childAspectRatio ?? 1.0,
      mainAxisExtent: mainAxisExtent,
    );
  }

  static SliverGridDelegateWithMaxCrossAxisExtent maxCrossAxisExtent({
    required double maxCrossAxisExtent,
    double? crossAxisSpacing,
    double? mainAxisSpacing,
    double? childAspectRatio,
    double? mainAxisExtent,
  }) {
    return SliverGridDelegateWithMaxCrossAxisExtent(
      maxCrossAxisExtent: maxCrossAxisExtent,
      crossAxisSpacing: crossAxisSpacing ?? ScreenUtil.getGridSpacing(),
      mainAxisSpacing: mainAxisSpacing ?? ScreenUtil.getGridSpacing(),
      childAspectRatio: childAspectRatio ?? 1.0,
      mainAxisExtent: mainAxisExtent,
    );
  }
}
