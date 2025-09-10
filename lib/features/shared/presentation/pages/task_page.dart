import 'package:edmentoresolve/core/constants/color_constant.dart';
import 'package:edmentoresolve/core/di/injection_container.dart';
import 'package:edmentoresolve/core/widgets/layout/tab_bar_widget.dart';
import 'package:edmentoresolve/core/widgets/media/gradient_icon.dart';
import 'package:edmentoresolve/core/widgets/navigation/app_bar_widget.dart';
import 'package:edmentoresolve/core/widgets/spacer_widget.dart';
import 'package:edmentoresolve/core/widgets/text_widget.dart';
import 'package:edmentoresolve/features/notifications/presentation/widgets/notification/date_header.dart';
import 'package:edmentoresolve/features/notifications/presentation/widgets/notification/skeletons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../domain/entities/task.dart';
import '../../domain/repositories/tasks_repository.dart';
import '../bloc/tasks_cubit.dart';
import '../widgets/task/task_card.dart';

/// Shared task page that works for all user roles (student, teacher, office admin, etc.)
class SharedTaskPage extends StatelessWidget {
  const SharedTaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    // If you register ITasksRepository in DI, use: sl<ITasksRepository>()
    // For now it falls back to MockTasksRepository in the cubit
    return BlocProvider(
      create: (_) => TasksCubit(
        sl.isRegistered<ITasksRepository>() ? sl<ITasksRepository>() : null,
      )..load(refresh: true),
      child: const _TaskManagerView(),
    );
  }
}

class _TaskManagerView extends StatefulWidget {
  const _TaskManagerView();

  @override
  State<_TaskManagerView> createState() => _TaskManagerViewState();
}

class _TaskManagerViewState extends State<_TaskManagerView>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  final _scrollCtrl = ScrollController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    _scrollCtrl.addListener(() {
      if (_scrollCtrl.position.pixels >=
          _scrollCtrl.position.maxScrollExtent - 120) {
        context.read<TasksCubit>().loadMore();
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _CreatePill(
        onTap: () {
          // TODO: open create task flow
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: TextWidget.body('Create Task', context: context)),
          );
        },
      ),

      appBar: AppBarWidget(
        centerTitle: false,
        automaticallyImplyLeading: false,
        title: 'Task Manager',
      ),
      body: SafeArea(
        child: Column(
          children: [
            AppTabBar.solid(
              controller: _tabController,
              tabs: const ['Pending', 'Completed'],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _TasksList(
                    status: TaskStatus.pending,
                    scrollController: _scrollCtrl,
                  ),
                  _TasksList(
                    status: TaskStatus.completed,
                    scrollController: _scrollCtrl,
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

/// Tasks list widget that filters tasks by status
class _TasksList extends StatelessWidget {
  final TaskStatus status;
  final ScrollController scrollController;

  const _TasksList({required this.status, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksCubit, TasksState>(
      builder: (context, state) {
        // Filter tasks by status
        final filteredTasks = state.items
            .where((task) => task.status == status)
            .toList();

        if (state.isLoading && state.items.isEmpty) {
          return const SkeletonList();
        }
        if (state.error != null && state.items.isEmpty) {
          return _ErrorView(
            message: 'Failed to load tasks.',
            onRetry: () => context.read<TasksCubit>().load(refresh: true),
          );
        }
        if (filteredTasks.isEmpty) {
          return _EmptyView(status: status);
        }

        return RefreshIndicator(
          onRefresh: () => context.read<TasksCubit>().refresh(),
          child: ListView.separated(
            controller: scrollController,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            itemCount: filteredTasks.length + (state.isLoadingMore ? 1 : 0),
            separatorBuilder: (_, __) => SpacerWidget.custom(12),
            itemBuilder: (context, index) {
              if (index >= filteredTasks.length) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  child: Center(
                    child: CircularProgressIndicator(strokeWidth: 2.w),
                  ),
                );
              }
              final task = filteredTasks[index];
              final showHeader = _shouldShowHeader(filteredTasks, index);

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (showHeader)
                    DateHeader(date: task.dueAt ?? DateTime.now()),
                  TaskCard(
                    task: task,
                    onTap: () {
                      // TODO: open task detail
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: TextWidget.body(
                            'Open: ${task.title}',
                            context: context,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  bool _shouldShowHeader(List<Task> list, int index) {
    // Show header for "Today" and for day boundaries; tasks without due date
    final curr = list[index].dueAt;
    if (curr == null)
      return index == 0; // show just once if first no-due comes at top

    if (index == 0) return true;
    final prev = list[index - 1].dueAt;
    if (prev == null) return true;

    return !(prev.year == curr.year &&
        prev.month == curr.month &&
        prev.day == curr.day);
  }
}

/// Create pill button (gradient outline like screenshot)
class _CreatePill extends StatelessWidget {
  final VoidCallback onTap;
  const _CreatePill({required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          gradient: ColorConstant.appGradient2,
          borderRadius: BorderRadius.circular(999),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.1),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        padding: EdgeInsets.all(2.w),
        child: Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(999),
          ),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              GradientIcon(
                CupertinoIcons.add,
                size: 18.sp,
                gradient: ColorConstant.appGradient2,
              ),
              SpacerWidget.widthSmall(),
              TextWidget.heading4(
                'Create',
                context: context,
                fontWeight: FontWeight.w700,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmptyView extends StatelessWidget {
  final TaskStatus? status;
  const _EmptyView({this.status});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isCompleted = status == TaskStatus.completed;

    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isCompleted
                  ? CupertinoIcons.checkmark_circle
                  : CupertinoIcons.square_list,
              size: 56.w,
              color: theme.dividerColor,
            ),
            SpacerWidget.custom(12),
            TextWidget.heading4(
              isCompleted ? 'No completed tasks' : 'No pending tasks',
              context: context,
              fontWeight: FontWeight.w700,
            ),
            SpacerWidget.custom(6),
            TextWidget.caption(
              context: context,
              isCompleted
                  ? 'Completed tasks will appear here once you finish them.'
                  : 'You\'re all set. New tasks will appear here.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;
  const _ErrorView({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              CupertinoIcons.exclamationmark_triangle,
              size: 56.w,
              color: theme.colorScheme.error,
            ),
            SpacerWidget.custom(12),
            TextWidget.heading4(
              'Something went wrong',
              context: context,
              fontWeight: FontWeight.w700,
            ),
            SpacerWidget.custom(6),
            TextWidget.body(
              message,
              context: context,
              textAlign: TextAlign.center,
            ),
            SpacerWidget.medium(),
            FilledButton.icon(
              onPressed: onRetry,
              icon: const Icon(CupertinoIcons.arrow_clockwise),
              label: TextWidget.label('Try again', context: context),
            ),
          ],
        ),
      ),
    );
  }
}
