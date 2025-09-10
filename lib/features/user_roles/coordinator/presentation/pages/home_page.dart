import 'package:edmentoresolve/core/constants/color_constant.dart';
import 'package:edmentoresolve/core/widgets/content_widget.dart';
import 'package:edmentoresolve/core/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class CoordinatorHomePage extends StatelessWidget {
  const CoordinatorHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

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
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
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
                              color: colorScheme.onSurfaceVariant,
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
                    color: colorScheme.onSurfaceVariant,
                    context: context,
                  ),
                ],
              ),
            ),
            SpacerWidget.xlarge(),

            // Academic Statistics
            TextWidget.heading3('Academic Statistics', context: context),
            SpacerWidget.medium(),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              childAspectRatio: 1.0,
              mainAxisSpacing: 16.h,
              crossAxisSpacing: 16.w,
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
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              childAspectRatio: 1.0,
              mainAxisSpacing: 16.h,
              crossAxisSpacing: 16.w,
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
