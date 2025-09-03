import 'package:edmentoresolve/core/constants/style_constant.dart';
import 'package:flutter/material.dart';

class TextWidget {
  static Widget heading1(
    String text, {
    Color? color,
    TextAlign? textAlign,
    FontWeight? fontWeight,
    double? fontSize,
    required BuildContext context,
  }) {
    return Text(
      text,
      style: StyleConstant.heading1(
        context,
      ).copyWith(color: color, fontWeight: fontWeight, fontSize: fontSize),
      textAlign: textAlign,
    );
  }

  static Widget heading2(
    String text, {
    Color? color,
    TextAlign? textAlign,
    FontWeight? fontWeight,
    double? fontSize,
    required BuildContext context,
  }) {
    return Text(
      text,
      style: StyleConstant.heading2(
        context,
      ).copyWith(color: color, fontWeight: fontWeight, fontSize: fontSize),
      textAlign: textAlign,
    );
  }

  static Widget heading3(
    String text, {
    Color? color,
    TextAlign? textAlign,
    FontWeight? fontWeight,
    double? fontSize,
    required BuildContext context,
  }) {
    return Text(
      text,
      style: StyleConstant.heading3(
        context,
      ).copyWith(color: color, fontWeight: fontWeight, fontSize: fontSize),
      textAlign: textAlign,
    );
  }

  static Widget heading4(
    String text, {
    Color? color,
    TextAlign? textAlign,
    FontWeight? fontWeight,
    double? fontSize,
    required BuildContext context,
  }) {
    return Text(
      text,
      style: StyleConstant.heading4(
        context,
      ).copyWith(color: color, fontWeight: fontWeight, fontSize: fontSize),
      textAlign: textAlign,
    );
  }

  static Widget body(
    String text, {
    Color? color,
    TextAlign? textAlign,
    FontWeight? fontWeight,
    double? fontSize,
    required BuildContext context,
  }) {
    return Text(
      text,
      style: StyleConstant.body(
        context,
      ).copyWith(color: color, fontWeight: fontWeight, fontSize: fontSize),
      textAlign: textAlign,
    );
  }

  static Widget caption(
    String text, {
    Color? color,
    TextAlign? textAlign,
    FontWeight? fontWeight,
    double? fontSize,
    required BuildContext context,
  }) {
    return Text(
      text,
      style: StyleConstant.caption(
        context,
      ).copyWith(color: color, fontWeight: fontWeight, fontSize: fontSize),
      textAlign: textAlign,
    );
  }

  static Widget small(
    String text, {
    Color? color,
    TextAlign? textAlign,
    FontWeight? fontWeight,
    double? fontSize,
    required BuildContext context,
  }) {
    return Text(
      text,
      style: StyleConstant.small(
        context,
      ).copyWith(color: color, fontWeight: fontWeight, fontSize: fontSize),
      textAlign: textAlign,
    );
  }

  static Widget label(
    String text, {
    Color? color,
    TextAlign? textAlign,
    FontWeight? fontWeight,
    double? fontSize,
    required BuildContext context,
  }) {
    return Text(
      text,
      style: StyleConstant.label(
        context,
      ).copyWith(color: color, fontWeight: fontWeight, fontSize: fontSize),
      textAlign: textAlign,
    );
  }
}
