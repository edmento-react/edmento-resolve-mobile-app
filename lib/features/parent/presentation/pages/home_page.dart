import 'package:edmentoresolve/core/constants/color_constant.dart';
import 'package:edmentoresolve/core/utils/screen_util.dart';
import 'package:edmentoresolve/core/widgets/content_widget.dart';
import 'package:edmentoresolve/core/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ParentHomePage extends StatelessWidget {
  const ParentHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBarWidget(
        title: 'Parent Dashboard',
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
            // Welcome
            CardWidget(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  ColorConstant.purple.withOpacity(0.1),
                  ColorConstant.blue.withOpacity(0.1),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconWidget.medium(Icons.family_restroom),
                      SpacerWidget.widthMedium(),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextWidget.heading3(
                              'Welcome, Parent!',
                              context: context,
                            ),
                            SpacerWidget.tiny(),
                            TextWidget.body(
                              'Monitor your children\'s progress',
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

            // Children Overview
            TextWidget.heading3('Children Overview', context: context),
            SpacerWidget.medium(),
            GridWidget.responsive(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: ScreenUtil.getGridCrossAxisCount(),
              childAspectRatio: ScreenUtil.getChildRatioValue(),
              children: [
                cardContent(
                  context: context,
                  icon: Icons.family_restroom,
                  title: 'Children',
                  value: '2',
                  color: ColorConstant.blue,
                  subtitle: 'Enrolled students',
                ),
                cardContent(
                  context: context,
                  icon: Icons.grade,
                  title: 'Average Grade',
                  value: '88%',
                  color: ColorConstant.green,
                  subtitle: 'Overall average',
                ),
                cardContent(
                  context: context,
                  icon: Icons.assignment,
                  title: 'Assignments',
                  value: '12',
                  color: ColorConstant.orange,
                  subtitle: 'This month',
                ),
                cardContent(
                  context: context,
                  icon: Icons.trending_up,
                  title: 'Attendance',
                  value: '96%',
                  color: ColorConstant.purple,
                  subtitle: 'This month',
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
                  icon: Icons.message,
                  title: 'Contact Teacher',
                  subtitle: 'Send message',
                  color: ColorConstant.blue,
                  onTap: () {
                    // TODO: Navigate to contact teacher
                  },
                ),
                cardContent(
                  context: context,
                  icon: Icons.calendar_today,
                  title: 'Events',
                  subtitle: 'School events',
                  color: ColorConstant.green,
                  onTap: () {
                    // TODO: Navigate to events
                  },
                ),
                cardContent(
                  context: context,
                  icon: Icons.payment,
                  title: 'Payments',
                  subtitle: 'Fee management',
                  color: ColorConstant.orange,
                  onTap: () {
                    // TODO: Navigate to payments
                  },
                ),
                cardContent(
                  context: context,
                  icon: Icons.support_agent,
                  title: 'Support',
                  subtitle: 'Get help',
                  color: ColorConstant.purple,
                  onTap: () {
                    // TODO: Navigate to support
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
