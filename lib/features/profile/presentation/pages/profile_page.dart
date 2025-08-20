import 'dart:io';

import 'package:edmentoresolve/core/constants/color_constant.dart';
import 'package:edmentoresolve/core/constants/general_functions.dart';
import 'package:edmentoresolve/core/constants/routes.dart';
import 'package:edmentoresolve/core/utils/screen_util.dart';
import 'package:edmentoresolve/core/widgets/content_widget.dart';
import 'package:edmentoresolve/core/widgets/index.dart';
import 'package:edmentoresolve/core/widgets/sliver_bar_widget.dart';
import 'package:edmentoresolve/features/authentication/domain/entities/user_entity.dart';
import 'package:edmentoresolve/features/profile/presentation/bloc/theme_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../authentication/presentation/bloc/auth_bloc.dart';

// class ProfilePage extends StatelessWidget {
//   const ProfilePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBarWidget(title: 'Profile', automaticallyImplyLeading: true),
//       body: BlocListener<AuthBloc, AuthState>(
//         listener: (context, state) {
//           if (state is AuthInitial) {
//             context.go('/login');
//           }
//         },
//         child: BlocBuilder<AuthBloc, AuthState>(
//           builder: (context, state) {
//             if (state is AuthLoading) return const LoadingIndicator();

//             if (state is AuthSuccess) {
//               final user = state.authResult.user;

//               return SingleChildScrollView(
//                 padding: ScreenUtil.getAdaptivePadding(
//                   horizontal: 24,
//                   vertical: 24,
//                   tabletHorizontal: 48,
//                   tabletVertical: 48,
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     _buildProfileHeader(user, context),
//                     SpacerWidget.xlarge(),
//                     _buildSectionTitle('Account Settings', context),
//                     _buildAccountSettingsList(context),
//                     BlocBuilder<ThemeCubit, ThemeMode>(
//                       builder: (context, themeMode) {
//                         return Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             SpacerWidget.xlarge(),
//                             _buildSectionTitle('Appearance', context),
//                             tileContent(
//                               icon: Icons.brightness_4_outlined,
//                               title: 'Theme Mode',
//                               subtitle:
//                                   "Current Mode: ${capitalizeFirst(themeMode.name)}",
//                               onTap: () => _showThemeModeBottomSheet(context),
//                               isTrailing: true,
//                               context: context,
//                             ),
//                           ],
//                         );
//                       },
//                     ),
//                     SpacerWidget.xlarge(),
//                     _buildSectionTitle('Account Actions', context),
//                     _buildAccountActionsList(context),
//                     SpacerWidget.xlarge(),
//                     SizedBox(
//                       width: double.infinity,
//                       child: ButtonWidget.secondary(
//                         context: context,
//                         label: 'Sign Out',
//                         onPressed: () =>
//                             context.read<AuthBloc>().add(LogoutRequested()),
//                         icon: Icons.logout,
//                         foregroundColor: ColorConstant.red,
//                       ),
//                     ),
//                     SpacerWidget.medium(),
//                   ],
//                 ),
//               );
//             }

//             return const LoadingIndicator();
//           },
//         ),
//       ),
//     );
//   }

