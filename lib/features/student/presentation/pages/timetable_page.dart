import 'package:edmentoresolve/core/constants/routes.dart';
import 'package:edmentoresolve/core/utils/screen_util.dart';
import 'package:edmentoresolve/core/widgets/app_bar_widget.dart';
import 'package:edmentoresolve/core/widgets/spacer_widget.dart';
import 'package:edmentoresolve/core/widgets/text_widget.dart';
import 'package:edmentoresolve/features/student/presentation/widgets/schedule_list.dart';
import 'package:edmentoresolve/features/student/presentation/widgets/student_tabs.dart';
import 'package:edmentoresolve/features/student/presentation/widgets/view_all_schedule.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../bloc/student_cubit.dart';

class TimetablePage extends StatelessWidget {
  const TimetablePage({super.key});

  final List<String> students = const ['Alex', 'Jithin', 'Ram'];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => StudentCubit(),
      child: _TimetablePageView(students: students),
    );
  }
}

class _TimetablePageView extends StatefulWidget {
  final List<String> students;
  const _TimetablePageView({required this.students});

  @override
  State<_TimetablePageView> createState() => _TimetablePageViewState();
}

class _TimetablePageViewState extends State<_TimetablePageView> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    final selectedIndex = context.read<StudentCubit>().state;
    _pageController = PageController(initialPage: selectedIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: 'Time Table'),
      body: SafeArea(
        child: Padding(
          padding: ScreenUtil.getAdaptivePadding(
            smallPhoneVertical: 0,
            horizontal: 24,
            vertical: 0,
            tabletHorizontal: 48,
            tabletVertical: 0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SpacerWidget.medium(),
              StudentTabs(students: widget.students, onTap: (value) {}),
              SpacerWidget.medium(),
              Expanded(
                child: BlocBuilder<StudentCubit, int>(
                  builder: (context, selectedIndex) {
                    return PageView.builder(
                      controller: _pageController,
                      itemCount: widget.students.length,
                      onPageChanged: (index) {
                        context.read<StudentCubit>().selectStudent(index);
                      },
                      itemBuilder: (context, index) {
                        return SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextWidget.heading2(
                                context: context,
                                'Home work',
                              ),
                              SpacerWidget.medium(),
                              ViewAllScheduleButton(onPressed: () {}),
                              SpacerWidget.xxlarge(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextWidget.heading2(
                                    context: context,
                                    'Time Table',
                                  ),

                                  GestureDetector(
                                    onTap: () {
                                      context.push(AppRoutes.schedule);
                                    },
                                    child: TextWidget.body(
                                      context: context,
                                      'View all >',
                                    ),
                                  ),
                                ],
                              ),

                              SpacerWidget.xlarge(),
                              ScheduleList(),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
