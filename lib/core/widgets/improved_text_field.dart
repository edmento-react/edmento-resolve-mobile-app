import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'text_widget.dart';

class ImprovedTextField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final String? hintText;
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
  final bool readOnly;
  final bool autoFocus;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final VoidCallback? onTap;
  final bool showCounter;
  final String? helperText;
  final String? errorText;
  final bool filled;
  final Color? fillColor;
  final EdgeInsetsGeometry? contentPadding;
  final double borderRadius;
  final bool showBorder;
  final Color? borderColor;
  final double borderWidth;

  const ImprovedTextField({
    super.key,
    required this.controller,
    required this.labelText,
    this.hintText,
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
    this.readOnly = false,
    this.autoFocus = false,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.inputFormatters,
    this.onTap,
    this.showCounter = false,
    this.helperText,
    this.errorText,
    this.filled = true,
    this.fillColor,
    this.contentPadding,
    this.borderRadius = 8,
    this.showBorder = true,
    this.borderColor,
    this.borderWidth = 1,
  });

  @override
  State<ImprovedTextField> createState() => _ImprovedTextFieldState();
}

class _ImprovedTextFieldState extends State<ImprovedTextField> {
  bool _obscureText = false;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
    _focusNode = widget.focusNode ?? FocusNode();
  }

  @override
  void dispose() {
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: widget.controller,
          focusNode: _focusNode,
          obscureText: _obscureText,
          keyboardType: widget.keyboardType,
          validator: widget.validator,
          autofocus: widget.autoFocus,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          textInputAction: widget.textInputAction,
          onFieldSubmitted: widget.onSubmitted,
          onChanged: widget.onChanged,
          onTap: widget.onTap,
          enabled: widget.enabled,
          readOnly: widget.readOnly,
          maxLines: widget.maxLines,
          minLines: widget.minLines,
          maxLength: widget.maxLength,
          inputFormatters: widget.inputFormatters,
          style: theme.textTheme.bodyLarge?.copyWith(fontSize: 16.sp),
          decoration: InputDecoration(
            labelText: widget.labelText,
            hintText: widget.hintText,
            helperText: widget.helperText,
            errorText: widget.errorText,
            prefixIcon: widget.prefixIcon != null
                ? Icon(
                    widget.prefixIcon,
                    color: theme.colorScheme.onSurface.withOpacity(0.6),
                    size: 20.w,
                  )
                : null,
            suffixIcon: _buildSuffixIcon(),
            border: widget.showBorder
                ? OutlineInputBorder(
                    borderRadius: BorderRadius.circular(widget.borderRadius),
                    borderSide: BorderSide(
                      color: widget.borderColor ?? theme.colorScheme.outline,
                      width: widget.borderWidth,
                    ),
                  )
                : InputBorder.none,
            enabledBorder: widget.showBorder
                ? OutlineInputBorder(
                    borderRadius: BorderRadius.circular(widget.borderRadius),
                    borderSide: BorderSide(
                      color: widget.borderColor ?? theme.colorScheme.outline,
                      width: widget.borderWidth,
                    ),
                  )
                : InputBorder.none,
            focusedBorder: widget.showBorder
                ? OutlineInputBorder(
                    borderRadius: BorderRadius.circular(widget.borderRadius),
                    borderSide: BorderSide(
                      color: theme.colorScheme.primary,
                      width: widget.borderWidth + 1,
                    ),
                  )
                : InputBorder.none,
            errorBorder: widget.showBorder
                ? OutlineInputBorder(
                    borderRadius: BorderRadius.circular(widget.borderRadius),
                    borderSide: BorderSide(
                      color: theme.colorScheme.error,
                      width: widget.borderWidth,
                    ),
                  )
                : InputBorder.none,
            focusedErrorBorder: widget.showBorder
                ? OutlineInputBorder(
                    borderRadius: BorderRadius.circular(widget.borderRadius),
                    borderSide: BorderSide(
                      color: theme.colorScheme.error,
                      width: widget.borderWidth + 1,
                    ),
                  )
                : InputBorder.none,
            disabledBorder: widget.showBorder
                ? OutlineInputBorder(
                    borderRadius: BorderRadius.circular(widget.borderRadius),
                    borderSide: BorderSide(
                      color: theme.colorScheme.outline.withOpacity(0.3),
                      width: widget.borderWidth,
                    ),
                  )
                : InputBorder.none,
            filled: widget.filled,
            fillColor: widget.fillColor ?? theme.colorScheme.surface,
            contentPadding:
                widget.contentPadding ??
                EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            counterText: widget.showCounter ? null : '',
          ),
        ),
        if (widget.maxLength != null && widget.showCounter)
          Padding(
            padding: EdgeInsets.only(top: 4.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextWidget.small(
                  '${widget.controller.text.length}/${widget.maxLength}',
                  context: context,
                  color: theme.colorScheme.onSurface.withOpacity(0.6),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget? _buildSuffixIcon() {
    if (widget.suffixIcon != null) {
      return widget.suffixIcon;
    }

    if (widget.obscureText) {
      return IconButton(
        icon: Icon(
          _obscureText ? Icons.visibility : Icons.visibility_off,
          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
        ),
        onPressed: () {
          setState(() {
            _obscureText = !_obscureText;
          });
        },
      );
    }

    return null;
  }
}
