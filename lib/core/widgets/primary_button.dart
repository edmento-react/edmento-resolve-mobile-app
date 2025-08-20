import 'package:edmentoresolve/core/constants/color_constant.dart';
import 'package:edmentoresolve/core/constants/style_constant.dart';
import 'package:edmentoresolve/core/utils/screen_util.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool loading;
  final Color backgroundColor;
  final Color foregroundColor;
  final EdgeInsetsGeometry? padding;
  final double borderRadius;
  final TextStyle? textStyle;

  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.loading = false,
    this.backgroundColor = ColorConstant.primaryColorLight,
    this.foregroundColor = ColorConstant.white,
    this.padding,
    this.borderRadius = 12,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: loading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        padding:
            padding ??
            EdgeInsets.symmetric(
              vertical: ScreenUtil.getResponsiveValue(
                smallPhone: 16,
                mobile: 16,
                tablet: 18,
                largeTablet: 20,
              ),
              horizontal: ScreenUtil.getResponsiveValue(
                smallPhone: 20,
                mobile: 20,
                tablet: 24,
                largeTablet: 28,
              ),
            ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
      child: loading
          ? SizedBox(
              height: ScreenUtil.getResponsiveValue(
                smallPhone: 20,
                mobile: 20,
                tablet: 24,
                largeTablet: 28,
              ),
              width: ScreenUtil.getResponsiveValue(
                smallPhone: 20,
                mobile: 20,
                tablet: 24,
                largeTablet: 28,
              ),
              child: CircularProgressIndicator(
                strokeWidth: ScreenUtil.getResponsiveValue(
                  smallPhone: 1.5,
                  mobile: 2,
                  tablet: 2.5,
                  largeTablet: 3,
                ),
                valueColor: AlwaysStoppedAnimation<Color>(foregroundColor),
              ),
            )
          : Text(
              label,
              style:
                  textStyle ??
                  StyleConstant.label(context).copyWith(
                    color: foregroundColor,
                    fontWeight: FontWeight.w600,
                    fontSize: ScreenUtil.getAdaptiveFontSize(16, 16, 18, 20),
                  ),
            ),
    );
  }
}
