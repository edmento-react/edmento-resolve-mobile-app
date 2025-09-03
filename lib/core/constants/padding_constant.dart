import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Centralized padding and spacing constants for consistent UI
class PaddingConstant {
  // Private constructor to prevent instantiation
  PaddingConstant._();

  // ===============================
  // SCREEN PADDINGS
  // ===============================

  /// Standard screen padding for most pages
  static EdgeInsets get screenPadding =>
      EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h);

  /// Compact screen padding for dense layouts
  static EdgeInsets get screenPaddingCompact =>
      EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h);

  /// Reduced screen padding for teacher home and similar dense layouts
  static EdgeInsets get screenPaddingReduced =>
      EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h);

  /// Large screen padding for spacious layouts
  static EdgeInsets get screenPaddingLarge =>
      EdgeInsets.symmetric(horizontal: 32.w, vertical: 32.h);

  /// Horizontal only screen padding
  static EdgeInsets get screenPaddingHorizontal =>
      EdgeInsets.symmetric(horizontal: 24.w);

  /// Vertical only screen padding
  static EdgeInsets get screenPaddingVertical =>
      EdgeInsets.symmetric(vertical: 24.h);

  // ===============================
  // CARD & WIDGET PADDINGS
  // ===============================

  /// Standard card internal padding
  static EdgeInsets get cardPadding => EdgeInsets.all(16.w);

  /// Compact card internal padding
  static EdgeInsets get cardPaddingCompact => EdgeInsets.all(12.w);

  /// Large card internal padding
  static EdgeInsets get cardPaddingLarge => EdgeInsets.all(20.w);

  /// Small card internal padding
  static EdgeInsets get cardPaddingSmall => EdgeInsets.all(8.w);

  /// Button internal padding
  static EdgeInsets get buttonPadding =>
      EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h);

  /// Small button internal padding
  static EdgeInsets get buttonPaddingSmall =>
      EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h);

  /// Large button internal padding
  static EdgeInsets get buttonPaddingLarge =>
      EdgeInsets.symmetric(horizontal: 32.w, vertical: 16.h);

  // ===============================
  // LIST & GRID SPACINGS
  // ===============================

  /// Standard margin between list/grid items
  static EdgeInsets get itemMargin => EdgeInsets.symmetric(vertical: 4.h);

  /// Large margin between list/grid items
  static EdgeInsets get itemMarginLarge => EdgeInsets.symmetric(vertical: 8.h);

  /// Small margin between list/grid items
  static EdgeInsets get itemMarginSmall => EdgeInsets.symmetric(vertical: 2.h);

  /// Grid item spacing
  static double get gridSpacing => 16.0;

  /// Small grid item spacing
  static double get gridSpacingSmall => 8.0;

  /// Large grid item spacing
  static double get gridSpacingLarge => 24.0;

  // ===============================
  // FORM & INPUT PADDINGS
  // ===============================

  /// Text field internal padding
  static EdgeInsets get textFieldPadding =>
      EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h);

  /// Form section padding
  static EdgeInsets get formSectionPadding =>
      EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h);

  /// Dialog padding
  static EdgeInsets get dialogPadding => EdgeInsets.all(24.w);

  // ===============================
  // RESPONSIVE PADDINGS
  // ===============================

  /// Responsive padding that adapts to screen size
  static EdgeInsets get responsivePadding => EdgeInsets.symmetric(
    horizontal: ScreenUtil().screenWidth > 600 ? 48.w : 24.w,
    vertical: ScreenUtil().screenHeight > 800 ? 32.h : 24.h,
  );

  /// Responsive horizontal padding
  static EdgeInsets get responsiveHorizontalPadding => EdgeInsets.symmetric(
    horizontal: ScreenUtil().screenWidth > 600 ? 48.w : 24.w,
  );

  // ===============================
  // SPECIALIZED PADDINGS
  // ===============================

  /// App bar padding
  static EdgeInsets get appBarPadding =>
      EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h);

  /// Bottom sheet padding
  static EdgeInsets get bottomSheetPadding =>
      EdgeInsets.fromLTRB(24.w, 16.h, 24.w, 24.h);

  /// Tab bar padding
  static EdgeInsets get tabBarPadding =>
      EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h);

  /// Floating action button margin
  static EdgeInsets get fabMargin => EdgeInsets.all(16.w);

  // ===============================
  // BORDER RADIUS VALUES
  // ===============================

  /// Standard border radius
  static double get borderRadius => 8.r;

  /// Small border radius
  static double get borderRadiusSmall => 4.r;

  /// Large border radius
  static double get borderRadiusLarge => 12.r;

  /// Extra large border radius
  static double get borderRadiusXLarge => 16.r;

  /// Card border radius
  static double get cardBorderRadius => 12.r;

  /// Button border radius
  static double get buttonBorderRadius => 8.r;

  // ===============================
  // ELEVATION VALUES
  // ===============================

  /// Standard card elevation
  static double get cardElevation => 2.0;

  /// Low elevation
  static double get elevationLow => 1.0;

  /// Medium elevation
  static double get elevationMedium => 4.0;

  /// High elevation
  static double get elevationHigh => 8.0;

  // ===============================
  // HELPER METHODS
  // ===============================

  /// Create custom symmetric padding
  static EdgeInsets symmetric({double horizontal = 0, double vertical = 0}) {
    return EdgeInsets.symmetric(horizontal: horizontal.w, vertical: vertical.h);
  }

  /// Create custom all-around padding
  static EdgeInsets all(double value) {
    return EdgeInsets.all(value.w);
  }

  /// Create custom directional padding
  static EdgeInsets only({
    double left = 0,
    double top = 0,
    double right = 0,
    double bottom = 0,
  }) {
    return EdgeInsets.only(
      left: left.w,
      top: top.h,
      right: right.w,
      bottom: bottom.h,
    );
  }

  /// Create custom LTRB padding
  static EdgeInsets fromLTRB(
    double left,
    double top,
    double right,
    double bottom,
  ) {
    return EdgeInsets.fromLTRB(left.w, top.h, right.w, bottom.h);
  }
}

/// Spacing constants for consistent gaps between widgets
class SpacingConstant {
  // Private constructor to prevent instantiation
  SpacingConstant._();

  // Vertical spacings
  static SizedBox get verticalTiny => SizedBox(height: 4.h);
  static SizedBox get verticalSmall => SizedBox(height: 8.h);
  static SizedBox get verticalMedium => SizedBox(height: 16.h);
  static SizedBox get verticalLarge => SizedBox(height: 24.h);
  static SizedBox get verticalXLarge => SizedBox(height: 32.h);
  static SizedBox get verticalXXLarge => SizedBox(height: 48.h);

  // Horizontal spacings
  static SizedBox get horizontalTiny => SizedBox(width: 4.w);
  static SizedBox get horizontalSmall => SizedBox(width: 8.w);
  static SizedBox get horizontalMedium => SizedBox(width: 16.w);
  static SizedBox get horizontalLarge => SizedBox(width: 24.w);
  static SizedBox get horizontalXLarge => SizedBox(width: 32.w);
  static SizedBox get horizontalXXLarge => SizedBox(width: 48.w);

  // Custom spacing helpers
  static SizedBox vertical(double height) => SizedBox(height: height.h);
  static SizedBox horizontal(double width) => SizedBox(width: width.w);
}
