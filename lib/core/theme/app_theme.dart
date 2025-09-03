import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/color_constant.dart';

class AppTheme {
  static const _borderRadius = 12.0;
  static const _cardBorderRadius = 16.0;
  static const _inputBorderRadius = 8.0;

  // Light Theme
  static ThemeData get lightTheme {
    final base = ColorScheme.fromSeed(
      seedColor: ColorConstant.primaryLight,
      brightness: Brightness.light,
    );

    final colorScheme = base.copyWith(
      primary: ColorConstant.primaryLight,
      secondary: ColorConstant.secondaryLight,
      surface: ColorConstant.surfaceLight,
      onSurface: ColorConstant.textPrimaryLight,
      error: ColorConstant.errorLight,
      outlineVariant: ColorConstant.dividerLight,
      outline: ColorConstant.cardBorderLight,
    );

    return _buildBaseTheme(colorScheme: colorScheme);
  }

  // Dark Theme
  static ThemeData get darkTheme {
    final base = ColorScheme.fromSeed(
      seedColor: ColorConstant.primaryLight,
      brightness: Brightness.dark,
    );

    final colorScheme = base.copyWith(
      primary: ColorConstant.primaryDark,
      secondary: ColorConstant.secondaryDark,
      surface: ColorConstant.surfaceDark,
      onSurface: ColorConstant.textPrimaryDark,
      error: ColorConstant.errorDark,
      outlineVariant: ColorConstant.dividerDark,
      outline: ColorConstant.cardBorderDark,
    );

    return _buildBaseTheme(colorScheme: colorScheme);
  }

  static ThemeData _buildBaseTheme({required ColorScheme colorScheme}) {
    final isDark = colorScheme.brightness == Brightness.dark;
    return ThemeData(
      useMaterial3: true,
      brightness: isDark ? Brightness.dark : Brightness.light,
      fontFamily: 'Manrope',
      colorScheme: colorScheme,

      // Scaffold & Background
      scaffoldBackgroundColor: colorScheme.surface,
      cardColor: isDark ? ColorConstant.cardDark : ColorConstant.cardLight,

      // Text Theme
      textTheme: _buildTextTheme(colorScheme),

      // App Bar Theme
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        centerTitle: false,
        titleTextStyle: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
          color: colorScheme.onSurface,
        ),
      ),

      // Button Themes
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: ColorConstant.white,
          disabledBackgroundColor: isDark
              ? ColorConstant.grey700
              : ColorConstant.grey300,
          disabledForegroundColor: isDark
              ? ColorConstant.grey500
              : ColorConstant.grey600,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(_borderRadius),
          ),
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: colorScheme.primary,
          side: BorderSide(color: colorScheme.primary),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(_borderRadius),
          ),
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: colorScheme.primary,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        ),
      ),

      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colorScheme.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_inputBorderRadius),
          borderSide: BorderSide(color: colorScheme.outlineVariant),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_inputBorderRadius),
          borderSide: BorderSide(color: colorScheme.outlineVariant),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_inputBorderRadius),
          borderSide: BorderSide(color: colorScheme.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_inputBorderRadius),
          borderSide: BorderSide(color: colorScheme.error, width: 1.5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_inputBorderRadius),
          borderSide: BorderSide(color: colorScheme.error, width: 2),
        ),
        labelStyle: TextStyle(
          color: isDark
              ? ColorConstant.textLabelDark
              : ColorConstant.textLabelLight,
        ),
        hintStyle: TextStyle(
          color: isDark
              ? ColorConstant.textCaptionDark
              : ColorConstant.textCaptionLight,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      ),

      // Card Theme
      cardTheme: CardThemeData(
        color: isDark ? ColorConstant.cardDark : ColorConstant.cardLight,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_cardBorderRadius),
          side: BorderSide(color: colorScheme.outlineVariant),
        ),
        elevation: 2,
        margin: EdgeInsets.all(8.w),
      ),

      // Divider Theme
      dividerTheme: DividerThemeData(
        color: colorScheme.outlineVariant,
        thickness: 1,
        space: 1,
      ),

      // Bottom Sheet Theme
      bottomSheetTheme: const BottomSheetThemeData(
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
      ),

      // Floating Action Button Theme
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: colorScheme.primary,
        foregroundColor: ColorConstant.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),

      // Icon Theme
      iconTheme: IconThemeData(color: colorScheme.onSurface, size: 24.w),

      // Chip Theme
      chipTheme: ChipThemeData(
        backgroundColor: colorScheme.surface,
        selectedColor: colorScheme.primary,
        labelStyle: TextStyle(color: colorScheme.onSurface),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }

  static TextTheme _buildTextTheme(ColorScheme colorScheme) {
    final isDark = colorScheme.brightness == Brightness.dark;
    return TextTheme(
      displayLarge: TextStyle(
        fontSize: 26.sp,
        fontWeight: FontWeight.w700,
        color: colorScheme.onSurface,
      ),
      displayMedium: TextStyle(
        fontSize: 22.sp,
        fontWeight: FontWeight.w700,
        color: colorScheme.onSurface,
      ),
      displaySmall: TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.w600,
        color: colorScheme.onSurface,
      ),
      titleLarge: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
        color: colorScheme.onSurface,
      ),
      titleMedium: TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.w600,
        color: colorScheme.onSurface,
      ),
      bodyLarge: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.normal,
        color: colorScheme.onSurface,
      ),
      bodyMedium: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.normal,
        color: colorScheme.onSurface,
      ),
      bodySmall: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.normal,
        color: colorScheme.onSurface,
      ),
      labelLarge: TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
        color: colorScheme.onSurface,
      ),
      labelSmall: TextStyle(
        fontSize: 10.sp,
        fontWeight: FontWeight.normal,
        color: colorScheme.onSurface,
      ),
    );
  }

  // Extension methods for easy theme access
  static ColorScheme of(BuildContext context) => Theme.of(context).colorScheme;
  static bool isDarkMode(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark;
}