//   Widget _buildProfileHeader(dynamic user, BuildContext context) {
//     return CardWidget(
//       child: Row(
//         children: [
//           AvatarWidget(imageUrl: user.avatar, name: user.name, size: 90),
//           SpacerWidget.widthXlarge(),
//           Column(
//             mainAxisSize: MainAxisSize.min,
//             // crossAxisAlignment: CrossAxisAlignment.stretch,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // SpacerWidget.medium(),
//               TextWidget.heading2(
//                 user.name!,
//                 textAlign: TextAlign.center,
//                 context: context,
//               ),
//               SpacerWidget.small(),
//               TextWidget.body(
//                 user.email,
//                 color: ColorConstant.textSecondary,
//                 textAlign: TextAlign.center,
//                 context: context,
//               ),
//               SpacerWidget.medium(),
//               TextWidget.caption(
//                 'Member since ${DateFormat('MMMM yyyy').format(user.createdAt!)}',
//                 color: ColorConstant.textCaption,
//                 textAlign: TextAlign.center,
//                 context: context,
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildSectionTitle(String title, BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         TextWidget.heading3(title, context: context),
//         SpacerWidget.medium(),
//       ],
//     );
//   }

//   Widget _buildAccountSettingsList(BuildContext context) {
//     return ListWidget.simple(
//       shrinkWrap: true,
//       padding: EdgeInsets.zero,
//       physics: const NeverScrollableScrollPhysics(),
//       children: [
//         tileContent(
//           icon: Icons.person_outline,
//           title: 'Edit Profile',
//           subtitle: 'Update your personal information',
//           onTap: () {},
//           isTrailing: true,
//           context: context,
//         ),
//         tileContent(
//           icon: Icons.email_outlined,
//           title: 'Change Email',
//           subtitle: 'Update your email address',
//           onTap: () {},
//           isTrailing: true,
//           context: context,
//         ),
//         tileContent(
//           icon: Icons.lock_outline,
//           title: 'Change Password',
//           subtitle: 'Update your password',
//           onTap: () {},
//           isTrailing: true,
//           context: context,
//         ),
//         tileContent(
//           icon: Icons.notifications_outlined,
//           title: 'Notifications',
//           subtitle: 'Manage notification preferences',
//           onTap: () {},
//           isTrailing: true,
//           context: context,
//         ),
//       ],
//     );
//   }

//   Widget _buildAccountActionsList(BuildContext context) {
//     return ListWidget.simple(
//       padding: EdgeInsets.zero,
//       shrinkWrap: true,
//       physics: const NeverScrollableScrollPhysics(),
//       children: [
//         tileContent(
//           icon: Platform.isIOS
//               ? CupertinoIcons.arrow_down_to_line
//               : Icons.download_outlined,
//           title: 'Export Data',
//           subtitle: 'Download your data',
//           onTap: () {},
//           context: context,
//         ),
//         tileContent(
//           icon: Platform.isIOS ? CupertinoIcons.delete : Icons.delete_outline,
//           title: 'Delete Account',
//           subtitle: 'Permanently delete your account',
//           onTap: () => _showDeleteAccountDialog(context),
//           isDestructive: true,
//           context: context,
//         ),
//       ],
//     );
//   }

//   void _showThemeModeBottomSheet(BuildContext context) {
//     final currentMode = context.read<ThemeCubit>().state;

//     showModalBottomSheet(
//       context: context,
//       builder: (_) => Padding(
//         padding: ScreenUtil.getAdaptivePadding(smallPhoneHorizontal: 20),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             DividerWidget.thick(
//               color: ColorConstant.textCaption,
//               margin: const EdgeInsets.symmetric(horizontal: 140),
//             ),
//             SpacerWidget.medium(),
//             TextWidget.heading2(context: context, 'Select Mode'),
//             SpacerWidget.large(),
//             ...ThemeMode.values.map(
//               (mode) => ListTile(
//                 onTap: () {
//                   context.pop();
//                   context.read<ThemeCubit>().setTheme(mode);
//                 },
//                 visualDensity: const VisualDensity(vertical: -2),
//                 contentPadding: EdgeInsets.zero,
//                 title: Text(capitalizeFirst(mode.name)),
//                 trailing: Radio<ThemeMode>(
//                   value: mode,
//                   groupValue: currentMode,
//                   onChanged: (val) {
//                     context.pop();
//                     context.read<ThemeCubit>().setTheme(val!);
//                   },
//                   activeColor: ColorConstant.primary,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void _showDeleteAccountDialog(BuildContext context) {
//     AppDialog.show(
//       context: context,
//       title: 'Delete Account',
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           IconWidget.large(
//             Platform.isIOS ? CupertinoIcons.delete : Icons.warning,
//             color: ColorConstant.red,
//           ),
//           SpacerWidget.medium(),
//           TextWidget.body(
//             'Are you sure you want to delete your account? This action cannot be undone.',
//             textAlign: TextAlign.center,
//             context: context,
//           ),
//           SpacerWidget.large(),
//           Row(
//             children: [
//               Expanded(
//                 child: ButtonWidget.text(
//                   context: context,
//                   label: 'Cancel',
//                   onPressed: () => context.pop(),
//                 ),
//               ),
//               SpacerWidget.widthMedium(),
//               Expanded(
//                 child: ButtonWidget.secondary(
//                   context: context,
//                   label: 'Delete',
//                   onPressed: () {
//                     context.pop();
//                     // Add actual delete logic
//                   },
//                   foregroundColor: ColorConstant.red,
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          print('ProfilePage - Builder: AuthState: $state');
          if (state is AuthSuccess) {
            final user = state.authResult.user;

            return CustomScrollView(
              physics: ClampingScrollPhysics(),
              scrollBehavior: ScrollBehavior().copyWith(overscroll: false),
              slivers: [
                // SliverAppBar(
                //   backgroundColor: ColorConstant.primaryColorLight,
                //   surfaceTintColor: ColorConstant.transparent,
                //   pinned: true,
                //   expandedHeight: ScreenUtil.screenHeight / 3,
                //   flexibleSpace: FlexibleSpaceBar(
                //     background: _buildProfileHeader(user, context),
                //   ),
                //   title: TextWidget.heading3(
                //     'Profile',
                //     context: context,
                //     color: ColorConstant.white,
                //   ),
                //   centerTitle: true,
                //   toolbarHeight: ScreenUtil.getResponsiveValue(
                //     smallPhone: kToolbarHeight - 4,
                //     mobile: kToolbarHeight,
                //     tablet: kToolbarHeight + 8,
                //     largeTablet: kToolbarHeight + 16,
                //   ),
                // ),
                CustomSliverAppBar(
                  title: 'Profile',
                  expandedHeight: ScreenUtil.screenHeight / 3,
                  flexibleSpace: FlexibleSpaceBar(
                    background: _buildProfileHeader(user, context),
                    //   expandedHeight: ScreenUtil.screenHeight / 3,
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: ScreenUtil.getAdaptivePadding(
                      horizontal: 24,
                      vertical: 24,
                    ),
                    child: Column(
                      children: [
                        state.authResult.user.roles.length != 1
                            ? Padding(
                                padding: ScreenUtil.getAdaptivePadding(),
                                child: GestureDetector(
                                  onTap: () {
                                    context.push(AppRoutes.roleSelecting);
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      IconWidget.medium(
                                        Icons.switch_account_outlined,
                                      ),
                                      SpacerWidget.widthMedium(),
                                      TextWidget.heading3(
                                        'Switch your role',
                                        context: context,
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : SizedBox.shrink(),
                        _buildCardSection(
                          context: context,
                          title: 'Account Settings',
                          children: _buildAccountSettingsList(context),
                        ),
                        BlocBuilder<ThemeCubit, ThemeMode>(
                          builder: (context, themeMode) {
                            return _buildCardSection(
                              context: context,
                              title: 'Appearance',
                              children: [
                                tileContent(
                                  icon: Icons.brightness_4_outlined,
                                  title: 'Theme Mode',
                                  subtitle:
                                      "Current: ${capitalizeFirst(themeMode.name)}",
                                  onTap: () =>
                                      _showThemeModeBottomSheet(context),
                                  isTrailing: true,
                                  context: context,
                                ),
                              ],
                            );
                          },
                        ),
                        _buildCardSection(
                          context: context,
                          title: 'Account Actions',
                          children: _buildAccountActionsList(context),
                        ),

                        SizedBox(
                          width: double.infinity,
                          child: ButtonWidget.secondary(
                            context: context,
                            label: 'Sign Out',
                            onPressed: () async {
                              AppDialog.showLogoutConfirmation(context);
                            },
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

          return const LoadingIndicator(color: Colors.yellow);
        },
      ),
    );
  }

  Widget _buildProfileHeader(User user, BuildContext context) {
    // Debug removed
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                ColorConstant.primaryColorLight.withOpacity(0.9),
                ColorConstant.primaryColorLight.withOpacity(0.7),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: ScreenUtil.getAdaptivePadding(),
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

  Widget _buildCardSection({
    required String title,
    required List<Widget> children,
    required BuildContext context,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWidget.heading3(title, context: context),
        SpacerWidget.medium(),
        Column(children: children.map((e) => e).toList()),
        SpacerWidget.xxlarge(),
      ],
    );
  }

  List<Widget> _buildAccountSettingsList(BuildContext context) {
    return [
      tileContent(
        icon: Platform.isIOS ? CupertinoIcons.person : Icons.person_outline,
        title: 'Edit Profile',
        subtitle: 'Update your personal info',
        onTap: () {},
        isTrailing: true,
        context: context,
      ),
      tileContent(
        icon: Platform.isIOS ? CupertinoIcons.mail : Icons.email_outlined,
        title: 'Change Email',
        subtitle: 'Update your email address',
        onTap: () {},
        isTrailing: true,
        context: context,
      ),
      tileContent(
        icon: Platform.isIOS ? CupertinoIcons.lock : Icons.lock_outline,
        title: 'Change Password',
        subtitle: 'Update your password',
        onTap: () {},
        isTrailing: true,
        context: context,
      ),
      tileContent(
        icon: Platform.isIOS
            ? CupertinoIcons.bell
            : Icons.notifications_outlined,
        title: 'Notifications',
        subtitle: 'Notification preferences',
        onTap: () {},
        isTrailing: true,
        context: context,
      ),
    ];
  }

  List<Widget> _buildAccountActionsList(BuildContext context) {
    return [
      tileContent(
        icon: Platform.isIOS
            ? CupertinoIcons.arrow_down_to_line
            : Icons.download_outlined,
        title: 'Export Data',
        subtitle: 'Download your information',
        onTap: () {},
        context: context,
      ),
      tileContent(
        icon: Platform.isIOS ? CupertinoIcons.delete : Icons.delete_outline,
        title: 'Delete Account',
        subtitle: 'Permanently delete this account',
        onTap: () => _showDeleteAccountDialog(context),
        isDestructive: true,
        context: context,
      ),
    ];
  }

  void _showThemeModeBottomSheet(BuildContext context) {
    final currentMode = context.read<ThemeCubit>().state;

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => Padding(
        padding: ScreenUtil.getAdaptivePadding(smallPhoneHorizontal: 20),
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
                title: Text(capitalizeFirst(mode.name)),
                activeColor: ColorConstant.primaryColorLight,
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
}
