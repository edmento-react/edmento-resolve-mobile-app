import 'package:edmentoresolve/core/widgets/dashboard_scaffold.dart';
import 'package:edmentoresolve/features/common/presentation/pages/profile_page.dart';
import 'package:edmentoresolve/features/student/presentation/bloc/poster_cubit.dart';
import 'package:edmentoresolve/features/student/presentation/pages/assignments_page.dart';
import 'package:edmentoresolve/features/student/presentation/pages/grades_page.dart';
import 'package:edmentoresolve/features/student/presentation/pages/home_page.dart';
import 'package:edmentoresolve/features/student/presentation/pages/timetable_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/student_dashboard_cubit.dart';

class StudentDashboardPage extends StatelessWidget {
  const StudentDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => StudentDashboardCubit()),
        BlocProvider(create: (_) => PosterOverlayCubit()),
      ],
      child: BlocBuilder<StudentDashboardCubit, int>(
        builder: (context, currentIndex) {
          return DashboardScaffold(
            currentIndex: currentIndex,
            onTap: (index) =>
                context.read<StudentDashboardCubit>().setTab(index),
            pages: const [
              HomePage(),
              TimetablePage(),
              StudentAssignmentsPage(),
              StudentGradesPage(),
              ProfilePage(),
            ],
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_filled),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.calendar_today_outlined),
                label: 'Time Table',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.assignment),
                label: 'Assignments',
              ),
              BottomNavigationBarItem(icon: Icon(Icons.grade), label: 'Grades'),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
            // Keep your previous behavior (labels hidden)
            showSelectedLabels: false,
            showUnselectedLabels: false,
          );
        },
      ),
    );
  }
}
