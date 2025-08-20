import 'package:edmentoresolve/core/constants/color_constant.dart';
import 'package:edmentoresolve/core/utils/screen_util.dart';
import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  final double? size;
  final Color color;
  final double? strokeWidth;

  const LoadingIndicator({
    super.key,
    this.size,
    this.color = ColorConstant.redDark,
    this.strokeWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height:
            size ??
            ScreenUtil.getResponsiveValue(
              smallPhone: 24,
              mobile: 32,
              tablet: 40,
              largeTablet: 48,
            ),
        width:
            size ??
            ScreenUtil.getResponsiveValue(
              smallPhone: 24,
              mobile: 32,
              tablet: 40,
              largeTablet: 48,
            ),
        child: CircularProgressIndicator(
          strokeWidth:
              strokeWidth ??
              ScreenUtil.getResponsiveValue(
                smallPhone: 2,
                mobile: 3,
                tablet: 4,
                largeTablet: 5,
              ),
          valueColor: AlwaysStoppedAnimation<Color>(color),
        ),
      ),
    );
  }
}
