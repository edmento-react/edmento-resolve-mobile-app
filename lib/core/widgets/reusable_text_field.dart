import 'package:edmentoresolve/core/constants/color_constant.dart';
import 'package:edmentoresolve/core/utils/screen_util.dart';
import 'package:flutter/material.dart';

class ReusableTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final void Function(String)? onSubmitted;
  final void Function(String)? onChanged;
  final bool enabled;
  final bool isValid;
  final String? hintText;
  final int? maxLines;
  final int? minLines;
  final bool isDark;
  final bool readOnly;
  final bool autoFocus;
  final bool isShadow;
  final VoidCallback? onTap;

  const ReusableTextField({
    super.key,
    required this.controller,
    required this.labelText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.keyboardType,
    this.validator,
    this.focusNode,
    this.textInputAction,
    this.onSubmitted,
    this.onChanged,
    this.enabled = true,
    this.hintText,
    this.maxLines = 1,
    this.minLines,
    this.isDark = true,
    this.isValid = true,
    this.isShadow = false,
    this.readOnly = false,
    this.autoFocus = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(
      ScreenUtil.getResponsiveValue(
        smallPhone: 8,
        mobile: 12,
        tablet: 16,
        largeTablet: 20,
      ),
    );

    Widget textField = TextFormField(
      controller: controller,
      focusNode: focusNode,
      obscureText: obscureText,
      keyboardType: keyboardType,
      validator: validator,
      autofocus: autoFocus,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      textInputAction: textInputAction,
      onFieldSubmitted: onSubmitted,
      onChanged: onChanged,
      onTap: onTap,
      enabled: enabled,
      readOnly: readOnly,
      maxLines: maxLines,
      minLines: minLines,
      style: TextStyle(
        fontSize: ScreenUtil.getResponsiveValue(
          smallPhone: 14,
          mobile: 16,
          tablet: 18,
          largeTablet: 20,
        ),
      ),

      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(
          color: isDark
              ? ColorConstant.textLabelColorDark
              : ColorConstant.textLabelColorLight,
        ),
        hintText: hintText,
        prefixIcon: prefixIcon != null
            ? Icon(
                prefixIcon,
                color: ColorConstant.grey500,
                size: ScreenUtil.getIconSize(
                  smallPhone: 16,
                  mobile: 20,
                  tablet: 24,
                  largeTablet: 28,
                ),
              )
            : null,
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: const BorderSide(
            color: ColorConstant.textSecondaryColorLight,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: const BorderSide(color: ColorConstant.transparent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: BorderSide(
            color: ColorConstant.primaryColorLight,
            width: ScreenUtil.getResponsiveValue(
              smallPhone: 1.5,
              mobile: 2,
              tablet: 2.5,
              largeTablet: 3,
            ),
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: const BorderSide(color: ColorConstant.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: BorderSide(
            color: ColorConstant.red,
            width: ScreenUtil.getResponsiveValue(
              smallPhone: 1.5,
              mobile: 2,
              tablet: 2.5,
              largeTablet: 3,
            ),
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: const BorderSide(color: ColorConstant.grey300),
        ),
        filled: true,
        fillColor: isDark
            ? ColorConstant.surfaceColorDark
            : ColorConstant.surfaceColorLight,
        contentPadding: EdgeInsets.symmetric(
          horizontal: ScreenUtil.getResponsiveValue(
            smallPhone: 16,
            mobile: 16,
            tablet: 20,
            largeTablet: 24,
          ),
          vertical: ScreenUtil.getResponsiveValue(
            smallPhone: 16,
            mobile: 16,
            tablet: 20,
            largeTablet: 24,
          ),
        ),
      ),
    );

    return Stack(
      children: [
        Positioned.fill(
          bottom: isValid ? 0 : 20,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              boxShadow: isShadow
                  ? [
                      BoxShadow(
                        color: isValid
                            ? ColorConstant.green.withOpacity(0.15)
                            : ColorConstant.red.withOpacity(0.15),
                        blurRadius: 6,
                        offset: const Offset(0, 1),
                        spreadRadius: 2,
                      ),
                    ]
                  : [],
            ),
          ),
        ),
        textField,
      ],
    );
  }
}
