// import 'package:edmentoresolve/core/constants/color_constant.dart';
// import 'package:flutter/material.dart';

// class PrincipalBottomNavigation extends StatelessWidget {
//   final int currentIndex;
//   final ValueChanged<int> onTap;
//   const PrincipalBottomNavigation({
//     super.key,
//     required this.currentIndex,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final isDark = Theme.of(context).brightness == Brightness.dark;
//     return BottomNavigationBar(
//       currentIndex: currentIndex,
//       onTap: onTap,
//       type: BottomNavigationBarType.fixed,
//       selectedItemColor: isDark
//           ? ColorConstant.primaryColorDark
//           : ColorConstant.primaryColorLight,
//       unselectedItemColor: isDark
//           ? ColorConstant.textSecondaryColorDark
//           : ColorConstant.textSecondaryColorLight,
//       items: const [
//         BottomNavigationBarItem(
//           icon: Icon(Icons.dashboard),
//           label: 'Dashboard',
//         ),
//         BottomNavigationBarItem(icon: Icon(Icons.school), label: 'Students'),
//         BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Staff'),
//         BottomNavigationBarItem(icon: Icon(Icons.analytics), label: 'Reports'),
//         BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
//       ],
//     );
//   }
// }
