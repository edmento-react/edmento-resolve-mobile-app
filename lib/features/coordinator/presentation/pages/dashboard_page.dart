import 'dart:io';

import 'package:edmentoresolve/core/widgets/dashboard_scaffold.dart';
import 'package:edmentoresolve/features/common/presentation/pages/profile_page.dart';
import 'package:edmentoresolve/features/coordinator/presentation/pages/assignments_page.dart';
import 'package:edmentoresolve/features/coordinator/presentation/pages/classes_page.dart';
import 'package:edmentoresolve/features/coordinator/presentation/pages/home_page.dart';
import 'package:edmentoresolve/features/coordinator/presentation/pages/reports_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../authentication/presentation/bloc/auth_bloc.dart';

class CoordinatorDashboardCubit extends Cubit<int> {
  CoordinatorDashboardCubit() : super(0);
  void setTab(int index) => emit(index);
}

class CoordinatorDashboardPage extends StatelessWidget {
  const CoordinatorDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CoordinatorDashboardCubit(),
      child: BlocBuilder<CoordinatorDashboardCubit, int>(
        builder: (context, currentIndex) {
          return BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              // if (state is! AuthSuccess) return const LoadingIndicator();

              return DashboardScaffold(
                currentIndex: currentIndex,
                onTap: (index) =>
                    context.read<CoordinatorDashboardCubit>().setTab(index),
                pages: const [
                  CoordinatorHomePage(),
                  CoordinatorClassesPage(),
                  CoordinatorAssignmentsPage(),
                  CoordinatorReportsPage(),
                  ProfilePage(),
                ],
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(
                      Platform.isIOS
                          ? CupertinoIcons.house_fill
                          : Icons.home_filled,
                    ),
                    label: 'Dashboard',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.class_),
                    label: 'Classes',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.assignment),
                    label: 'Assignments',
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
