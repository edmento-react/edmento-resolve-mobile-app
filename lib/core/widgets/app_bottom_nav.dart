import 'package:flutter/material.dart';

import '../../core/constants/color_constant.dart';

/// Reusable bottom navigation bar with sensible defaults for light/dark themes.
/// You can turn labels on/off and change type as needed.
class AppBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<BottomNavigationBarItem> items;
  final bool showSelectedLabels;
  final bool showUnselectedLabels;
  final BottomNavigationBarType type;
  final Color? selectedItemColor;
  final Color? unselectedItemColor;

  const AppBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.items,
    this.showSelectedLabels = false,
    this.showUnselectedLabels = false,
    this.type = BottomNavigationBarType.fixed,
    this.selectedItemColor,
    this.unselectedItemColor,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final selectedColor =
        selectedItemColor ??
        (isDark
            ? ColorConstant.primaryColorDark
            : ColorConstant.primaryColorLight);
    final unselectedColor =
        unselectedItemColor ??
        (isDark
            ? ColorConstant.textSecondaryColorDark
            : ColorConstant.textSecondaryColorLight);

    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      type: type,
      showSelectedLabels: showSelectedLabels,
      showUnselectedLabels: showUnselectedLabels,
      selectedItemColor: selectedColor,
      unselectedItemColor: unselectedColor,
      items: items,
    );
  }
}
