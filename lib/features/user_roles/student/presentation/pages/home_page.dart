import 'dart:async';

import 'package:edmentoresolve/core/constants/color_constant.dart';
import 'package:edmentoresolve/core/constants/padding_constant.dart';
import 'package:edmentoresolve/core/widgets/cards/card_widget.dart';
import 'package:edmentoresolve/core/widgets/media/icon_widget.dart';
import 'package:edmentoresolve/core/widgets/navigation/app_bar_widget.dart';
import 'package:edmentoresolve/core/widgets/spacer_widget.dart';
import 'package:edmentoresolve/core/widgets/text_widget.dart';
import 'package:edmentoresolve/features/user_roles/student/presentation/bloc/poster_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late final AnimationController _logoController;
  late final Animation<double> _logoAnimation;

  bool _isDialogOpen = false;

  @override
  void initState() {
    super.initState();
    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _logoAnimation = CurvedAnimation(
      parent: _logoController,
      curve: Curves.easeInOut,
    );

    // Simple initialization
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        final isVisible = context.read<PosterOverlayCubit>().state;
        if (isVisible && !_isDialogOpen) {
          Future.delayed(const Duration(milliseconds: 250), () {
            if (mounted) {
              _openPosterDialog(context);
            }
          });
        }
      }
    });
  }

  @override
  void dispose() {
    _logoController.dispose();
    super.dispose();
  }

  void _openPosterDialog(BuildContext context) async {
    if (_isDialogOpen) return;
    _isDialogOpen = true;
    _logoController
      ..reset()
      ..forward();

    await showGeneralDialog(
      context: context,
      barrierDismissible: false,

      barrierLabel: 'Poster',
      // Simple darker background
      barrierColor: ColorConstant.black.withOpacity(0.6),
      transitionDuration: const Duration(milliseconds: 250),
      pageBuilder: (_, __, ___) {
        return WillPopScope(
          onWillPop: () async {
            print('will pop called');

            // If dialog is open, close it instead of popping the page
            context.read<PosterOverlayCubit>().hide();

            return true; // Allow normal back navigation
          },
          child: SafeArea(
            child: Center(
              child: ScaleTransition(
                scale: Tween<double>(begin: 0.95, end: 1.0).animate(
                  CurvedAnimation(
                    parent: _logoController,
                    curve: Curves.easeOutCubic,
                  ),
                ),
                child: _AnimatedPoster(
                  animation: _logoAnimation,
                  onClose: () {
                    // Close via go_router and update cubit
                    if (context.canPop()) {
                      context.pop();
                    }
                    context.read<PosterOverlayCubit>().hide();
                  },
                ),
              ),
            ),
          ),
        );
      },
    );

    _isDialogOpen = false;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PosterOverlayCubit, bool>(
      listenWhen: (prev, curr) => prev != curr,
      listener: (context, isVisible) async {
        if (isVisible) {
          _openPosterDialog(context);
        } else if (_isDialogOpen && context.canPop()) {
          context.pop();
        }
      },
      child: Scaffold(
        appBar: AppBarWidget(
          title: 'Student Dashboard',
          actions: [
            IconButton(
              icon: const Icon(Icons.visibility),
              tooltip: 'Show poster',
              // You can trigger this from anywhere (notification, API event, etc.)
              onPressed: () => context.read<PosterOverlayCubit>().show(),
            ),
            IconButton(
              icon: const Icon(Icons.notifications),
              onPressed: () {
                context.read<PosterOverlayCubit>().hide();
                // Navigate to notifications
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: PaddingConstant.screenPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildWelcomeCard(context),
              SpacerWidget.xlarge(),
              _buildSectionHeader(context, 'Academic Statistics'),
              SpacerWidget.medium(),
              _buildAcademicStatsGrid(context),
              SpacerWidget.xlarge(),
              _buildSectionHeader(context, 'Recent Activity'),
              SpacerWidget.medium(),
              _buildRecentActivityList(context),
              SpacerWidget.xlarge(),
              _buildSectionHeader(context, 'Quick Actions'),
              SpacerWidget.medium(),
              _buildQuickActionsGrid(context),
              SpacerWidget.xlarge(),
              _buildSectionHeader(context, 'Upcoming Deadlines'),
              SpacerWidget.medium(),
              _buildUpcomingDeadlinesList(context),
            ],
          ),
        ),
      ),
    );
  }

  // ---------- your existing builders (unchanged) ----------
  Widget _buildSectionHeader(BuildContext context, String title) =>
      TextWidget.heading3(title, context: context);

  // ... keep _buildWelcomeCard, _buildAcademicStatsGrid, _buildRecentActivityList,
  // _buildQuickActionsGrid, _buildUpcomingDeadlinesList exactly as you had them ...

  Widget _buildWelcomeCard(BuildContext context) {
    return CardWidget(
      gradient: LinearGradient(
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
                    TextWidget.heading3('Welcome back!', context: context),
                    SpacerWidget.tiny(),
                    TextWidget.body(
                      "Here's what's happening today",
                      color: ColorConstant.textSecondaryLight,
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
            color: ColorConstant.textCaptionLight,
            context: context,
          ),
        ],
      ),
    );
  }

  Widget _buildAcademicStatsGrid(BuildContext context) {
    return GridView.count(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: 2,
      childAspectRatio: 1.0,
      mainAxisSpacing: PaddingConstant.gridSpacing,
      crossAxisSpacing: PaddingConstant.gridSpacing,
      children: [
        cardContent(
          context: context,
          icon: Icons.book_outlined,
          title: 'Courses',
          value: '6',
          color: ColorConstant.blue,
          subtitle: 'Active courses',
        ),
        cardContent(
          context: context,
          icon: Icons.assignment_outlined,
          title: 'Assignments',
          value: '8',
          color: ColorConstant.green,
          subtitle: 'Pending tasks',
        ),
        cardContent(
          context: context,
          icon: Icons.grade_outlined,
          title: 'Average',
          value: '92%',
          color: ColorConstant.orange,
          subtitle: 'Overall grade',
        ),
        cardContent(
          context: context,
          icon: Icons.schedule_outlined,
          title: 'Study Time',
          value: '24h',
          color: ColorConstant.purple,
          subtitle: 'This week',
        ),
      ],
    );
  }

  Widget _buildRecentActivityList(BuildContext context) {
    return Column(
      children: [
        tileContent(
          context: context,
          icon: Icons.assignment_turned_in,
          title: 'Assignment Submitted',
          subtitle: 'Mathematics Quiz #3',
          time: '2 hours ago',
          color: ColorConstant.green,
        ),
        tileContent(
          context: context,
          icon: Icons.video_library,
          title: 'Video Watched',
          subtitle: 'Introduction to Calculus',
          time: '4 hours ago',
          color: ColorConstant.blue,
        ),
        tileContent(
          context: context,
          icon: Icons.quiz,
          title: 'Quiz Completed',
          subtitle: 'Physics Chapter 5',
          time: '1 day ago',
          color: ColorConstant.orange,
        ),
        tileContent(
          context: context,
          icon: Icons.forum,
          title: 'Discussion Posted',
          subtitle: 'Chemistry Lab Results',
          time: '2 days ago',
          color: ColorConstant.purple,
        ),
      ],
    );
  }

  Widget _buildQuickActionsGrid(BuildContext context) {
    return GridView.count(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: 2,
      childAspectRatio: 1.0,
      mainAxisSpacing: PaddingConstant.gridSpacing,
      crossAxisSpacing: PaddingConstant.gridSpacing,
      children: [
        cardContent(
          context: context,
          icon: Icons.add_circle_outline,
          title: 'New Course',
          subtitle: 'Enroll in a course',
          color: ColorConstant.blue,
        ),
        cardContent(
          context: context,
          icon: Icons.calendar_today_outlined,
          title: 'Schedule',
          subtitle: 'View calendar',
          color: ColorConstant.green,
        ),
        cardContent(
          context: context,
          icon: Icons.analytics_outlined,
          title: 'Progress',
          subtitle: 'View analytics',
          color: ColorConstant.orange,
        ),
        cardContent(
          context: context,
          icon: Icons.support_agent_outlined,
          title: 'Support',
          subtitle: 'Get help',
          color: ColorConstant.purple,
        ),
      ],
    );
  }

  Widget _buildUpcomingDeadlinesList(BuildContext context) {
    return Column(
      children: [
        tileContent(
          context: context,
          title: 'Mathematics Assignment',
          subtitle: 'Calculus Integration',
          deadline: 'Tomorrow',
          priority: 'High',
          color: ColorConstant.red,
        ),
        tileContent(
          context: context,
          title: 'Physics Lab Report',
          subtitle: 'Mechanics Experiment',
          deadline: '3 days',
          priority: 'Medium',
          color: ColorConstant.orange,
        ),
        tileContent(
          context: context,
          title: 'Chemistry Quiz',
          subtitle: 'Organic Chemistry',
          deadline: '1 week',
          priority: 'Low',
          color: ColorConstant.green,
        ),
      ],
    );
  }

  // Helper function for card content (stats and actions)
  Widget cardContent({
    required BuildContext context,
    required IconData icon,
    required String title,
    String? value,
    String? subtitle,
    required Color color,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 2,
        child: Padding(
          padding: PaddingConstant.cardPadding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: color, size: 32.w),
              SpacerWidget.small(),
              if (value != null) TextWidget.heading3(value, context: context),
              TextWidget.body(
                title,
                context: context,
                textAlign: TextAlign.center,
              ),
              if (subtitle != null)
                TextWidget.caption(
                  subtitle,
                  context: context,
                  textAlign: TextAlign.center,
                ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper function for tile content (activity and deadlines)
  Widget tileContent({
    required BuildContext context,
    IconData? icon,
    required String title,
    required String subtitle,
    String? time,
    String? deadline,
    String? priority,
    required Color color,
  }) {
    return Card(
      margin: PaddingConstant.itemMargin,
      child: ListTile(
        leading: icon != null ? Icon(icon, color: color) : null,
        title: TextWidget.body(title, context: context),
        subtitle: TextWidget.caption(subtitle, context: context),
        trailing: time != null
            ? TextWidget.caption(time, context: context)
            : deadline != null
            ? Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextWidget.caption(deadline, context: context),
                  if (priority != null)
                    TextWidget.caption(
                      priority,
                      context: context,
                      color: color,
                    ),
                ],
              )
            : null,
      ),
    );
  }
}

class _AnimatedPoster extends StatelessWidget {
  const _AnimatedPoster({required this.animation, required this.onClose});

  final Animation<double> animation;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    final height = ScreenUtil().screenHeight * 0.75;

    return FadeTransition(
      opacity: animation,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Material(
            elevation: 12,
            color: Colors.transparent,
            child: Container(
              height: height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.35),
                    blurRadius: 24,
                    offset: const Offset(0, 16),
                  ),
                ],
              ),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    'assets/images/poster2.jpg',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey[300],
                        child: const Icon(
                          Icons.broken_image,
                          size: 50,
                          color: Colors.grey,
                        ),
                      );
                    },
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.55),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        onPressed: onClose,
                        icon: const Icon(Icons.close, color: Colors.white),
                        tooltip: 'Close',
                        splashRadius: 22,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
