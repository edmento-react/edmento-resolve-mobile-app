import 'dart:io';

import 'package:flutter/material.dart';

class ScreenUtil {
  static late MediaQueryData _mediaQueryData;
  static late double _screenWidth;
  static late double _screenHeight;
  static late double _pixelRatio;
  static late double _statusBarHeight;
  static late double _bottomBarHeight;
  static late double _textScaleFactor;
  static late double _devicePixelRatio;
  static late bool _isTablet;
  static late bool _isPhone;
  static late bool _isSmallPhone;
  static late bool _isLargeScreen;
  static late Orientation _orientation;

  static void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    _screenWidth = _mediaQueryData.size.width;
    _screenHeight = _mediaQueryData.size.height;
    _pixelRatio = _mediaQueryData.devicePixelRatio;
    _statusBarHeight = _mediaQueryData.padding.top;
    _bottomBarHeight = _mediaQueryData.padding.bottom;
    _textScaleFactor = _mediaQueryData.textScaler.scale(1.0);
    _devicePixelRatio = _mediaQueryData.devicePixelRatio;
    _orientation = _mediaQueryData.orientation;

    // Determine device type with small phone support
    _isSmallPhone =
        _screenWidth <=
        411; // Small phones (Pixel 4, iPhone SE 2, small Android phones)
    _isPhone = _screenWidth > 411 && _screenWidth <= 600; // Regular phones
    _isTablet = _screenWidth > 600; // Tablets
    _isLargeScreen =
        _screenWidth >= 900; // Large screens (desktop, large tablets)
  }

  // Screen dimensions
  static double get screenWidth => _screenWidth;
  static double get screenHeight => _screenHeight;
  static double get pixelRatio => _pixelRatio;
  static double get statusBarHeight => _statusBarHeight;
  static double get bottomBarHeight => _bottomBarHeight;
  static double get textScaleFactor => _textScaleFactor;
  static double get devicePixelRatio => _devicePixelRatio;
  static Orientation get orientation => _orientation;

  // Device type
  static bool get isTablet => _isTablet;
  static bool get isPhone => _isPhone;
  static bool get isSmallPhone => _isSmallPhone;
  static bool get isLandscape => _orientation == Orientation.landscape;
  static bool get isPortrait => _orientation == Orientation.portrait;

  // Responsive sizing
  static double getWidth(double width) =>
      width * _screenWidth / 375; // Base width 375 (iPhone X)
  static double getHeight(double height) =>
      height * _screenHeight / 812; // Base height 812 (iPhone X)
  static double getRadius(double radius) => radius * _screenWidth / 375;
  static double getFontSize(double fontSize) => fontSize * _screenWidth / 375;

  // Percentage sizing
  static double getWidthPercent(double percent) => _screenWidth * percent / 100;
  static double getHeightPercent(double percent) =>
      _screenHeight * percent / 100;

  // Adaptive sizing based on device type with small phone support
  static double getAdaptiveWidth(
    double smallPhoneWidth,
    double phoneWidth,
    double tabletWidth,
  ) {
    if (_isSmallPhone) return smallPhoneWidth;
    if (_isPhone) return phoneWidth;
    return tabletWidth;
  }

  static double getAdaptiveHeight(
    double smallPhoneHeight,
    double phoneHeight,
    double tabletHeight,
  ) {
    if (_isSmallPhone) return smallPhoneHeight;
    if (_isPhone) return phoneHeight;
    return tabletHeight;
  }

  static double getAdaptiveFontSize(
    double smallPhoneSize,
    double phoneSize,
    double tabletSize,
    double largeTabletSize,
  ) {
    if (_isSmallPhone) return smallPhoneSize;
    if (_isPhone) return phoneSize;
    if (_isTablet) return tabletSize;
    return largeTabletSize;
  }

  // Padding and margin utilities with small phone support
  static EdgeInsets getAdaptivePadding({
    double smallPhoneHorizontal = 10,
    double smallPhoneVertical = 10,
    double horizontal = 8,
    double vertical = 8,
    double tabletHorizontal = 20,
    double tabletVertical = 20,
  }) {
    if (_isSmallPhone) {
      return EdgeInsets.symmetric(
        horizontal: smallPhoneHorizontal,
        vertical: smallPhoneVertical,
      );
    } else if (_isPhone) {
      return EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical);
    } else {
      return EdgeInsets.symmetric(
        horizontal: tabletHorizontal,
        vertical: tabletVertical,
      );
    }
  }

  static EdgeInsets getScreenPadding() {
    return EdgeInsets.symmetric(horizontal: _screenWidth * 0.04);
  }

  // Safe area utilities
  static double getSafeAreaHeight() {
    return _screenHeight - _statusBarHeight - _bottomBarHeight;
  }

  static EdgeInsets getSafeAreaPadding() {
    return EdgeInsets.only(top: _statusBarHeight, bottom: _bottomBarHeight);
  }

  // Platform-specific utilities
  static bool get isIOS => Platform.isIOS;
  static bool get isAndroid => Platform.isAndroid;
  static bool get isWeb => identical(0, 0.0); // Simple web detection

  // Breakpoint utilities with small phone support
  static bool get isSmallScreen => _screenWidth < 360;
  static bool get isMediumScreen => _screenWidth >= 360 && _screenWidth < 600;
  static bool get isLargeScreen => _screenWidth >= 900;

  // Aspect ratio utilities
  static double get aspectRatio => _screenWidth / _screenHeight;
  static bool get isWideScreen => aspectRatio > 1.5;
  static bool get isNarrowScreen => aspectRatio < 0.7;

  // Utility methods with small phone support
  static double getResponsiveValue({
    required double smallPhone,
    required double mobile,
    double? tablet,
    double? largeTablet,
  }) {
    if (_isLargeScreen && largeTablet != null) return largeTablet;
    if (_isTablet && tablet != null) return tablet;
    if (_isPhone) return mobile;
    return smallPhone;
  }

  static T getResponsiveWidget<T>({
    required T smallPhone,
    required T mobile,
    T? tablet,
    T? largeTablet,
  }) {
    if (_isLargeScreen && largeTablet != null) return largeTablet;
    if (_isTablet && tablet != null) return tablet;
    if (_isPhone) return mobile;
    return smallPhone;
  }

  // Grid utilities with small phone support
  static int getGridCrossAxisCount({
    int smallPhone = 2,
    int mobile = 2,
    int tablet = 3,
    int largeTablet = 4,
  }) {
    return getResponsiveValue(
      smallPhone: smallPhone.toDouble(),
      mobile: mobile.toDouble(),
      tablet: tablet.toDouble(),
      largeTablet: largeTablet.toDouble(),
    ).toInt();
  }

  // Grid utilities with small phone support
  static double getChildRatioValue({
    double smallPhone = 0.9,
    double mobile = 0.83,
    double tablet = 0.86,
    double largeTablet = 0.9,
  }) {
    return getResponsiveValue(
      smallPhone: smallPhone.toDouble(),
      mobile: mobile.toDouble(),
      tablet: tablet.toDouble(),
      largeTablet: largeTablet.toDouble(),
    ).toDouble();
  }

  static double getGridSpacing({
    double smallPhone = 8,
    double mobile = 12,
    double tablet = 16,
    double largeTablet = 20,
  }) {
    return getResponsiveValue(
      smallPhone: smallPhone,
      mobile: mobile,
      tablet: tablet,
      largeTablet: largeTablet,
    );
  }

  // Spacing utilities with small phone support
  static double getSpacing({
    double smallPhone = 4,
    double mobile = 8,
    double tablet = 12,
    double largeTablet = 16,
  }) {
    return getResponsiveValue(
      smallPhone: smallPhone,
      mobile: mobile,
      tablet: tablet,
      largeTablet: largeTablet,
    );
  }

  // Icon size utilities with small phone support
  static double getIconSize({
    double smallPhone = 20,
    double mobile = 20,
    double tablet = 24,
    double largeTablet = 28,
  }) {
    return getResponsiveValue(
      smallPhone: smallPhone,
      mobile: mobile,
      tablet: tablet,
      largeTablet: largeTablet,
    );
  }
}
