import 'package:edmentoresolve/core/constants/color_constant.dart';
import 'package:edmentoresolve/core/constants/style_constant.dart';
import 'package:edmentoresolve/core/utils/screen_util.dart';
import 'package:flutter/material.dart';

class ButtonWidget {
  static Widget secondary({
    required String label,
    required VoidCallback? onPressed,
    bool loading = false,
    Color? backgroundColor,
    Color? foregroundColor,
    EdgeInsetsGeometry? padding,
    double? borderRadius,
    TextStyle? textStyle,
    IconData? icon,
    required BuildContext context,
  }) {
    return OutlinedButton(
      onPressed: loading ? null : onPressed,
      style: OutlinedButton.styleFrom(
        backgroundColor: backgroundColor ?? ColorConstant.transparent,
        foregroundColor: foregroundColor ?? ColorConstant.blue,
        padding:
            padding ??
            EdgeInsets.symmetric(
              vertical: ScreenUtil.getResponsiveValue(
                smallPhone: 12,
                mobile: 16,
                tablet: 18,
                largeTablet: 20,
              ),
              horizontal: ScreenUtil.getResponsiveValue(
                smallPhone: 8,
                mobile: 10,
                tablet: 12,
                largeTablet: 16,
              ),
            ),
        side: BorderSide(
          color: foregroundColor ?? ColorConstant.blue,
          width: ScreenUtil.getResponsiveValue(
            smallPhone: 1,
            mobile: 1,
            tablet: 1.5,
            largeTablet: 2,
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            borderRadius ?? ScreenUtil.getRadius(12),
          ),
        ),
      ),
      child: loading
          ? SizedBox(
              height: ScreenUtil.getResponsiveValue(
                smallPhone: 16,
                mobile: 20,
                tablet: 24,
                largeTablet: 28,
              ),
              width: ScreenUtil.getResponsiveValue(
                smallPhone: 16,
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
                valueColor: AlwaysStoppedAnimation<Color>(
                  foregroundColor ?? ColorConstant.blue,
                ),
              ),
            )
          : Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != null) ...[
                  Icon(
                    icon,
                    size: ScreenUtil.getIconSize(
                      smallPhone: 14,
                      mobile: 16,
                      tablet: 18,
                      largeTablet: 20,
                    ),
                  ),
                  SizedBox(
                    width: ScreenUtil.getSpacing(smallPhone: 4, mobile: 8),
                  ),
                ],
                Text(
                  label,
                  style:
                      textStyle ??
                      StyleConstant.label(
                        context,
                      ).copyWith(fontWeight: FontWeight.w600),
                ),
              ],
            ),
    );
  }

  static Widget text({
    required String label,
    required VoidCallback? onPressed,
    bool loading = false,
    Color? color,
    TextStyle? textStyle,
    IconData? icon,
    required BuildContext context,
  }) {
    return TextButton(
      onPressed: loading ? null : onPressed,
      style: TextButton.styleFrom(
        foregroundColor: color ?? ColorConstant.blue,
        padding: EdgeInsets.symmetric(
          vertical: ScreenUtil.getResponsiveValue(
            smallPhone: 8,
            mobile: 12,
            tablet: 14,
            largeTablet: 16,
          ),
          horizontal: ScreenUtil.getResponsiveValue(
            smallPhone: 12,
            mobile: 16,
            tablet: 18,
            largeTablet: 20,
          ),
        ),
      ),
      child: loading
          ? SizedBox(
              height: ScreenUtil.getResponsiveValue(
                smallPhone: 12,
                mobile: 16,
                tablet: 18,
                largeTablet: 20,
              ),
              width: ScreenUtil.getResponsiveValue(
                smallPhone: 12,
                mobile: 16,
                tablet: 18,
                largeTablet: 20,
              ),
              child: CircularProgressIndicator(
                strokeWidth: ScreenUtil.getResponsiveValue(
                  smallPhone: 1,
                  mobile: 1.5,
                  tablet: 2,
                  largeTablet: 2.5,
                ),
                valueColor: AlwaysStoppedAnimation<Color>(
                  color ?? ColorConstant.blue,
                ),
              ),
            )
          : Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != null) ...[
                  Icon(
                    icon,
                    size: ScreenUtil.getIconSize(
                      smallPhone: 14,
                      mobile: 16,
                      tablet: 18,
                      largeTablet: 20,
                    ),
                  ),
                  SizedBox(
                    width: ScreenUtil.getSpacing(smallPhone: 4, mobile: 8),
                  ),
                ],
                Text(
                  label,
                  style:
                      textStyle ??
                      StyleConstant.body(
                        context,
                      ).copyWith(fontWeight: FontWeight.w500),
                ),
              ],
            ),
    );
  }

  static Widget icon({
    required IconData icon,
    required VoidCallback? onPressed,
    bool loading = false,
    Color? backgroundColor,
    Color? foregroundColor,
    double? size,
    double? borderRadius,
    EdgeInsetsGeometry? padding,
  }) {
    return SizedBox(
      width:
          size ??
          ScreenUtil.getResponsiveValue(
            smallPhone: 40,
            mobile: 48,
            tablet: 56,
            largeTablet: 64,
          ),
      height:
          size ??
          ScreenUtil.getResponsiveValue(
            smallPhone: 40,
            mobile: 48,
            tablet: 56,
            largeTablet: 64,
          ),
      child: Material(
        color: backgroundColor ?? ColorConstant.blue,
        borderRadius: BorderRadius.circular(
          borderRadius ?? ScreenUtil.getRadius(12),
        ),
        child: InkWell(
          onTap: loading ? null : onPressed,
          borderRadius: BorderRadius.circular(
            borderRadius ?? ScreenUtil.getRadius(12),
          ),
          child: Center(
            child: loading
                ? SizedBox(
                    height: ScreenUtil.getResponsiveValue(
                      smallPhone: 16,
                      mobile: 20,
                      tablet: 24,
                      largeTablet: 28,
                    ),
                    width: ScreenUtil.getResponsiveValue(
                      smallPhone: 16,
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
                      valueColor: AlwaysStoppedAnimation<Color>(
                        foregroundColor ?? ColorConstant.white,
                      ),
                    ),
                  )
                : Icon(
                    icon,
                    color: foregroundColor ?? ColorConstant.white,
                    size: ScreenUtil.getIconSize(
                      smallPhone: 14,
                      mobile: 16,
                      tablet: 18,
                      largeTablet: 20,
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  static Widget floating({
    required IconData icon,
    required VoidCallback? onPressed,
    bool loading = false,
    Color? backgroundColor,
    Color? foregroundColor,
    String? tooltip,
  }) {
    return FloatingActionButton(
      onPressed: loading ? null : onPressed,
      backgroundColor: backgroundColor ?? ColorConstant.blue,
      foregroundColor: foregroundColor ?? ColorConstant.white,
      tooltip: tooltip,
      child: loading
          ? SizedBox(
              height: ScreenUtil.getResponsiveValue(
                smallPhone: 20,
                mobile: 24,
                tablet: 28,
                largeTablet: 32,
              ),
              width: ScreenUtil.getResponsiveValue(
                smallPhone: 20,
                mobile: 24,
                tablet: 28,
                largeTablet: 32,
              ),
              child: CircularProgressIndicator(
                strokeWidth: ScreenUtil.getResponsiveValue(
                  smallPhone: 1.5,
                  mobile: 2,
                  tablet: 2.5,
                  largeTablet: 3,
                ),
                valueColor: AlwaysStoppedAnimation<Color>(
                  foregroundColor ?? ColorConstant.white,
                ),
              ),
            )
          : Icon(
              icon,
              size: ScreenUtil.getIconSize(
                smallPhone: 18,
                mobile: 24,
                tablet: 28,
                largeTablet: 32,
              ),
            ),
    );
  }
}
