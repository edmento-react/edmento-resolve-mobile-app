import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StyleConstant {
  /// Helper method for responsive font sizing
  /// Uses screenWidth to determine device type and scales accordingly
  static double _getResponsiveFontSize(
    double mobileSize,
    double tabletSize,
    double desktopSize,
  ) {
    final screenWidth = ScreenUtil().screenWidth;
    if (screenWidth >= 900) {
      return desktopSize.sp;
    } else if (screenWidth >= 600) {
      return tabletSize.sp;
    } else {
      return mobileSize.sp;
    }
  }

  static TextStyle heading1(BuildContext context) => TextStyle(
    fontSize: _getResponsiveFontSize(26, 32, 40),
    fontWeight: FontWeight.w700,
    color: Theme.of(context).colorScheme.onSurface,
  );

  static TextStyle heading2(BuildContext context) => TextStyle(
    fontSize: _getResponsiveFontSize(22, 26, 28),
    fontWeight: FontWeight.w700,
    color: Theme.of(context).colorScheme.onSurface,
  );

  static TextStyle heading3(BuildContext context) => TextStyle(
    fontSize: _getResponsiveFontSize(18, 20, 24),
    fontWeight: FontWeight.w600,
    color: Theme.of(context).colorScheme.onSurface,
  );

  static TextStyle heading4(BuildContext context) => TextStyle(
    fontSize: _getResponsiveFontSize(16, 18, 20),
    fontWeight: FontWeight.w600,
    color: Theme.of(context).colorScheme.onSurface,
  );

  static TextStyle body(BuildContext context) => TextStyle(
    fontSize: _getResponsiveFontSize(16, 16, 18),
    fontWeight: FontWeight.normal,
    color: Theme.of(context).colorScheme.onSurface,
  );

  static TextStyle caption(BuildContext context) => TextStyle(
    fontSize: _getResponsiveFontSize(14, 14, 16),
    fontWeight: FontWeight.normal,
    color: Theme.of(context).colorScheme.onSurfaceVariant,
  );

  static TextStyle small(BuildContext context) => TextStyle(
    fontSize: _getResponsiveFontSize(12, 13, 14),
    fontWeight: FontWeight.normal,
    color: Theme.of(context).colorScheme.onSurfaceVariant,
  );

  static TextStyle label(BuildContext context) => TextStyle(
    fontSize: _getResponsiveFontSize(14, 15, 16),
    fontWeight: FontWeight.w500,
    color: Theme.of(context).colorScheme.onSurfaceVariant,
  );

  // Additional utility methods for commonly used dimensions
  static double get smallSpacing => 8.w;
  static double get mediumSpacing => 16.w;
  static double get largeSpacing => 24.w;
  static double get extraLargeSpacing => 32.w;

  static double get smallRadius => 8.r;
  static double get mediumRadius => 12.r;
  static double get largeRadius => 16.r;
  static double get extraLargeRadius => 24.r;

  static double get smallIconSize => 16.w;
  static double get mediumIconSize => 24.w;
  static double get largeIconSize => 32.w;

  static EdgeInsets get smallPadding => EdgeInsets.all(8.w);
  static EdgeInsets get mediumPadding => EdgeInsets.all(16.w);
  static EdgeInsets get largePadding => EdgeInsets.all(24.w);

  static EdgeInsets get screenHorizontalPadding =>
      EdgeInsets.symmetric(horizontal: 16.w);
  static EdgeInsets get screenPadding => EdgeInsets.all(16.w);
}
