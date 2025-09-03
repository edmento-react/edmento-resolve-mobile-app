import 'package:edmentoresolve/core/constants/color_constant.dart';
import 'package:edmentoresolve/core/di/injection_container.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:edmentoresolve/core/widgets/index.dart';
import 'package:edmentoresolve/core/widgets/tab_bar_widget.dart';
import 'package:edmentoresolve/features/common/presentation/widget/notification/date_header.dart';
import 'package:edmentoresolve/features/teacher/domain/entities/comm_message.dart';
import 'package:edmentoresolve/features/teacher/domain/enums/comm_tab.dart';
import 'package:edmentoresolve/features/teacher/domain/repositories/communication_repository.dart';
import 'package:edmentoresolve/features/teacher/presentation/Bloc/communication_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/communication/empty_view.dart';
import '../widgets/communication/message_tile.dart';
import '../widgets/communication/skeletons.dart';

class TeacherCommunicationPage extends StatelessWidget {
  const TeacherCommunicationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CommunicationCubit(sl<ICommunicationRepository>()),
      child: const _TeacherCommunicationPageView(),
    );
  }
}

class _TeacherCommunicationPageView extends StatefulWidget {
  const _TeacherCommunicationPageView({super.key});

  @override
  State<_TeacherCommunicationPageView> createState() =>
      _TeacherCommunicationPageViewState();
}

class _TeacherCommunicationPageViewState
    extends State<_TeacherCommunicationPageView>
    with SingleTickerProviderStateMixin {
  late final TabController _tab;

  // One scroll controller per tab for independent infinite scroll
  final _scrollCtrls = {
    CommTab.all: ScrollController(),
    CommTab.sent: ScrollController(),
    CommTab.receive: ScrollController(),
    CommTab.requests: ScrollController(),
  };

  @override
  void initState() {
    super.initState();
    _tab = TabController(length: 4, vsync: this);

    // Initial load for default tab
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CommunicationCubit>().ensureLoaded(CommTab.all);
    });

    // Sync Cubit when user swipes between tabs
    _tab.addListener(() {
      if (_tab.indexIsChanging) return;
      final tab = CommTab.values[_tab.index];
      context.read<CommunicationCubit>().setTab(tab);
    });

    // Infinite scroll per tab
    _scrollCtrls.forEach((tab, ctrl) {
      ctrl.addListener(() {
        if (ctrl.position.pixels >= ctrl.position.maxScrollExtent - 120) {
          context.read<CommunicationCubit>().loadMore(tab);
        }
      });
    });
  }

  @override
  void dispose() {
    _tab.dispose();
    for (final c in _scrollCtrls.values) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(centerTitle: false, title: 'Communication Desk'),
      floatingActionButton: const _ComposePill(),
      body: Column(
        children: [
          // Use your custom AppTabBar.solid
          AppTabBar.solid(
            controller: _tab,
            tabs: const ['All', 'Sent', 'Recieve', 'Requests'],
            onTap: (idx) {
              // Keep Cubit in sync when user taps a tab
              final tab = CommTab.values[idx];
              context.read<CommunicationCubit>().setTab(tab);
            },
          ),
          Expanded(
            child: TabBarView(
              controller: _tab,
              children: [
                _MessagesList(
                  tab: CommTab.all,
                  controller: _scrollCtrls[CommTab.all]!,
                ),
                _MessagesList(
                  tab: CommTab.sent,
                  controller: _scrollCtrls[CommTab.sent]!,
                ),
                _MessagesList(
                  tab: CommTab.receive,
                  controller: _scrollCtrls[CommTab.receive]!,
                ),
                _MessagesList(
                  tab: CommTab.requests,
                  controller: _scrollCtrls[CommTab.requests]!,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MessagesList extends StatefulWidget {
  final CommTab tab;
  final ScrollController controller;
  const _MessagesList({required this.tab, required this.controller});

  @override
  State<_MessagesList> createState() => _MessagesListState();
}

class _MessagesListState extends State<_MessagesList> {
  @override
  void initState() {
    super.initState();
    // Lazy load when this tab view first builds
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CommunicationCubit>().ensureLoaded(widget.tab);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommunicationCubit, CommunicationState>(
      buildWhen: (p, c) =>
          p.items[widget.tab] != c.items[widget.tab] ||
          p.isLoading[widget.tab] != c.isLoading[widget.tab] ||
          p.errors[widget.tab] != c.errors[widget.tab] ||
          p.isLoadingMore[widget.tab] != c.isLoadingMore[widget.tab],
      builder: (context, state) {
        final list = state.listOf(widget.tab);
        final isLoading = state.isLoading[widget.tab] ?? false;
        final isLoadingMore = state.isLoadingMore[widget.tab] ?? false;
        final error = state.errors[widget.tab];

        if (isLoading && list.isEmpty) return const SkeletonList();
        if (error != null && list.isEmpty) {
          return const EmptyView(message: 'Failed to load messages');
        }
        if (list.isEmpty) return const EmptyView(message: 'No messages');

        return RefreshIndicator(
          onRefresh: () =>
              context.read<CommunicationCubit>().refresh(widget.tab),
          child: ListView.separated(
            controller: widget.controller,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            itemCount: list.length + (isLoadingMore ? 1 : 0),
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (context, index) {
              if (index >= list.length) {
                // Loading-more footer
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Center(
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                );
              }

              final item = list[index];
              final showHeader = _shouldShowHeader(list, index);

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (showHeader) DateHeader(date: item.createdAt),
                  MessageTile(item: item),
                ],
              );
            },
          ),
        );
      },
    );
  }

  bool _shouldShowHeader(List<CommMessage> list, int index) {
    if (index == 0) return true;
    final prev = list[index - 1].createdAt;
    final curr = list[index].createdAt;
    return !(prev.year == curr.year &&
        prev.month == curr.month &&
        prev.day == curr.day);
  }
}

class _ComposePill extends StatelessWidget {
  const _ComposePill();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () => ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: TextWidget.body('Compose', context: context)),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: ColorConstant.appGradient2,
          borderRadius: BorderRadius.circular(999),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.08),
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
                'Compose',
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
