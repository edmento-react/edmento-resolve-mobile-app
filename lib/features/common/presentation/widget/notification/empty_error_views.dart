import 'package:edmentoresolve/core/widgets/text_widget.dart';
import 'package:edmentoresolve/features/common/presentation/cubit/notifications_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmptyView extends StatelessWidget {
  const EmptyView({super.key});

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
              CupertinoIcons.bell_slash,
              size: 56,
              color: theme.dividerColor,
            ),
            const SizedBox(height: 12),
            TextWidget.heading4(
              'No notifications',
              context: context,
              fontWeight: FontWeight.w700,
            ),
            const SizedBox(height: 6),
            TextWidget.caption(
              context: context,
              'You’re all caught up. New updates will appear here.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: () =>
                  context.read<NotificationsCubit>().load(refresh: true),
              icon: const Icon(CupertinoIcons.arrow_clockwise),
              label: TextWidget.label('Refresh', context: context),
            ),
          ],
        ),
      ),
    );
  }
}

class ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;
  const ErrorView({super.key, required this.message, required this.onRetry});

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
