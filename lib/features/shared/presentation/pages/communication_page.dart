import 'package:edmentoresolve/core/constants/color_constant.dart';
import 'package:edmentoresolve/core/di/injection_container.dart';
import 'package:edmentoresolve/core/widgets/index.dart';
import 'package:edmentoresolve/features/notifications/presentation/widgets/notification/date_header.dart';
import 'package:edmentoresolve/features/shared/presentation/pages/compose_email_page.dart';
import 'package:edmentoresolve/features/shared/presentation/pages/compose_email_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import '../../domain/entities/communication_message.dart';
import '../../domain/enums/communication_tab.dart';
import '../../domain/repositories/communication_repository.dart';
import '../bloc/communication_cubit.dart';
import '../widgets/communication/empty_view.dart';
import '../widgets/communication/message_tile.dart';
import '../widgets/communication/skeletons.dart';

/// Shared communication page that works for all user roles (student, teacher, office admin, etc.)
class SharedCommunicationPage extends StatelessWidget {
  const SharedCommunicationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CommunicationCubit(sl<ICommunicationRepository>()),
      child: const _SharedCommunicationPageView(),
    );
  }
}

class _SharedCommunicationPageView extends StatefulWidget {
  const _SharedCommunicationPageView();

  @override
  State<_SharedCommunicationPageView> createState() =>
      _SharedCommunicationPageViewState();
}

class _SharedCommunicationPageViewState
    extends State<_SharedCommunicationPageView>
    with TickerProviderStateMixin {
  late final TabController _tab;

  // Independent scroll controllers per tab
  final _scrollCtrls = {
    CommunicationTab.all: ScrollController(),
    CommunicationTab.sent: ScrollController(),
    CommunicationTab.receive: ScrollController(),
    CommunicationTab.requests: ScrollController(),
  };

  @override
  void initState() {
    super.initState();
    _tab = TabController(length: 4, vsync: this);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CommunicationCubit>().ensureLoaded(CommunicationTab.all);
    });

    _tab.addListener(() {
      if (_tab.indexIsChanging) return;
      final tab = CommunicationTab.values[_tab.index];
      context.read<CommunicationCubit>().setTab(tab);
    });

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
      floatingActionButton: Container(
        padding: EdgeInsets.all(2.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          gradient: ColorConstant.appGradient2,
        ),
        child: SpeedDial(
          buttonSize: Size(50.w, 50.h),
          label: TextWidget.heading3('Compose', context: context),
          children: [
            SpeedDialChild(
              onTap: () {
                navigateToComposeEmail(context, mode: ComposeMode.schedule);
              },
              labelWidget: _Pill(label: 'Schedule a mail', isIcon: false),
              shape: const CircleBorder(),
            ),
            SpeedDialChild(
              onTap: () {
                navigateToComposeEmail(context, mode: ComposeMode.compose);
              },
              labelWidget: _Pill(label: 'Compose a mail', isIcon: false),
              shape: const CircleBorder(),
            ),
            SpeedDialChild(
              onTap: () {
                navigateToComposeEmail(context, mode: ComposeMode.leave);
              },
              labelWidget: _Pill(label: 'Apply leave', isIcon: false),
              shape: const CircleBorder(),
            ),
          ],
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          useRotationAnimation: true,
          icon: Icons.add,
        ),
      ),
      body: Column(
        children: [
          AppTabBar.solid(
            controller: _tab,
            tabs: const ['All', 'Sent', 'Recieve', 'Requests'],
            onTap: (idx) {
              final tab = CommunicationTab.values[idx];
              context.read<CommunicationCubit>().setTab(tab);
            },
          ),
          Expanded(
            child: TabBarView(
              controller: _tab,
              children: [
                _MessagesList(
                  tab: CommunicationTab.all,
                  controller: _scrollCtrls[CommunicationTab.all]!,
                ),
                _MessagesList(
                  tab: CommunicationTab.sent,
                  controller: _scrollCtrls[CommunicationTab.sent]!,
                ),
                _MessagesList(
                  tab: CommunicationTab.receive,
                  controller: _scrollCtrls[CommunicationTab.receive]!,
                ),
                _MessagesList(
                  tab: CommunicationTab.requests,
                  controller: _scrollCtrls[CommunicationTab.requests]!,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// ----------------------
/// Messages List Widget
/// ----------------------
class _MessagesList extends StatefulWidget {
  final CommunicationTab tab;
  final ScrollController controller;
  const _MessagesList({required this.tab, required this.controller});

  @override
  State<_MessagesList> createState() => _MessagesListState();
}

class _MessagesListState extends State<_MessagesList> {
  @override
  void initState() {
    super.initState();
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
        final cubit = context.read<CommunicationCubit>();
        final list = cubit.listOf(widget.tab);
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
            separatorBuilder: (_, __) => Divider(height: 1.h),
            itemBuilder: (context, index) {
              if (index >= list.length) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  child: Center(
                    child: CircularProgressIndicator(strokeWidth: 2.w),
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

  bool _shouldShowHeader(List<CommunicationMessage> list, int index) {
    if (index == 0) return true;
    final prev = list[index - 1].createdAt;
    final curr = list[index].createdAt;
    return !(prev.year == curr.year &&
        prev.month == curr.month &&
        prev.day == curr.day);
  }
}

/// ----------------------
/// Pill Widget
/// ----------------------
class _Pill extends StatelessWidget {
  final String label;
  final bool isIcon;
  const _Pill({required this.label, this.isIcon = false});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        gradient: ColorConstant.appGradient2,
        borderRadius: BorderRadius.circular(999),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
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
            if (isIcon)
              GradientIcon(
                CupertinoIcons.add,
                size: 18.sp,
                gradient: ColorConstant.appGradient2,
              ),
            if (isIcon) SpacerWidget.widthSmall(),
            TextWidget.heading4(
              label,
              context: context,
              fontWeight: FontWeight.w700,
            ),
          ],
        ),
      ),
    );
  }
}
