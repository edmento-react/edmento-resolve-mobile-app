import 'package:flutter/material.dart';

class ColorConstant {
  // === BRAND / PRIMARY ===
  // Keep your existing brand hues (names cleaned up)
  static const Color primaryLight = Color(0xFF4B74DD); // Brand blue
  static const Color primaryDark = Color(0xFF5C8DFF); // Emerald accent in dark

  static const Gradient appGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xff9db2dc), Color(0xff0e2d6c)],
  );
  static const Gradient appGradient2 = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF22C55E), Color(0xFF3B82F6)],
  );

  static const Gradient radialGradient = RadialGradient(
    colors: [Color(0xff9db2dc), Color(0xff0e2d6c)],
  );

  static const Color secondaryLight = Color(0xFF9C27B0); // Purple
  static const Color secondaryDark = Color(0xFFBA68C8);

  // === FEEDBACK ===
  static const Color errorLight = Color(0xFFF44336);
  static const Color errorDark = Color(0xFFEF5350);

  static const Color successLight = Color(0xFF10B981); // teal/emerald
  static const Color successDark = Color(0xFF34D399);

  static const Color warningLight = Color(0xFFF59E0B);
  static const Color warningDark = Color(0xFFFBBF24);

  static const Color infoLight = Color(0xFF3B82F6);
  static const Color infoDark = Color(0xFF60A5FA);

  // === BACKGROUND / SURFACE (Neutral, non-role) ===
  // Scaffold = page background; Surface = containers behind cards (if any)
  static const Color scaffoldLight = Color(0xFFF9FAFB); // slate-50
  static const Color scaffoldDark = Color(0xFF0F172A); // slate-900

  static const Color surfaceLight = Color(0xFFF5F5F5); // gray-100
  static const Color surfaceDark = Color(0xFF111827); // gray-900

  // === CARD (Primary recommendation) ===
  static const Color cardLight = Color(0xFFFFFFFF); // white
  static const Color cardDark = Color(0xFF1E293B); // slate-800
  static const Color cardBorderLight = Color(0xFFE5E7EB); // slate-200
  static const Color cardBorderDark = Color(0xFF334155); // slate-700
  static const Color cardAltLight = Color(0xFFFAFAFA); // gray-50
  static const Color cardAltDark = Color(0xFF0F172A); // slate-900

  // Optional overlays (use for pressed states / elevations)
  static const Color overlayLight = Color(0x0F000000); // 6% black
  static const Color overlayDark = Color(0x29FFFFFF); // 16% white

  // === TEXT ===
  static const Color textPrimaryLight = Color(0xFF111827); // gray-900
  static const Color textPrimaryDark = Color(0xFFE5E7EB); // gray-200
  static const Color textSecondaryLight = Color(0xFF6B7280); // gray-500
  static const Color textSecondaryDark = Color(0xFF9CA3AF); // gray-400
  static const Color textCaptionLight = Color(0xFF9CA3AF); // gray-400
  static const Color textCaptionDark = Color(0xFF6B7280); // gray-500
  static const Color textLabelLight = Color(0xFF4B5563); // gray-600
  static const Color textLabelDark = Color(0xFF9CA3AF); // gray-400

  // === DIVIDER ===
  static const Color dividerLight = Color(
    0xFFE5E7EB,
  ); // slate-200 //use for card border also
  static const Color dividerDark = Color(
    0xFF334155,
  ); // slate-700 //use for card border also

  // === GREYS (utility) ===
  static const Color grey50 = Color(0xFFF9FAFB);
  static const Color grey100 = Color(0xFFF5F5F5);
  static const Color grey200 = Color(0xFFEEEEEE);
  static const Color grey300 = Color(0xFFE0E0E0);
  static const Color grey400 = Color(0xFFBDBDBD);
  static const Color grey500 = Color(0xFF9E9E9E);
  static const Color grey600 = Color(0xFF757575);
  static const Color grey700 = Color(0xFF616161);
  static const Color grey800 = Color(0xFF424242);
  static const Color grey900 = Color(0xFF212121);

  // === COMMONS ===
  static const Color red = Color(0xFFF44336);
  static const Color redLight = Color(0xFFFFCDD2);
  static const Color redDark = Color(0xFFD32F2F);

  static const Color blue = Color(0xFF2196F3);
  static const Color blueLight = Color(0xFFBBDEFB);
  static const Color blueDark = Color(0xFF1976D2);

  static const Color purple = Color(0xFF9C27B0);
  static const Color purpleLight = Color(0xFFE1BEE7);
  static const Color purpleDark = Color(0xFF7B1FA2);

  static const Color green = Color(0xFF4CAF50);
  static const Color greenLight = Color(0xFFC8E6C9);
  static const Color greenDark = Color(0xFF388E3C);

  static const Color orange = Color(0xFFFF9800);
  static const Color orangeLight = Color(0xFFFFE0B2);
  static const Color orangeDark = Color(0xFFF57C00);

  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);

  // === BLACK VARIANTS ===
  static const Color black87 = Color(0xDD000000);
  static const Color black54 = Color(0x8A000000);
  static const Color black45 = Color(0x73000000);
  static const Color black38 = Color(0x61000000);
  static const Color black26 = Color(0x42000000);
  static const Color black12 = Color(0x1F000000);

  static const Color transparent = Color(0x00000000);
}
