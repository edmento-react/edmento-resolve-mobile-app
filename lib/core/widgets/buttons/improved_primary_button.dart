import 'package:edmentoresolve/core/widgets/spacer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/color_constant.dart';
import '../text_widget.dart';

class ImprovedPrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool loading;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final EdgeInsetsGeometry? padding;
  final double borderRadius;
  final TextStyle? textStyle;
  final bool fullWidth;
  final IconData? icon;
  final bool outlined;

  const ImprovedPrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.loading = false,
    this.backgroundColor,
    this.foregroundColor,
    this.padding,
    this.borderRadius = 12,
    this.textStyle,
    this.fullWidth = false,
    this.icon,
    this.outlined = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final effectiveBackgroundColor =
        backgroundColor ??
        (outlined ? Colors.transparent : theme.colorScheme.primary);
    final effectiveForegroundColor =
        foregroundColor ??
        (outlined ? theme.colorScheme.primary : ColorConstant.white);

    final buttonStyle = outlined
        ? OutlinedButton.styleFrom(
            foregroundColor: effectiveForegroundColor,
            side: BorderSide(color: theme.colorScheme.primary),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            padding:
                padding ??
                EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          )
        : ElevatedButton.styleFrom(
            backgroundColor: effectiveBackgroundColor,
            foregroundColor: effectiveForegroundColor,
            disabledBackgroundColor: colorScheme.surface,
            disabledForegroundColor: colorScheme.onSurface.withOpacity(0.38),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            padding:
                padding ??
                EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          );

    final button = outlined
        ? OutlinedButton(
            onPressed: loading ? null : onPressed,
            style: buttonStyle,
            child: _buildChild(context),
          )
        : ElevatedButton(
            onPressed: loading ? null : onPressed,
            style: buttonStyle,
            child: _buildChild(context),
          );

    return fullWidth ? SizedBox(width: double.infinity, child: button) : button;
  }

  Widget _buildChild(BuildContext context) {
    if (loading) {
      return SizedBox(
        height: 20.h,
        width: 20.w,
        child: CircularProgressIndicator(
          strokeWidth: 2.w,
          valueColor: AlwaysStoppedAnimation<Color>(
            foregroundColor ?? ColorConstant.white,
          ),
        ),
      );
    }

    final children = <Widget>[];

    if (icon != null) {
      children.addAll([Icon(icon, size: 18.w), SpacerWidget.widthSmall()]);
    }

    children.add(
      TextWidget.label(
        label,
        context: context,
        fontWeight: FontWeight.w600,
        fontSize: 16.sp,
      ),
    );

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: children,
    );
  }
}
