import 'package:edmentoresolve/core/widgets/dashboard_scaffold.dart';
import 'package:edmentoresolve/features/parent/presentation/pages/children_page.dart';
import 'package:edmentoresolve/features/parent/presentation/pages/grades_page.dart';
import 'package:edmentoresolve/features/parent/presentation/pages/home_page.dart';
import 'package:edmentoresolve/features/parent/presentation/pages/schedule_page.dart';
import 'package:edmentoresolve/features/profile/presentation/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../authentication/presentation/bloc/auth_bloc.dart';

class ParentDashboardCubit extends Cubit<int> {
  ParentDashboardCubit() : super(0);
  void setTab(int index) => emit(index);
}

class ParentDashboardPage extends StatelessWidget {
  const ParentDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ParentDashboardCubit(),
      child: BlocBuilder<ParentDashboardCubit, int>(
        builder: (context, currentIndex) {
          return BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              // if (state is! AuthSuccess) {
              //   return const LoadingIndicator();
              // }

              return DashboardScaffold(
                currentIndex: currentIndex,
                onTap: (index) =>
                    context.read<ParentDashboardCubit>().setTab(index),
                pages: const [
                  ParentHomePage(),
                  ParentChildrenPage(),
                  ParentGradesPage(),
                  ParentSchedulePage(),
                  ProfilePage(),
                ],
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.dashboard),
                    label: 'Dashboard',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.family_restroom),
                    label: 'Children',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.grade),
                    label: 'Grades',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.schedule),
                    label: 'Schedule',
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
