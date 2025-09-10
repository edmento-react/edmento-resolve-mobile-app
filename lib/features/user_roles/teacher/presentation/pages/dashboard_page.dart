import 'package:edmentoresolve/core/widgets/layout/dashboard_scaffold.dart';
import 'package:edmentoresolve/features/shared/presentation/pages/communication_page.dart';
import 'package:edmentoresolve/features/shared/presentation/pages/task_page.dart';
import 'package:edmentoresolve/features/user_roles/teacher/presentation/pages/classroom_page.dart';
import 'package:edmentoresolve/features/user_roles/teacher/presentation/pages/home/home_page.dart';
import 'package:edmentoresolve/features/user_roles/teacher/presentation/pages/timetable_page.dart';
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
              ClassroomPage(),
              SharedTaskPage(),
              SharedCommunicationPage(),
            ],
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Dashboard',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.calendar_month),
                label: 'Calendar',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.menu_book_rounded),
                label: 'Assignments',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.task_alt_sharp),
                label: 'Grades',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.chat_bubble_outline_rounded),
                label: 'Profile',
              ),
            ],
          );
        },
      ),
    );
  }
}
