import 'package:edmentoresolve/core/constants/routes.dart';
import 'package:edmentoresolve/features/principal/presentation/pages/home_page.dart';
import 'package:edmentoresolve/features/principal/presentation/pages/reports_page.dart';
import 'package:edmentoresolve/features/principal/presentation/pages/staff_page.dart';
import 'package:edmentoresolve/features/principal/presentation/pages/students_page.dart';
import 'package:edmentoresolve/features/profile/presentation/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/widgets/dashboard_scaffold.dart';
import '../../../authentication/presentation/bloc/auth_bloc.dart';

class PrincipalDashboardCubit extends Cubit<int> {
  PrincipalDashboardCubit() : super(0);
  void setTab(int index) => emit(index);
}

class PrincipalDashboardPage extends StatelessWidget {
  const PrincipalDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PrincipalDashboardCubit(),
      child: BlocBuilder<PrincipalDashboardCubit, int>(
        builder: (context, currentIndex) {
          return BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state is AuthInitial) {
                context.go(AppRoutes.forgotPassword);
                return const SizedBox.shrink();
              }
              // if (state is! AuthSuccess) {
              //   return const LoadingIndicator();
              // }

              return DashboardScaffold(
                currentIndex: currentIndex,
                onTap: (index) =>
                    context.read<PrincipalDashboardCubit>().setTab(index),
                pages: const [
                  PrincipalHomePage(),
                  PrincipalStudentsPage(),
                  PrincipalStaffPage(),
                  PrincipalReportsPage(),
                  ProfilePage(),
                ],
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.dashboard),
                    label: 'Dashboard',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.school),
                    label: 'Students',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.people),
                    label: 'Staff',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.analytics),
                    label: 'Reports',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    label: 'Profile',
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
