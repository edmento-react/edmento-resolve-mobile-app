import 'package:edmentoresolve/core/constants/color_constant.dart';
import 'package:edmentoresolve/core/utils/screen_util.dart';
import 'package:edmentoresolve/core/widgets/content_widget.dart';
import 'package:edmentoresolve/core/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CoordinatorHomePage extends StatelessWidget {
  const CoordinatorHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBarWidget(
        title: 'Coordinator Dashboard',
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
            // Welcome Section
            CardWidget(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  ColorConstant.green.withOpacity(0.1),
                  ColorConstant.blue.withOpacity(0.1),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconWidget.medium(Icons.supervisor_account),
                      SpacerWidget.widthMedium(),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextWidget.heading3(
                              'Welcome, Coordinator!',
                              context: context,
                            ),
                            SpacerWidget.tiny(),
                            TextWidget.body(
                              'Academic coordination and management',
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

            // Academic Statistics
            TextWidget.heading3('Academic Statistics', context: context),
            SpacerWidget.medium(),
            GridWidget.responsive(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: ScreenUtil.getGridCrossAxisCount(),
              childAspectRatio: ScreenUtil.getChildRatioValue(),
              children: [
                cardContent(
                  context: context,
                  icon: Icons.class_,
                  title: 'Active Classes',
                  value: '32',
                  color: ColorConstant.blue,
                  subtitle: 'Running classes',
                ),
                cardContent(
                  context: context,
                  icon: Icons.assignment,
                  title: 'Assignments',
                  value: '156',
                  color: ColorConstant.green,
                  subtitle: 'This month',
                ),
                cardContent(
                  context: context,
                  icon: Icons.people,
                  title: 'Students',
                  value: '850',
                  color: ColorConstant.orange,
                  subtitle: 'Enrolled students',
                ),
                cardContent(
                  context: context,
                  icon: Icons.trending_up,
                  title: 'Performance',
                  value: '87%',
                  color: ColorConstant.purple,
                  subtitle: 'Average grade',
                ),
              ],
            ),
            SpacerWidget.xlarge(),

            // Quick Actions
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
                  icon: Icons.add_circle_outline,
                  title: 'Create Class',
                  subtitle: 'Add new class',
                  color: ColorConstant.blue,
                  onTap: () {
                    // TODO: Navigate to create class
                  },
                ),
                cardContent(
                  context: context,
                  icon: Icons.assignment_add,
                  title: 'New Assignment',
                  subtitle: 'Create assignment',
                  color: ColorConstant.green,
                  onTap: () {
                    // TODO: Navigate to create assignment
                  },
                ),
                cardContent(
                  context: context,
                  icon: Icons.schedule,
                  title: 'Schedule',
                  subtitle: 'Manage schedules',
                  color: ColorConstant.orange,
                  onTap: () {
                    // TODO: Navigate to schedule
                  },
                ),
                cardContent(
                  context: context,
                  icon: Icons.analytics,
                  title: 'Analytics',
                  subtitle: 'View reports',
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
