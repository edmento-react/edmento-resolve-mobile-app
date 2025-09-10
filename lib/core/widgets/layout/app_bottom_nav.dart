import 'package:edmentoresolve/core/constants/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Custom bottom nav that renders a floating white bar with a top indicator
/// and evenly spaced icons. Plug-compatible with your DashboardScaffold API.
class AppBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<BottomNavigationBarItem> items;

  // These are accepted for API parity but unused (we style manually)
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
    final theme = Theme.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final selected =
        selectedItemColor ?? theme.colorScheme.onSurface; // near-black
    final unselected =
        unselectedItemColor ?? selected.withOpacity(0.4); // grey-400

    return SizedBox(
      height: 68.h,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final count = items.length;
          final barWidth = constraints.maxWidth;
          final itemWidth = barWidth / count;
          final indicatorWidth = itemWidth;
          final indicatorLeft =
              (itemWidth * currentIndex) + (itemWidth - indicatorWidth) / 2;

          return Container(
            decoration: BoxDecoration(
              color: theme.scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  blurRadius: 10,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Stack(
              children: [
                // Top indicator (short black bar that slides)
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 220),
                  curve: Curves.easeOut,
                  top: 0,
                  left: indicatorLeft,
                  width: indicatorWidth,
                  height: 2.h,
                  child: Container(
                    decoration: BoxDecoration(
                      color: selected,
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                  ),
                ),

                // Icons row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(count, (i) {
                    final isActive = i == currentIndex;

                    final icon = isActive
                        ? (items[i].activeIcon ?? items[i].icon)
                        : items[i].icon;

                    return _NavItem(
                      width: itemWidth,
                      icon: IconTheme(
                        data: IconThemeData(
                          color: isActive ? selected : unselected,
                          size: 26.w,
                        ),
                        child: icon,
                      ),
                      onPressed: () {
                        if (i == currentIndex) {
                          HapticFeedback.selectionClick();
                        } else {
                          HapticFeedback.lightImpact();
                          onTap(i);
                        }
                      },
                    );
                  }),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final double width;
  final Widget icon;
  final VoidCallback onPressed;

  const _NavItem({
    required this.width,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: double.infinity,
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          splashColor: ColorConstant.transparent,
          onTap: onPressed,

          child: Center(child: icon),
        ),
      ),
    );
  }
}
