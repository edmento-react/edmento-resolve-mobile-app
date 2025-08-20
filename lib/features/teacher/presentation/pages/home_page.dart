import 'package:edmentoresolve/core/constants/color_constant.dart';
import 'package:edmentoresolve/core/utils/screen_util.dart';
import 'package:edmentoresolve/core/widgets/content_widget.dart';
import 'package:edmentoresolve/core/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TeacherHomePage extends StatelessWidget {
  const TeacherHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBarWidget(
        title: 'Teacher Dashboard',
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // TODO: Navigate to notifications
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: ScreenUtil.getAdaptivePadding(
          horizontal: 24,
          vertical: 24,
          tabletHorizontal: 48,
          tabletVertical: 48,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Welcome Section
            CardWidget(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  ColorConstant.orange.withOpacity(0.1),
                  ColorConstant.blue.withOpacity(0.1),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconWidget.medium(Icons.school),
                      SpacerWidget.widthMedium(),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextWidget.heading3(
                              'Welcome, Teacher!',
                              context: context,
                            ),
                            SpacerWidget.tiny(),
                            TextWidget.body(
                              'Teaching and student management',
                              color: isDark
                                  ? ColorConstant.textSecondaryColorDark
                                  : ColorConstant.textSecondaryColorLight,
                              context: context,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SpacerWidget.medium(),
                  TextWidget.caption(
                    'Last updated: ${DateFormat('MMM dd, yyyy HH:mm').format(DateTime.now())}',
                    color: isDark
                        ? ColorConstant.textCaptionColorDark
                        : ColorConstant.textCaptionColorLight,
                    context: context,
                  ),
                ],
              ),
            ),
            SpacerWidget.xlarge(),

            /// Teaching Statistics
            TextWidget.heading3('Teaching Statistics', context: context),
            SpacerWidget.medium(),
            GridWidget.responsive(
              crossAxisCount: ScreenUtil.getGridCrossAxisCount(),
              childAspectRatio: ScreenUtil.getChildRatioValue(),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                cardContent(
                  context: context,
                  icon: Icons.class_,
                  title: 'My Classes',
                  value: '6',
                  color: ColorConstant.blue,
                  subtitle: 'Active classes',
                ),
                cardContent(
                  context: context,
                  icon: Icons.people,
                  title: 'Students',
                  value: '180',
                  color: ColorConstant.green,
                  subtitle: 'Total students',
                ),
                cardContent(
                  context: context,
                  icon: Icons.assignment,
                  title: 'Assignments',
                  value: '24',
                  color: ColorConstant.orange,
                  subtitle: 'This month',
                ),
                cardContent(
                  context: context,
                  icon: Icons.trending_up,
                  title: 'Average Grade',
                  value: '85%',
                  color: ColorConstant.purple,
                  subtitle: 'Class average',
                ),
              ],
            ),
            SpacerWidget.xlarge(),

            /// Quick Actions
            TextWidget.heading3('Quick Actions', context: context),
            SpacerWidget.medium(),
            GridWidget.responsive(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: ScreenUtil.getGridCrossAxisCount(),
              childAspectRatio: ScreenUtil.getChildRatioValue(),
              children: [
                cardContent(
                  context: context,
                  icon: Icons.assignment_add,
                  title: 'New Assignment',
                  subtitle: 'Create assignment',
                  color: ColorConstant.blue,
                  onTap: () {
                    // TODO: Navigate to create assignment
                  },
                ),
                cardContent(
                  context: context,
                  icon: Icons.grade,
                  title: 'Grade Papers',
                  subtitle: 'Review submissions',
                  color: ColorConstant.green,
                  onTap: () {
                    // TODO: Navigate to grade papers
                  },
                ),
                cardContent(
                  context: context,
                  icon: Icons.schedule,
                  title: 'Schedule',
                  subtitle: 'View timetable',
                  color: ColorConstant.orange,
                  onTap: () {
                    // TODO: Navigate to schedule
                  },
                ),
                cardContent(
                  context: context,
                  icon: Icons.analytics,
                  title: 'Analytics',
                  subtitle: 'Student progress',
                  color: ColorConstant.purple,
                  onTap: () {
                    // TODO: Navigate to analytics
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
