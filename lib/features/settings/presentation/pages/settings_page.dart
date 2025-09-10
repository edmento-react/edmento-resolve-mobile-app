import 'dart:io';

import 'package:edmentoresolve/core/constants/color_constant.dart';
import 'package:edmentoresolve/core/widgets/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

// Settings State
class SettingsState {
  final bool notificationsEnabled;
  final bool darkModeEnabled;
  final bool biometricEnabled;
  final String selectedLanguage;
  final String selectedTheme;

  SettingsState({
    this.notificationsEnabled = true,
    this.darkModeEnabled = false,
    this.biometricEnabled = false,
    this.selectedLanguage = 'English',
    this.selectedTheme = 'System',
  });

  SettingsState copyWith({
    bool? notificationsEnabled,
    bool? darkModeEnabled,
    bool? biometricEnabled,
    String? selectedLanguage,
    String? selectedTheme,
  }) {
    return SettingsState(
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      darkModeEnabled: darkModeEnabled ?? this.darkModeEnabled,
      biometricEnabled: biometricEnabled ?? this.biometricEnabled,
      selectedLanguage: selectedLanguage ?? this.selectedLanguage,
      selectedTheme: selectedTheme ?? this.selectedTheme,
    );
  }
}

// Settings Cubit
class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(SettingsState());

  void setNotificationsEnabled(bool value) =>
      emit(state.copyWith(notificationsEnabled: value));
  void setDarkModeEnabled(bool value) =>
      emit(state.copyWith(darkModeEnabled: value));
  void setBiometricEnabled(bool value) =>
      emit(state.copyWith(biometricEnabled: value));
  void setSelectedLanguage(String value) =>
      emit(state.copyWith(selectedLanguage: value));
  void setSelectedTheme(String value) =>
      emit(state.copyWith(selectedTheme: value));
  void resetSettings() => emit(SettingsState());
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SettingsCubit(),
      child: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBarWidget(
              title: 'Settings',
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => context.pop(),
              ),
            ),
            body: ListView(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
              children: [
                SwitchListTile(
                  title: TextWidget.body(
                    'Enable Notifications',
                    context: context,
                  ),
                  value: state.notificationsEnabled,
                  onChanged: (value) => context
                      .read<SettingsCubit>()
                      .setNotificationsEnabled(value),
                ),
                SwitchListTile(
                  title: TextWidget.body('Enable Dark Mode', context: context),
                  value: state.darkModeEnabled,
                  onChanged: (value) =>
                      context.read<SettingsCubit>().setDarkModeEnabled(value),
                ),
                SwitchListTile(
                  title: TextWidget.body('Enable Biometric', context: context),
                  value: state.biometricEnabled,
                  onChanged: (value) =>
                      context.read<SettingsCubit>().setBiometricEnabled(value),
                ),
                ListTile(
                  title: TextWidget.body('Language', context: context),
                  trailing: DropdownButton<String>(
                    value: state.selectedLanguage,
                    items: ['English', 'Hindi', 'Spanish']
                        .map(
                          (lang) => DropdownMenuItem(
                            value: lang,
                            child: TextWidget.body(lang, context: context),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      if (value != null) {
                        context.read<SettingsCubit>().setSelectedLanguage(
                          value,
                        );
                      }
                    },
                  ),
                ),
                ListTile(
                  title: TextWidget.body('Theme', context: context),
                  trailing: DropdownButton<String>(
                    value: state.selectedTheme,
                    items: ['System', 'Light', 'Dark']
                        .map(
                          (theme) => DropdownMenuItem(
                            value: theme,
                            child: TextWidget.body(theme, context: context),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      if (value != null) {
                        context.read<SettingsCubit>().setSelectedTheme(value);
                      }
                    },
                  ),
                ),
                SpacerWidget.large(),
                ButtonWidget.secondary(
                  context: context,
                  label: 'Reset Settings',
                  onPressed: () {
                    context.read<SettingsCubit>().resetSettings();
                    GlobalSnackbar.success(
                      context: context,
                      message: 'Settings reset successfully',
                    );
                  },
                  foregroundColor: ColorConstant.orange,
                ),
                SpacerWidget.large(),
                ButtonWidget.secondary(
                  context: context,
                  label: 'About',
                  onPressed: () => _showAboutDialog(context),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showAboutDialog(BuildContext context) {
    AppDialog.show(
      context: context,
      title: 'About',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconWidget.large(
            Platform.isIOS ? CupertinoIcons.info : Icons.info_outline,
          ),
          SpacerWidget.medium(),
          TextWidget.heading3('EdmentoResolve', context: context),
          SpacerWidget.small(),
          TextWidget.body('Version 1.0.0', context: context),
          SpacerWidget.medium(),
          TextWidget.caption(
            'A comprehensive educational platform designed to help students and educators achieve their goals.',
            textAlign: TextAlign.center,
            context: context,
          ),
          SpacerWidget.large(),
          ButtonWidget.secondary(
            context: context,
            label: 'Close',
            onPressed: () => context.pop(),
          ),
        ],
      ),
    );
  }
}
