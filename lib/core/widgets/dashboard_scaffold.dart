import 'package:flutter/material.dart';

import 'app_bottom_nav.dart';

/// A generic scaffold for all dashboards:
/// - IndexedStack for preserving state of each tab
/// - Common bottom navigation
/// - Optional AppBar and floatingActionButton if a role needs it later
class DashboardScaffold extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<Widget> pages;
  final List<BottomNavigationBarItem> items;

  // Optional visual toggles
  final bool showSelectedLabels;
  final bool showUnselectedLabels;
  final BottomNavigationBarType navType;

  // Optional top bar / FAB if you need (kept flexible)
  final PreferredSizeWidget? appBar;
  final Widget? floatingActionButton;
  final Color? selectedItemColor;
  final Color? unselectedItemColor;

  const DashboardScaffold({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.pages,
    required this.items,
    this.showSelectedLabels = false,
    this.showUnselectedLabels = false,
    this.navType = BottomNavigationBarType.fixed,
    this.appBar,
    this.floatingActionButton,
    this.selectedItemColor,
    this.unselectedItemColor,
  }) : assert(
         pages.length == items.length,
         'pages and items must have same length',
       );

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
      floatingActionButton: floatingActionButton,
    );
  }
}
