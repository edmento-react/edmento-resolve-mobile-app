import 'package:edmentoresolve/core/constants/color_constant.dart';
import 'package:edmentoresolve/core/constants/padding_constant.dart';
import 'package:edmentoresolve/core/widgets/content_widget.dart';
import 'package:edmentoresolve/core/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PrincipalHomePage extends StatelessWidget {
  const PrincipalHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBarWidget(
        title: 'Principal Dashboard',
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
        padding: PaddingConstant.screenPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Welcome Section
            CardWidget(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  ColorConstant.blue.withOpacity(0.1),
                  ColorConstant.purple.withOpacity(0.1),
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
                              'Welcome, Principal!',
                              context: context,
                            ),
                            SpacerWidget.tiny(),
                            TextWidget.body(
                              'School overview and management',
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

            /// School Statistics
            TextWidget.heading3('School Statistics', context: context),
            SpacerWidget.medium(),
            GridView.count(
              crossAxisCount: 2,
              childAspectRatio: 0.8,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: PaddingConstant.gridSpacing,
              crossAxisSpacing: PaddingConstant.gridSpacing,
              children: [
                cardContent(
                  context: context,
                  icon: Icons.people,
                  title: 'Total Students',
                  value: '1,250',
                  color: ColorConstant.blue,
                  subtitle: 'Enrolled students',
                ),
                cardContent(
                  context: context,
                  icon: Icons.person,
                  title: 'Total Staff',
                  value: '85',
                  color: ColorConstant.green,
                  subtitle: 'Teachers & staff',
                ),
                cardContent(
                  context: context,
                  icon: Icons.class_,
                  title: 'Classes',
                  value: '45',
                  color: ColorConstant.orange,
                  subtitle: 'Active classes',
                ),
                cardContent(
                  context: context,
                  icon: Icons.trending_up,
                  title: 'Attendance',
                  value: '94%',
                  color: ColorConstant.purple,
                  subtitle: 'Today\'s attendance',
                ),
              ],
            ),
            SpacerWidget.xlarge(),

            /// Quick Actions
            TextWidget.heading3('Quick Actions', context: context),
            SpacerWidget.medium(),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              childAspectRatio: 1.0,
              mainAxisSpacing: PaddingConstant.gridSpacing,
              crossAxisSpacing: PaddingConstant.gridSpacing,
              children: [
                cardContent(
                  context: context,
                  icon: Icons.add_circle_outline,
                  title: 'Add Staff',
                  subtitle: 'Register new staff',
                  color: ColorConstant.blue,
                  onTap: () {
                    // TODO: Navigate to add staff
                  },
                ),
                cardContent(
                  context: context,
                  icon: Icons.assessment,
                  title: 'School Report',
                  subtitle: 'Generate reports',
                  color: ColorConstant.green,
                  onTap: () {
                    // TODO: Navigate to reports
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
                  icon: Icons.settings,
                  title: 'Settings',
                  subtitle: 'School settings',
                  color: ColorConstant.purple,
                  onTap: () {
                    // TODO: Navigate to settings
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
