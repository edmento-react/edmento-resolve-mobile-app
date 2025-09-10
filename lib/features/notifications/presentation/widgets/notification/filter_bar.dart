import 'package:edmentoresolve/core/widgets/spacer_widget.dart';
import 'package:edmentoresolve/core/widgets/text_widget.dart';
import 'package:edmentoresolve/features/notifications/domain/repositories/notifications_repository.dart';
import 'package:edmentoresolve/features/notifications/presentation/cubit/notifications_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilterBar extends StatelessWidget {
  const FilterBar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final chips = <({String label, NotificationFilter filter, IconData icon})>[
      (label: 'All', filter: NotificationFilter.all, icon: CupertinoIcons.bell),
      (
        label: 'Unread',
        filter: NotificationFilter.unread,
        icon: CupertinoIcons.envelope_badge,
      ),
      (
        label: 'System',
        filter: NotificationFilter.system,
        icon: CupertinoIcons.gear_alt_fill,
      ),
      (
        label: 'Activity',
        filter: NotificationFilter.activity,
        icon: CupertinoIcons.bolt_fill,
      ),
    ];

    return BlocBuilder<NotificationsCubit, NotificationsState>(
      buildWhen: (p, c) => p.filter != c.filter,
      builder: (context, state) {
        return SizedBox(
          height: 56,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            scrollDirection: Axis.horizontal,
            itemBuilder: (_, i) {
              final c = chips[i];
              final selected = state.filter == c.filter;
              return ChoiceChip(
                label: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      c.icon,
                      size: 16,
                      color: selected ? theme.colorScheme.onPrimary : null,
                    ),
                    SpacerWidget.widthCustom(6),
                    TextWidget.label(c.label, context: context),
                  ],
                ),
                selected: selected,
                onSelected: (_) =>
                    context.read<NotificationsCubit>().setFilter(c.filter),
                selectedColor: theme.colorScheme.primary,
                labelStyle: TextStyle(
                  color: selected ? theme.colorScheme.onPrimary : null,
                  fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
                ),
                shape: StadiumBorder(
                  side: BorderSide(color: theme.dividerColor),
                ),
                backgroundColor: theme.colorScheme.surface,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              );
            },
            separatorBuilder: (_, __) => SpacerWidget.widthSmall(),
            itemCount: chips.length,
          ),
        );
      },
    );
  }
}
