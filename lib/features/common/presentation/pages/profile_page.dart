import 'dart:io';

import 'package:edmentoresolve/core/constants/color_constant.dart';
import 'package:edmentoresolve/core/constants/general_functions.dart';
import 'package:edmentoresolve/core/constants/routes.dart';
import 'package:edmentoresolve/core/widgets/app_card.dart';
import 'package:edmentoresolve/core/widgets/index.dart';
import 'package:edmentoresolve/core/widgets/sliver_bar_widget.dart';
import 'package:edmentoresolve/features/authentication/domain/entities/user_entity.dart';
import 'package:edmentoresolve/features/common/presentation/cubit/theme_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../authentication/presentation/bloc/auth_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: BlocBuilder<AuthBloc, AuthState>(
        buildWhen: (prev, curr) => curr is AuthSuccess || curr is AuthLoading,
        builder: (context, state) {
          if (state is AuthSuccess) {
            final user = state.authResult.user;
            return _ProfileContent(user: user, colorScheme: colorScheme);
          }
          return const LoadingIndicator(color: Colors.yellow);
        },
      ),
    );
  }
}

class _ProfileContent extends StatelessWidget {
  final User user;
  final ColorScheme colorScheme;
  const _ProfileContent({required this.user, required this.colorScheme});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const ClampingScrollPhysics(),
      scrollBehavior: const ScrollBehavior().copyWith(overscroll: false),
      slivers: [
        SliverBarWidget(
          title: 'Profile',
          foregroundColor: ColorConstant.textPrimaryDark,
          expandedHeight: ScreenUtil().screenHeight / 3,
          flexibleSpace: FlexibleSpaceBar(
            background: _ProfileHeader(user: user),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
            child: Column(
              children: [
                if (user.roles.length != 1) const _RoleSwitchTile(),
                _buildCardSection(
                  context,
                  'Account Settings',
                  _AccountSettingsList(colorScheme: colorScheme),
                ),
                BlocSelector<ThemeCubit, ThemeMode, ThemeMode>(
                  selector: (state) => state,
                  builder: (context, themeMode) => _buildCardSection(
                    context,
                    'Appearance',
                    _AppearanceList(
                      colorScheme: colorScheme,
                      themeMode: themeMode,
                    ),
                  ),
                ),
                _buildCardSection(
                  context,
                  'Account Actions',
                  _AccountActionsList(colorScheme: colorScheme),
                ),
                SizedBox(
                  width: double.infinity,
                  child: ButtonWidget.secondary(
                    context: context,
                    label: 'Sign Out',
                    onPressed: () => AppDialog.logout(context: context),
                    icon: Icons.logout,
                    foregroundColor: ColorConstant.red,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCardSection(BuildContext context, String title, Widget child) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWidget.heading3(title, context: context),
        SpacerWidget.medium(),
        child,
        SpacerWidget.xxlarge(),
      ],
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  final User user;
  const _ProfileHeader({required this.user});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                ColorConstant.primaryLight.withOpacity(0.9),
                ColorConstant.primaryLight.withOpacity(0.7),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                AvatarWidget(imageUrl: user.avatar, name: user.name, size: 100),
                SpacerWidget.medium(),
                TextWidget.heading2(
                  user.name!,
                  context: context,
                  color: ColorConstant.white,
                ),
                TextWidget.body(
                  user.email,
                  color: ColorConstant.white.withOpacity(0.7),
                  context: context,
                ),
                const SizedBox(height: 4),
                TextWidget.caption(
                  'Member since ${user.created_at}',
                  context: context,
                  color: ColorConstant.white.withOpacity(0.6),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _RoleSwitchTile extends StatelessWidget {
  const _RoleSwitchTile();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: GestureDetector(
        onTap: () => context.push(AppRoutes.roleSelecting),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconWidget.medium(Icons.switch_account_outlined),
            SpacerWidget.widthMedium(),
            TextWidget.heading3('Switch your role', context: context),
          ],
        ),
      ),
    );
  }
}

class _AccountSettingsList extends StatelessWidget {
  final ColorScheme colorScheme;
  const _AccountSettingsList({required this.colorScheme});

  @override
  Widget build(BuildContext context) {
    final border = _cardBorder(colorScheme);
    return Wrap(
      runSpacing: 10.h,
      children: [
        _buildCard(
          context,
          'Edit Profile',
          CupertinoIcons.person,
          Icons.person_outline,
          'Update info',
          border,
        ),
        _buildCard(
          context,
          'Change Email',
          CupertinoIcons.mail,
          Icons.email_outlined,
          'Update email',
          border,
        ),
        _buildCard(
          context,
          'Change Password',
          CupertinoIcons.lock,
          Icons.lock_outline,
          'Update password',
          border,
        ),
        _buildCard(
          context,
          'Notifications',
          CupertinoIcons.bell,
          Icons.notifications_outlined,
          'Preferences',
          border,
        ),
      ],
    );
  }
}

class _AppearanceList extends StatelessWidget {
  final ColorScheme colorScheme;
  final ThemeMode themeMode;
  const _AppearanceList({required this.colorScheme, required this.themeMode});

  @override
  Widget build(BuildContext context) {
    return _buildCard(
      context,
      'Theme Mode',
      null,
      Icons.brightness_4_outlined,
      "Current: ${capitalizeFirst(themeMode.name)}",
      _cardBorder(colorScheme),
      onTap: () => _showThemeModeBottomSheet(context),
    );
  }
}

class _AccountActionsList extends StatelessWidget {
  final ColorScheme colorScheme;
  const _AccountActionsList({required this.colorScheme});

  @override
  Widget build(BuildContext context) {
    final border = _cardBorder(colorScheme);
    return Wrap(
      runSpacing: 10.h,
      children: [
        _buildCard(
          context,
          'Export Data',
          CupertinoIcons.arrow_down_to_line,
          Icons.download_outlined,
          'Download info',
          border,
        ),
        _buildCard(
          context,
          'Delete Account',
          CupertinoIcons.delete,
          Icons.delete_outline,
          'Permanently delete',
          border,
          isDestructive: true,
          onTap: () => _showDeleteAccountDialog(context),
        ),
      ],
    );
  }
}

/// 🔹 Helpers

Border _cardBorder(ColorScheme colorScheme) =>
    Border.all(color: colorScheme.outline);

Widget _buildCard(
  BuildContext context,
  String title,
  IconData? cupertinoIcon,
  IconData androidIcon,
  String subtitle,
  Border border, {
  bool isDestructive = false,
  VoidCallback? onTap,
}) {
  return AppCard.horizontal(
    elevation: 2,
    title: title,
    subtitle: subtitle,
    leading: Icon(
      Platform.isIOS && cupertinoIcon != null ? cupertinoIcon : androidIcon,
      color: isDestructive ? ColorConstant.red : null,
    ),
    trailing: IconWidget.tiny(
      Platform.isIOS ? CupertinoIcons.right_chevron : Icons.chevron_right,
      color: ColorConstant.grey400,
      size: 24.w,
    ),
    border: border,
    onTap: onTap,
  );
}

void _showThemeModeBottomSheet(BuildContext context) {
  final currentMode = context.read<ThemeCubit>().state;

  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (_) => Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 16),
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: ColorConstant.grey400,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 24),
          TextWidget.heading2(context: context, 'Select Theme Mode'),
          const SizedBox(height: 12),
          ...ThemeMode.values.map(
            (mode) => RadioListTile<ThemeMode>(
              value: mode,
              groupValue: currentMode,
              onChanged: (val) {
                context.pop();
                context.read<ThemeCubit>().setTheme(val!);
              },
              title: TextWidget.body(
                capitalizeFirst(mode.name),
                context: context,
              ),
              activeColor: ColorConstant.primaryLight,
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    ),
  );
}

void _showDeleteAccountDialog(BuildContext context) {
  AppDialog.show(
    context: context,
    title: 'Delete Account',
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconWidget.large(
          Platform.isIOS ? CupertinoIcons.delete : Icons.warning,
          color: ColorConstant.red,
        ),
        const SizedBox(height: 16),
        TextWidget.body(
          'Are you sure you want to delete your account? This action cannot be undone.',
          textAlign: TextAlign.center,
          context: context,
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            Expanded(
              child: ButtonWidget.text(
                context: context,
                label: 'Cancel',
                onPressed: () => context.pop(),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ButtonWidget.secondary(
                context: context,
                label: 'Delete',
                onPressed: () {
                  context.pop();
                  // Add delete logic
                },
                foregroundColor: ColorConstant.red,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
