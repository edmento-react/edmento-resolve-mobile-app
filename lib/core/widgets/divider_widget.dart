import 'package:edmentoresolve/core/constants/color_constant.dart';
import 'package:edmentoresolve/core/constants/style_constant.dart';
import 'package:edmentoresolve/core/utils/screen_util.dart';
import 'package:flutter/material.dart';

class DividerWidget {
  static Widget thin({
    Color? color,
    double? thickness,
    double? height,
    EdgeInsetsGeometry? margin,
  }) {
    return Container(
      height: height ?? ScreenUtil.getHeight(1),
      margin: margin ?? EdgeInsets.symmetric(vertical: ScreenUtil.getHeight(8)),
      decoration: BoxDecoration(
        color: color ?? ColorConstant.grey300,
        borderRadius: BorderRadius.circular(ScreenUtil.getRadius(0.5)),
      ),
    );
  }

  static Widget medium({
    Color? color,
    double? thickness,
    double? height,
    EdgeInsetsGeometry? margin,
  }) {
    return Container(
      height: height ?? ScreenUtil.getHeight(2),
      margin:
          margin ?? EdgeInsets.symmetric(vertical: ScreenUtil.getHeight(16)),
      decoration: BoxDecoration(
        color: color ?? ColorConstant.grey400,
        borderRadius: BorderRadius.circular(ScreenUtil.getRadius(1)),
      ),
    );
  }

  static Widget thick({
    Color? color,
    double? thickness,
    double? height,
    EdgeInsetsGeometry? margin,
  }) {
    return Container(
      height: height ?? ScreenUtil.getHeight(4),
      margin:
          margin ?? EdgeInsets.symmetric(vertical: ScreenUtil.getHeight(24)),
      decoration: BoxDecoration(
        color: color ?? ColorConstant.grey500,
        borderRadius: BorderRadius.circular(ScreenUtil.getRadius(2)),
      ),
    );
  }

  static Widget adaptive({
    Color? color,
    double? height,
    EdgeInsetsGeometry? margin,
  }) {
    return Container(
      height:
          height ??
          ScreenUtil.getResponsiveValue(
            smallPhone: 0.5,
            mobile: 1,
            tablet: 2,
            largeTablet: 3,
          ),
      margin:
          margin ??
          EdgeInsets.symmetric(
            vertical: ScreenUtil.getResponsiveValue(
              smallPhone: 4,
              mobile: 8,
              tablet: 16,
              largeTablet: 24,
            ),
          ),
      decoration: BoxDecoration(
        color: color ?? ColorConstant.grey300,
        borderRadius: BorderRadius.circular(ScreenUtil.getRadius(0.5)),
      ),
    );
  }

  static Widget withText(
    String text, {
    required BuildContext context,
    Color? color,
    TextStyle? textStyle,
    EdgeInsetsGeometry? margin,
  }) {
    return Container(
      margin:
          margin ?? EdgeInsets.symmetric(vertical: ScreenUtil.getHeight(16)),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: ScreenUtil.getHeight(1),
              decoration: BoxDecoration(
                color: color ?? ColorConstant.grey300,
                borderRadius: BorderRadius.circular(ScreenUtil.getRadius(0.5)),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: ScreenUtil.getWidth(16)),
            child: Text(
              text,
              style:
                  textStyle ??
                  StyleConstant.caption(context).copyWith(
                    color: ColorConstant.textSecondaryColorLight,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
          Expanded(
            child: Container(
              height: ScreenUtil.getHeight(1),
              decoration: BoxDecoration(
                color: color ?? ColorConstant.grey300,
                borderRadius: BorderRadius.circular(ScreenUtil.getRadius(0.5)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
