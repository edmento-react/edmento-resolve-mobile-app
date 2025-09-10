import 'package:edmentoresolve/core/constants/color_constant.dart';
import 'package:edmentoresolve/core/widgets/spacer_widget.dart';
import 'package:edmentoresolve/core/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
            padding ?? EdgeInsets.symmetric(vertical: 14.h, horizontal: 12.w),
        side: BorderSide(
          color: foregroundColor ?? ColorConstant.blue,
          width: 1.w,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 8.r),
        ),
        minimumSize: Size(double.infinity, 48.h),
      ),
      child: loading
          ? SizedBox(
              height: 20.h,
              width: 20.w,
              child: CircularProgressIndicator(
                strokeWidth: 2.w,
                valueColor: AlwaysStoppedAnimation<Color>(
                  foregroundColor ?? ColorConstant.blue,
                ),
              ),
            )
          : Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != null) ...[
                  Icon(icon, size: 18.w),
                  SpacerWidget.widthSmall(),
                ],
                TextWidget.label(
                  label,
                  context: context,
                  color: foregroundColor ?? ColorConstant.blue,
                ),
              ],
            ),
    );
  }

  static Widget primary({
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
    return ElevatedButton(
      onPressed: loading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? ColorConstant.blue,
        foregroundColor: foregroundColor ?? ColorConstant.white,
        padding:
            padding ?? EdgeInsets.symmetric(vertical: 14.h, horizontal: 16.w),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 8.r),
        ),
        minimumSize: Size(double.infinity, 48.h),
        elevation: 0,
        shadowColor: ColorConstant.transparent,
      ),
      child: loading
          ? SizedBox(
              height: 20.h,
              width: 20.w,
              child: CircularProgressIndicator(
                strokeWidth: 2.w,
                valueColor: AlwaysStoppedAnimation<Color>(
                  foregroundColor ?? ColorConstant.white,
                ),
              ),
            )
          : Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != null) ...[
                  Icon(icon, size: 18.w),
                  SpacerWidget.widthSmall(),
                ],
                TextWidget.label(
                  label,
                  context: context,
                  color: foregroundColor ?? ColorConstant.white,
                ),
              ],
            ),
    );
  }

  static Widget text({
    required String label,
    required VoidCallback? onPressed,
    bool loading = false,
    Color? foregroundColor,
    EdgeInsetsGeometry? padding,
    TextStyle? textStyle,
    IconData? icon,
    required BuildContext context,
  }) {
    return TextButton(
      onPressed: loading ? null : onPressed,
      style: TextButton.styleFrom(
        foregroundColor: foregroundColor ?? ColorConstant.blue,
        padding:
            padding ?? EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
        minimumSize: Size(0, 40.h),
      ),
      child: loading
          ? SizedBox(
              height: 16.h,
              width: 16.w,
              child: CircularProgressIndicator(
                strokeWidth: 2.w,
                valueColor: AlwaysStoppedAnimation<Color>(
                  foregroundColor ?? ColorConstant.blue,
                ),
              ),
            )
          : Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != null) ...[
                  Icon(icon, size: 16.w),
                  SpacerWidget.widthCustom(6),
                ],
                TextWidget.label(
                  label,
                  context: context,
                  color: foregroundColor ?? ColorConstant.blue,
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
    EdgeInsetsGeometry? padding,
    double? borderRadius,
    required BuildContext context,
  }) {
    return IconButton(
      onPressed: loading ? null : onPressed,
      style: IconButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor ?? ColorConstant.blue,
        padding: padding ?? EdgeInsets.all(8.w),
        minimumSize: Size(40.w, 40.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 8.r),
        ),
      ),
      icon: loading
          ? SizedBox(
              height: 20.h,
              width: 20.w,
              child: CircularProgressIndicator(
                strokeWidth: 2.w,
                valueColor: AlwaysStoppedAnimation<Color>(
                  foregroundColor ?? ColorConstant.blue,
                ),
              ),
            )
          : Icon(icon, size: 20.w),
    );
  }

  static Widget floating({
    required IconData icon,
    required VoidCallback? onPressed,
    bool loading = false,
    Color? backgroundColor,
    Color? foregroundColor,
    required BuildContext context,
  }) {
    return FloatingActionButton(
      onPressed: loading ? null : onPressed,
      backgroundColor: backgroundColor ?? ColorConstant.blue,
      foregroundColor: foregroundColor ?? ColorConstant.white,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      child: loading
          ? SizedBox(
              height: 24.h,
              width: 24.w,
              child: CircularProgressIndicator(
                strokeWidth: 2.w,
                valueColor: AlwaysStoppedAnimation<Color>(
                  foregroundColor ?? ColorConstant.white,
                ),
              ),
            )
          : Icon(icon, size: 24.w),
    );
  }

  static Widget chip({
    required String label,
    required VoidCallback? onPressed,
    bool selected = false,
    Color? backgroundColor,
    Color? foregroundColor,
    Color? selectedColor,
    IconData? icon,
    required BuildContext context,
  }) {
    return FilterChip(
      label: TextWidget.caption(
        label,
        context: context,
        color: selected
            ? (foregroundColor ?? ColorConstant.white)
            : (foregroundColor ?? ColorConstant.blue),
      ),
      selected: selected,
      onSelected: onPressed != null ? (_) => onPressed() : null,
      backgroundColor: backgroundColor ?? ColorConstant.grey100,
      selectedColor: selectedColor ?? ColorConstant.blue,
      checkmarkColor: foregroundColor ?? ColorConstant.white,
      side: BorderSide.none,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      avatar: icon != null ? Icon(icon, size: 16.w) : null,
    );
  }
}
