import 'package:edmentoresolve/core/widgets/index.dart';
import 'package:edmentoresolve/core/widgets/layout/tab_bar_widget.dart';
import 'package:edmentoresolve/features/user_roles/teacher/domain/entities/period_model.dart';
import 'package:edmentoresolve/features/user_roles/teacher/presentation/widgets/time_table_widget.dart';
import 'package:edmentoresolve/features/user_roles/teacher/presentation/widgets/timeline_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TeacherClassesPage extends StatelessWidget {
  const TeacherClassesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final List<Period> periods = [
      const Period(
        schedules: "Class 9 B",
        timeBlocks: "Period 1",
        isPast: true,
        isDisabled: true,
      ),
      const Period(
        schedules: "Class 8 A",
        timeBlocks: "Period 2",
        isPast: true,
        isDisabled: true,
      ),
      const Period(
        schedules: "Morning Break",
        timeBlocks: "Break",
        isPast: true,
        isDisabled: false,
      ),
      const Period(schedules: "Class 10 A", timeBlocks: "Period 3"),
      const Period(schedules: "Class 8 B", timeBlocks: "Period 4"),
      const Period(schedules: "Class 10 C", timeBlocks: "Period 5"),
      const Period(schedules: "Lunch Break", timeBlocks: "Break"),
      const Period(schedules: "Free", timeBlocks: "Period 6", isDisabled: true),
      const Period(schedules: "Class 10 B", timeBlocks: "Period 7"),
    ];

    final timetable = <int, List<String>>{
      5: [
        // Mon
        '10 A', '9 A', '8 A', 'Free', '10 B', '8 B', '9 B', '10 C',
      ],
      4: [
        // Tue
        '10 D', 'Free', '8 C', '10 E', '9 E', '8 D', '10 B', '8 E',
      ],
      3: [
        // Wed
        'Free', '10 A', '9 B', '8 B', '10 C', '9 C', '8 C', '10 D',
      ],
      2: [
        // Thu
        '10 E', '8 D', 'Free', '9 D', '10 B', '8 E', '9 E', 'Free',
      ],
      1: [
        // Fri
        '9 A', 'Free', '10 A', '8 B', '10 D', '9 C', 'Free', '10 E',
      ],
      0: [
        // Sat
        '8 D', '9 D', 'Free', '10 B', '8 E', '9 E', '10 C', 'Free',
      ],
    };

    print('screen height: ${ScreenUtil().screenHeight}');
    print('screen height: ${ScreenUtil().screenWidth}');

    return Scaffold(
      appBar: AppBarWidget(title: 'Time Table', centerTitle: false),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            AppTabBar.solid(tabs: ['Today', 'Weekly']),
            Expanded(
              child: TabBarView(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        final data = periods[index];
                        return AppTimelineTile(
                          schedules: data.schedules,
                          timeBlocks: data.timeBlocks,
                          isDisabled: data.isDisabled,
                          isPast: data.isPast,
                          isFirst: index == 0,
                          isLast: index == periods.length - 1,
                        );
                      },
                      itemCount: periods.length,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 15.h),
                      child: Center(
                        child: TimetableGrid(
                          data: timetable, // or your dynamic data
                          onCellTap: (day, period, value) {
                            // Handle tap (e.g., open slot detail / assign substitute)
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
