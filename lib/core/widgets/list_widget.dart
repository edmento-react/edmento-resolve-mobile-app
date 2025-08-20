import 'package:edmentoresolve/core/constants/color_constant.dart';
import 'package:edmentoresolve/core/utils/screen_util.dart';
import 'package:flutter/material.dart';

class ListWidget {
  static Widget simple({
    required List<Widget> children,
    EdgeInsetsGeometry? padding,
    ScrollPhysics? physics,
    bool shrinkWrap = false,
    double? itemSpacing,
  }) {
    return ListView.separated(
      padding: padding ?? ScreenUtil.getAdaptivePadding(),
      physics: physics,
      shrinkWrap: shrinkWrap,
      itemCount: children.length,
      separatorBuilder: (context, index) => SizedBox(
        height: itemSpacing ?? ScreenUtil.getHeight(16),
      ),
      itemBuilder: (context, index) => children[index],
    );
  }

  static Widget builder({
    required Widget Function(BuildContext, int) itemBuilder,
    required int itemCount,
    EdgeInsetsGeometry? padding,
    ScrollPhysics? physics,
    bool shrinkWrap = false,
    double? itemSpacing,
  }) {
    return ListView.separated(
      padding: padding ?? ScreenUtil.getAdaptivePadding(),
      physics: physics,
      shrinkWrap: shrinkWrap,
      itemCount: itemCount,
      separatorBuilder: (context, index) => SizedBox(
        height: itemSpacing ?? ScreenUtil.getHeight(16),
      ),
      itemBuilder: itemBuilder,
    );
  }

  static Widget withDivider({
    required List<Widget> children,
    EdgeInsetsGeometry? padding,
    ScrollPhysics? physics,
    bool shrinkWrap = false,
    Widget? divider,
  }) {
    return ListView.separated(
      padding: padding ?? ScreenUtil.getAdaptivePadding(),
      physics: physics,
      shrinkWrap: shrinkWrap,
      itemCount: children.length,
      separatorBuilder: (context, index) => divider ?? Divider(
        height: ScreenUtil.getHeight(1),
        thickness: ScreenUtil.getHeight(1),
        color: ColorConstant.grey300,
      ),
      itemBuilder: (context, index) => children[index],
    );
  }

  static Widget tile({
    required List<Widget> children,
    EdgeInsetsGeometry? padding,
    ScrollPhysics? physics,
    bool shrinkWrap = false,
    double? itemSpacing,
  }) {
    return ListView.separated(
      padding: padding ?? ScreenUtil.getAdaptivePadding(),
      physics: physics,
      shrinkWrap: shrinkWrap,
      itemCount: children.length,
      separatorBuilder: (context, index) => SizedBox(
        height: itemSpacing ?? ScreenUtil.getHeight(8),
      ),
      itemBuilder: (context, index) => Card(
        elevation: ScreenUtil.getResponsiveValue(
          smallPhone: 0.5,
          mobile: 1,
          tablet: 2,
          largeTablet: 3,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ScreenUtil.getRadius(12)),
        ),
        child: children[index],
      ),
    );
  }
} 