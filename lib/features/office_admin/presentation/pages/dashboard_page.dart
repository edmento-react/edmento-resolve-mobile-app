// Reuse your shared scaffold (ensure these exist as per earlier refactor)
import 'package:edmentoresolve/core/widgets/dashboard_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'leave_request_page.dart';
import 'profile_page.dart';

class OfficeAdminDashboardCubit extends Cubit<int> {
  OfficeAdminDashboardCubit() : super(0);
  void setTab(int index) => emit(index);
}

class OfficeAdminDashboardPage extends StatelessWidget {
  const OfficeAdminDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OfficeAdminDashboardCubit(),
      child: BlocBuilder<OfficeAdminDashboardCubit, int>(
        builder: (context, currentIndex) {
          return DashboardScaffold(
            currentIndex: currentIndex,
            onTap: (index) =>
                context.read<OfficeAdminDashboardCubit>().setTab(index),
            pages: const [LeaveRequestPage(), OfficeAdminProfilePage()],
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.request_page),
                label: 'Leave',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
            // If you want labels visible for Office Admin, keep these true:
            showSelectedLabels: true,
            showUnselectedLabels: true,
          );
        },
      ),
    );
  }
}
