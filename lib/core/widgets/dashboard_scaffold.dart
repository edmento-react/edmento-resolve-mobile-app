import 'package:flutter/material.dart';

import 'app_bottom_nav.dart';

/// Preserves each tab with IndexedStack and hosts our custom nav bar.
class DashboardScaffold extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<Widget> pages;
  final List<BottomNavigationBarItem> items;

  // Optional visual toggles (kept for API parity)
  final bool showSelectedLabels;
  final bool showUnselectedLabels;
  final BottomNavigationBarType navType;
  final Color? selectedItemColor;
  final Color? unselectedItemColor;

  final PreferredSizeWidget? appBar;
  // final Widget? floatingActionButton;

  const DashboardScaffold({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.pages,
    required this.items,
    this.showSelectedLabels = false,
    this.showUnselectedLabels = false,
    this.navType = BottomNavigationBarType.fixed,
    this.selectedItemColor,
    this.unselectedItemColor,
    this.appBar,
    // this.floatingActionButton,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: IndexedStack(index: currentIndex, children: pages),
      bottomNavigationBar: AppBottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onTap,
        items: items,
        showSelectedLabels: showSelectedLabels,
        showUnselectedLabels: showUnselectedLabels,
        type: navType,
        selectedItemColor: selectedItemColor,
        unselectedItemColor: unselectedItemColor,
      ),
      // floatingActionButton: floatingActionButton,
      // floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
