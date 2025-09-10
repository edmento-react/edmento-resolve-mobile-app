import 'package:edmentoresolve/core/di/injection_container.dart';
import 'package:edmentoresolve/core/widgets/navigation/app_bar_widget.dart';
import 'package:edmentoresolve/core/widgets/spacer_widget.dart';
import 'package:edmentoresolve/core/widgets/text_widget.dart';
import 'package:edmentoresolve/features/notifications/presentation/widgets/notification/date_header.dart';
import 'package:edmentoresolve/features/notifications/presentation/widgets/notification/empty_error_views.dart';
import 'package:edmentoresolve/features/notifications/presentation/widgets/notification/filter_bar.dart';
import 'package:edmentoresolve/features/notifications/presentation/widgets/notification/notification_tile.dart';
import 'package:edmentoresolve/features/notifications/presentation/widgets/notification/skeletons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../notifications.dart';
import '../cubit/notifications_cubit.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          NotificationsCubit(sl<INotificationsRepository>())
            ..load(refresh: true),
      child: const NotificationsPageView(),
    );
  }
}

class NotificationsPageView extends StatefulWidget {
  const NotificationsPageView({super.key});

  @override
  State<NotificationsPageView> createState() => _NotificationsPageViewState();
}

class _NotificationsPageViewState extends State<NotificationsPageView> {
  final _scrollCtrl = ScrollController();

  @override
  void initState() {
    super.initState();
    // Load on first frame (after BlocProvider mounts)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<NotificationsCubit>().load(refresh: true);
    });
    _scrollCtrl.addListener(() {
      if (_scrollCtrl.position.pixels >=
          _scrollCtrl.position.maxScrollExtent - 120) {
        context.read<NotificationsCubit>().loadMore();
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
      appBar: AppBarWidget(
        centerTitle: false,
        automaticallyImplyLeading: false,
        titleWidget: BlocBuilder<NotificationsCubit, NotificationsState>(
          buildWhen: (p, c) => p.unreadCount != c.unreadCount,
          builder: (context, state) {
            return Row(
              children: [
                GestureDetector(
                  onTap: () => context.pop(),
                  child: Icon(Icons.arrow_back_ios_new_rounded),
                ),
                SpacerWidget.widthLarge(),
                TextWidget.heading3(context: context, 'Notifications'),
                SpacerWidget.widthSmall(),
                if (state.unreadCount > 0)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: TextWidget.label(
                      '${state.unreadCount} unread',
                      context: context,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
              ],
            );
          },
        ),
        actions: [
          IconButton(
            tooltip: 'Mark all as read',
            icon: const Icon(CupertinoIcons.checkmark_seal),
            onPressed: () => context.read<NotificationsCubit>().markAllAsRead(),
          ),
          PopupMenuButton<String>(
            itemBuilder: (ctx) => [
              PopupMenuItem(
                value: 'settings',
                child: TextWidget.body('Notification settings', context: context),
              ),
              PopupMenuItem(value: 'clear', child: TextWidget.body('Clear read', context: context)),
            ],
            onSelected: (v) {
              if (v == 'clear') {
                final cubit = context.read<NotificationsCubit>();
                final keep = cubit.state.items.where((e) => !e.isRead).toList();
                cubit.emit(cubit.state.copyWith(items: keep));
              }
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            const FilterBar(),
            const Divider(height: 1),
            Expanded(
              child: BlocBuilder<NotificationsCubit, NotificationsState>(
                builder: (context, state) {
                  if (state.isLoading && state.items.isEmpty) {
                    return const SkeletonList();
                  }
                  if (state.error != null && state.items.isEmpty) {
                    return ErrorView(
                      message: 'Failed to load notifications.',
                      onRetry: () => context.read<NotificationsCubit>().load(
                        refresh: true,
                      ),
                    );
                  }
                  if (state.items.isEmpty) {
                    return const EmptyView();
                  }
                  return RefreshIndicator(
                    onRefresh: () =>
                        context.read<NotificationsCubit>().refresh(),
                    child: ListView.separated(
                      controller: _scrollCtrl,
                      padding: const EdgeInsets.fromLTRB(12, 8, 12, 24),
                      itemCount:
                          state.items.length + (state.isLoadingMore ? 1 : 0),
                      separatorBuilder: (_, __) => SpacerWidget.small(),
                      itemBuilder: (context, index) {
                        if (index >= state.items.length) {
                          return const LoadingMoreTile();
                        }
                        final item = state.items[index];
                        final showHeader = _shouldShowHeader(
                          state.items,
                          index,
                        );
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (showHeader) DateHeader(date: item.createdAt),
                            NotificationTile(
                              item: item,
                              onTap: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: TextWidget.body('Open: ${item.title}', context: context),
                                  ),
                                );
                                if (!item.isRead)
                                  context.read<NotificationsCubit>().toggleRead(
                                    item.id,
                                  );
                              },
                              onToggleRead: () => context
                                  .read<NotificationsCubit>()
                                  .toggleRead(item.id),
                              onDelete: () => context
                                  .read<NotificationsCubit>()
                                  .deleteById(item.id),
                            ),
                          ],
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _shouldShowHeader(List<AppNotification> list, int index) {
    if (index == 0) return true;
    final prev = list[index - 1].createdAt;
    final curr = list[index].createdAt;
    return !(prev.year == curr.year &&
        prev.month == curr.month &&
        prev.day == curr.day);
  }
}
