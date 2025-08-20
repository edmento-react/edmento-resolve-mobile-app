import 'package:edmentoresolve/core/widgets/dashboard_scaffold.dart';
import 'package:edmentoresolve/features/profile/presentation/pages/profile_page.dart';
import 'package:edmentoresolve/features/teacher/presentation/pages/assignments_page.dart';
import 'package:edmentoresolve/features/teacher/presentation/pages/classes_page.dart';
import 'package:edmentoresolve/features/teacher/presentation/pages/grades_page.dart';
import 'package:edmentoresolve/features/teacher/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TeacherDashboardCubit extends Cubit<int> {
  TeacherDashboardCubit() : super(0);
  void setTab(int index) => emit(index);
}

class TeacherDashboardPage extends StatelessWidget {
  const TeacherDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TeacherDashboardCubit(),
      child: BlocBuilder<TeacherDashboardCubit, int>(
        builder: (context, currentIndex) {
          return DashboardScaffold(
            currentIndex: currentIndex,
            onTap: (index) =>
                context.read<TeacherDashboardCubit>().setTab(index),
            pages: const [
              TeacherHomePage(),
              TeacherClassesPage(),
              TeacherAssignmentsPage(),
              TeacherGradesPage(),
              ProfilePage(),
            ],
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.dashboard),
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
              BottomNavigationBarItem(icon: Icon(Icons.grade), label: 'Grades'),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
          );
        },
      ),
    );
  }
}
