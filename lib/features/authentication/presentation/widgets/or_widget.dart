import 'package:edmentoresolve/core/constants/color_constant.dart';
import 'package:flutter/material.dart';

class OrWidget extends StatelessWidget {
  const OrWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Row(
      children: [
        Expanded(
          child: Divider(
            endIndent: 16,
            color: Theme.of(context).brightness == Brightness.dark
                ? ColorConstant.dividerColorDark
                : ColorConstant.dividerColorLight,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            'OR',
            style: TextStyle(
              color: isDark
                  ? ColorConstant.textSecondaryColorDark
                  : ColorConstant.textSecondaryColorLight,
            ),
          ),
        ),
        Expanded(
          child: Divider(
            indent: 16,
            color: Theme.of(context).brightness == Brightness.dark
                ? ColorConstant.dividerColorDark
                : ColorConstant.dividerColorLight,
          ),
        ),
      ],
    );
  }
}
