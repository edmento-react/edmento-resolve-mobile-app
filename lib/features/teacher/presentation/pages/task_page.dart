import 'package:edmentoresolve/core/constants/color_constant.dart';
import 'package:edmentoresolve/core/di/injection_container.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:edmentoresolve/core/widgets/app_bar_widget.dart';
import 'package:edmentoresolve/core/widgets/text_widget.dart';
import 'package:edmentoresolve/features/common/presentation/widget/notification/date_header.dart';
import 'package:edmentoresolve/features/common/presentation/widget/notification/skeletons.dart';
import 'package:edmentoresolve/features/teacher/presentation/Bloc/tasks_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/task.dart';
import '../../domain/repositories/tasks_repository.dart';
import '../widgets/task/task_card.dart';

class TeacherTaskPage extends StatelessWidget {
  const TeacherTaskPage({super.key});

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
  const _TaskManagerView({super.key});

  @override
  State<_TaskManagerView> createState() => _TaskManagerViewState();
}

class _TaskManagerViewState extends State<_TaskManagerView> {
  final _scrollCtrl = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollCtrl.addListener(() {
      if (_scrollCtrl.position.pixels >=
          _scrollCtrl.position.maxScrollExtent - 120) {
        context.read<TasksCubit>().loadMore();
      }
    });
  }

  @override
  void dispose() {
    _scrollCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

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
        child: BlocBuilder<TasksCubit, TasksState>(
          builder: (context, state) {
            if (state.isLoading && state.items.isEmpty) {
              return const SkeletonList();
            }
            if (state.error != null && state.items.isEmpty) {
              return _ErrorView(
                message: 'Failed to load tasks.',
                onRetry: () => context.read<TasksCubit>().load(refresh: true),
              );
            }
            if (state.items.isEmpty) {
              return const _EmptyView();
            }

            return RefreshIndicator(
              onRefresh: () => context.read<TasksCubit>().refresh(),
              child: ListView.separated(
                controller: _scrollCtrl,
                padding:
                    EdgeInsets.symmetric(horizontal: 16.w), // bottom space for create pill
                itemCount: state.items.length + (state.isLoadingMore ? 1 : 0),
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  if (index >= state.items.length) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Center(
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    );
                  }
                  final item = state.items[index];
                  final showHeader = _shouldShowHeader(state.items, index);
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (showHeader)
                        DateHeader(date: item.dueAt ?? DateTime.now()),
                      TaskCard(
                        task: item,
                        onTap: () {
                          // TODO: open task detail
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: TextWidget.body(
                                'Open: ${item.title}',
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
        ),
      ),
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
          // gradient: const LinearGradient(
          //   colors: [Color(0xFF22C55E), Color(0xFF3B82F6)],
          // ),
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
        padding: const EdgeInsets.all(2),
        child: Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(999),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                CupertinoIcons.add,
                size: 18,
                color: theme.colorScheme.primary,
              ),
              const SizedBox(width: 8),
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
  const _EmptyView();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              CupertinoIcons.square_list,
              size: 56,
              color: theme.dividerColor,
            ),
            const SizedBox(height: 12),
            TextWidget.heading4(
              'No tasks',
              context: context,
              fontWeight: FontWeight.w700,
            ),
            const SizedBox(height: 6),
            TextWidget.caption(
              context: context,
              'You’re all set. New tasks will appear here.',
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
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              CupertinoIcons.exclamationmark_triangle,
              size: 56,
              color: theme.colorScheme.error,
            ),
            const SizedBox(height: 12),
            TextWidget.heading4(
              'Something went wrong',
              context: context,
              fontWeight: FontWeight.w700,
            ),
            const SizedBox(height: 6),
            TextWidget.body(
              message,
              context: context,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
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
