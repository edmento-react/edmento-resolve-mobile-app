// import 'dart:async';

// import 'package:edmentoresolve/core/utils/storage_util.dart';
// import 'package:edmentoresolve/features/authentication/presentation/bloc/role_cubit.dart';
// import 'package:edmentoresolve/features/profile/presentation/bloc/theme_cubit.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:rive/rive.dart';

// import 'core/constants/app_constants.dart';
// import 'core/constants/color_constant.dart';
// import 'core/constants/routes.dart';
// import 'core/di/injection_container.dart' as di;
// import 'core/utils/performance_utils.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'features/authentication/presentation/bloc/auth_bloc.dart';
// import 'features/authentication/presentation/bloc/login_cubit.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   // Initialize global performance tweaks early
//   PerformanceUtils.initialize();
//   unawaited(RiveFile.initialize());
//   SystemChrome.setSystemUIOverlayStyle(
//     SystemUiOverlayStyle(
//       statusBarColor: ColorConstant.transparent, // Transparent status bar
//       statusBarBrightness: Brightness.dark, // Dark text for status bar
//     ),
//   );
//   await di.init();
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocProvider(
//       providers: [
//         BlocProvider<AuthBloc>(create: (_) => di.sl<AuthBloc>()),
//         BlocProvider<RoleResolverCubit>(
//           create: (_) => di.sl<RoleResolverCubit>(),
//         ),
//         BlocProvider<LoginCubit>(create: (context) => di.sl<LoginCubit>()),
//         BlocProvider<ThemeCubit>(
//           create: (_) => ThemeCubit(di.sl<StorageService>()),
//         ), // Provide ThemeCubit globally

//         BlocProvider<RoleResolverCubit>(
//           create: (_) => di.sl<RoleResolverCubit>(),
//         ),
//       ],
//       child: BlocBuilder<ThemeCubit, ThemeMode>(
//         builder: (context, themeMode) {
//           return MaterialApp.router(
//             debugShowCheckedModeBanner: false,
//             title: AppConstants.appName,
//             builder: (context, child) {
//               // Initialize ScreenUtil with a context that has MediaQuery
//               ScreenUtil.init(context);
//               return child ?? const SizedBox.shrink();
//             },
//             routerConfig: AppRoutes.router,
//             theme: ThemeData(
//               scaffoldBackgroundColor:
//                   ColorConstant.scaffoldBackgroundLight,
//               colorScheme: ColorScheme.fromSeed(
//                 seedColor: ColorConstant.primaryLight,
//               ),
//               useMaterial3: true,
//               fontFamily: 'Manrope',
//               appBarTheme: const AppBarTheme(
//                 backgroundColor: ColorConstant.primaryLight,
//                 foregroundColor: ColorConstant.white,
//                 elevation: 0,
//               ),
//               elevatedButtonTheme: ElevatedButtonThemeData(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: ColorConstant.primaryLight,
//                   foregroundColor: ColorConstant.white,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//               ),
//             ),
//             darkTheme: ThemeData(
//               brightness: Brightness.dark,
//               scaffoldBackgroundColor:
//                   ColorConstant.scaffoldBackgroundDark,
//               // colorScheme: ColorScheme.fromSeed(
//               //   seedColor: ColorConstant.primaryDark,
//               //   brightness: Brightness.dark,
//               // ),
//               useMaterial3: true,
//               fontFamily: 'Manrope',
//               appBarTheme: const AppBarTheme(
//                 backgroundColor: ColorConstant.primaryDark,
//                 foregroundColor: ColorConstant.white,
//                 elevation: 0,
//               ),
//               elevatedButtonTheme: ElevatedButtonThemeData(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: ColorConstant.primaryDark,
//                   foregroundColor: ColorConstant.white,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//               ),
//             ),
//             themeMode: themeMode, // Use ThemeCubit state
//           );
//         },
//       ),
//     );
//   }
// }
import 'dart:async';

import 'package:edmentoresolve/core/constants/style_constant.dart';
import 'package:edmentoresolve/core/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rive/rive.dart';

import 'core/constants/app_constants.dart';
import 'core/constants/color_constant.dart';
import 'core/constants/routes.dart';
import 'core/di/injection_container.dart' as di;
import 'core/security/security_cubit.dart';
import 'core/utils/performance_utils.dart';
import 'core/utils/storage_util.dart';
import 'features/authentication/presentation/bloc/auth_bloc.dart';
import 'features/authentication/presentation/bloc/login_cubit.dart';
import 'features/authentication/presentation/bloc/role_cubit.dart';
import 'features/common/presentation/cubit/theme_cubit.dart';

final GlobalKey<NavigatorState> _navKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  // Keep everything inside one zone
  await runZonedGuarded<Future<void>>(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      void logThreat(String name) => print('[TALSEC] $name detected');

      // Early perf + UI setup
      PerformanceUtils.initialize();
      unawaited(RiveFile.initialize());
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarColor: ColorConstant.transparent,
          statusBarBrightness: Brightness.dark,
        ),
      );

      // DI first so we can resolve blocs/cubits
      await di.init();

      // --- Security (freeRASP/Talsec) setup ---
      // final securityCubit = SecurityCubit();
      // final threatCallback = ThreatCallback(
      //   onAppIntegrity: () {
      //     logThreat('APP_INTEGRITY');
      //     securityCubit.add(SecurityThreat.appIntegrity);
      //   },
      //   onObfuscationIssues: () {
      //     logThreat('OBFUSCATION_ISSUES');
      //     securityCubit.add(SecurityThreat.obfuscationIssues);
      //   },
      //   onDebug: () {
      //     logThreat('DEBUGGER_ATTACHED');
      //     securityCubit.add(SecurityThreat.debug);
      //   },
      //   onDeviceBinding: () {
      //     logThreat('DEVICE_BINDING');
      //     securityCubit.add(SecurityThreat.deviceBinding);
      //   },
      //   onDeviceID: () {
      //     logThreat('DEVICE_ID');
      //     securityCubit.add(SecurityThreat.deviceId);
      //   },
      //   onHooks: () {
      //     logThreat('HOOKS');
      //     securityCubit.add(SecurityThreat.hooks);
      //   },
      //   onPasscode: () {
      //     logThreat('PASSCODE_MISSING');
      //     securityCubit.add(SecurityThreat.passcodeMissing);
      //   },
      //   onPrivilegedAccess: () {
      //     logThreat('ROOT/JAILBREAK');
      //     securityCubit.add(SecurityThreat.privilegedAccess);
      //   },
      //   onSecureHardwareNotAvailable: () {
      //     logThreat('NO_SECURE_HARDWARE');
      //     securityCubit.add(SecurityThreat.noSecureHardware);
      //   },
      //   onSimulator: () {
      //     logThreat('EMULATOR/SIMULATOR');
      //     securityCubit.add(SecurityThreat.emulatorOrSimulator);
      //   },
      //   onSystemVPN: () {
      //     logThreat('SYSTEM_VPN');
      //     securityCubit.add(SecurityThreat.systemVpn);
      //   },
      //   onDevMode: () {
      //     logThreat('DEV_MODE');
      //     securityCubit.add(SecurityThreat.devMode);
      //   },
      //   onADBEnabled: () {
      //     logThreat('ADB_ENABLED');
      //     securityCubit.add(SecurityThreat.adbEnabled);
      //   },
      //   onUnofficialStore: () {
      //     logThreat('UNOFFICIAL_STORE');
      //     securityCubit.add(SecurityThreat.unofficialStore);
      //   },
      //   onScreenshot: () {
      //     logThreat('SCREENSHOT');
      //     securityCubit.add(SecurityThreat.screenshot);
      //   },
      //   onScreenRecording: () {
      //     logThreat('SCREEN_RECORDING');
      //     securityCubit.add(SecurityThreat.screenRecording);
      //   },
      //   onMultiInstance: () {
      //     logThreat('MULTI_INSTANCE');
      //     securityCubit.add(SecurityThreat.multiInstance);
      //   },
      // );

      // final talsecConfig = TalsecConfig(
      //   androidConfig: AndroidConfig(
      //     packageName: 'com.example.edmento_resolve_new', // TODO
      //     signingCertHashes: const [
      //       'Sr/3ymv1jlL7u90I1TncnZ0mjZ5I5aofqij/K2O2GFY=', // TODO: add Base64 SHA-256 of your **release** cert(s)
      //     ],
      //     supportedStores: const ['com.android.vending'],
      //   ),
      //   iosConfig: IOSConfig(
      //     bundleIds: const ['com.example.edmento_resolve_new'], // TODO
      //     teamId: 'YOUR_TEAM_ID', // TODO
      //   ),
      //   watcherMail: 'security@yourdomain.com',
      //   isProd: kReleaseMode ? true : false,
      // );

      // Talsec.instance.attachListener(threatCallback);
      // await Talsec.instance.start(talsecConfig);
      // // Optionally: await Talsec.instance.blockScreenCapture(enabled: true);

      // --- Run the real app with ALL providers at the root ---
      runApp(
        MultiBlocProvider(
          providers: [
            // Security
            // BlocProvider<SecurityCubit>.value(value: securityCubit),

            // Auth stack
            BlocProvider<AuthBloc>(create: (_) => di.sl<AuthBloc>()),
            BlocProvider<RoleResolverCubit>(
              create: (_) => di.sl<RoleResolverCubit>(),
            ),
            BlocProvider<LoginCubit>(create: (_) => di.sl<LoginCubit>()),

            // Theme
            BlocProvider<ThemeCubit>(
              create: (_) => ThemeCubit(di.sl<StorageService>()),
            ),
          ],
          child: const _RootApp(),
        ),
      );
    },
    (error, stack) {
      debugPrint('Uncaught zone error: $error');
    },
  );
}

class _RootApp extends StatelessWidget {
  const _RootApp();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, themeMode) {
        return ScreenUtilInit(
          designSize: const Size(375, 812), // ✅ baseline (Figma/iPhone X)
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (_, __) {
            return MaterialApp.router(
              // navigatorKey: _navKey, // used for global dialogs
              debugShowCheckedModeBanner: false,
              title: AppConstants.appName,
              builder: (context, child) {
                // ScreenUtil needs a context with MediaQuery
                // ScreenUtil.init(context);
                // Global dim overlay when any security threat is active
                return Stack(
                  fit: StackFit.expand,
                  children: [
                    child ?? const SizedBox.shrink(),
                    // BlocBuilder<SecurityCubit, SecurityState>(
                    //   buildWhen: (p, c) => p.active != c.active,
                    //   builder: (context, state) {
                    //     final hasThreat = state.active.isNotEmpty;
                    //     return IgnorePointer(
                    //       ignoring: !hasThreat,
                    //       child: AnimatedOpacity(
                    //         opacity: hasThreat ? 1.0 : 0.0,
                    //         duration: const Duration(milliseconds: 250),
                    //         child: Container(color: Colors.black.withOpacity(0.35)),
                    //       ),
                    //     );
                    //   },
                    // ),
                    // // One-time severe threat dialog trigger
                    // _SecurityDialogListener(navKey: _navKey),
                  ],
                );
              },
              routerConfig: AppRoutes.router, // your GoRouter
              themeMode: themeMode,
              theme: _buildLightTheme(context),
              darkTheme: _buildDarkTheme(context),
            );
          },
        );
      },
    );
  }

  // ----------------------
  // TEXT THEME HELPER
  // ----------------------
  TextTheme _appTextTheme(
    ColorScheme cs, {
    required bool dark,
    required BuildContext context,
  }) {
    final base = dark
        ? Typography.whiteMountainView
        : Typography.blackMountainView;
    return base.copyWith(
      displayLarge: StyleConstant.heading1(context), // H1
      displayMedium: StyleConstant.heading2(context), // H2
      displaySmall: StyleConstant.heading3(context), // H3
      titleLarge: StyleConstant.heading4(context), // H4
      titleMedium: StyleConstant.heading3(context), // H3
      bodyLarge: StyleConstant.body(context), // Body
      bodyMedium: StyleConstant.caption(
        context,
      ), // "Small" text (you used bodyMedium as fallback color)
      bodySmall: StyleConstant.caption(context), // Caption
      labelLarge: StyleConstant.caption(context), // Label
      labelSmall: StyleConstant.small(
        context,
      ), // Also map small to labelSmall for convenience
    );
  }

  // ----------------------
  // THEMES
  // ----------------------
  ThemeData _buildLightTheme(BuildContext context) {
    final base = ColorScheme.fromSeed(
      seedColor: ColorConstant.primaryLight,
      brightness: Brightness.light,
    );

    final cs = base.copyWith(
      primary: ColorConstant.primaryLight,
      secondary: ColorConstant.secondaryLight,
      surface: ColorConstant.surfaceLight,
      onSurface: ColorConstant.textPrimaryLight,
      error: ColorConstant.errorLight,
      outlineVariant: ColorConstant.dividerLight,
      outline: ColorConstant.cardBorderLight,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      fontFamily: 'Manrope',
      colorScheme: cs,
      scaffoldBackgroundColor: ColorConstant.scaffoldLight,
      cardColor: ColorConstant.cardLight,

      // ← your StyleConstant mapped here
      textTheme: _appTextTheme(cs, dark: false, context: context),

      dividerTheme: DividerThemeData(color: cs.outlineVariant, thickness: 1),

      appBarTheme: AppBarTheme(
        backgroundColor: cs.surface,
        foregroundColor: cs.onSurface,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        centerTitle: false,
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: cs.primary,
          foregroundColor: ColorConstant.white,
          disabledBackgroundColor: ColorConstant.grey300,
          disabledForegroundColor: ColorConstant.grey600,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: cs.primary,
          side: BorderSide(color: cs.primary),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: cs.primary),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: cs.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: cs.outlineVariant),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: cs.outlineVariant),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: cs.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: cs.error, width: 1.5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: cs.error, width: 2),
        ),
        labelStyle: TextStyle(color: ColorConstant.textLabelLight),
        hintStyle: TextStyle(color: ColorConstant.textCaptionLight),
      ),

      // Note: it's CardTheme (not CardThemeData)
      cardTheme: CardThemeData(
        color: ColorConstant.cardLight,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: cs.outlineVariant),
        ),
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        surfaceTintColor: Colors.transparent,
      ),
    );
  }

  ThemeData _buildDarkTheme(BuildContext context) {
    final base = ColorScheme.fromSeed(
      seedColor: ColorConstant.primaryLight, // keep brand hue consistent
      brightness: Brightness.dark,
    );

    final cs = base.copyWith(
      primary: ColorConstant.primaryDark, // your emerald if desired
      secondary: ColorConstant.secondaryDark,
      surface: ColorConstant.surfaceDark,
      onSurface: ColorConstant.textPrimaryDark,
      error: ColorConstant.errorDark,
      outlineVariant: ColorConstant.dividerDark,
      outline: ColorConstant.cardBorderDark,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      fontFamily: 'Manrope',
      colorScheme: cs,
      scaffoldBackgroundColor: ColorConstant.scaffoldDark,
      cardColor: ColorConstant.cardDark,

      // ← your StyleConstant mapped here
      textTheme: _appTextTheme(cs, dark: true, context: context),

      dividerTheme: DividerThemeData(color: cs.outlineVariant, thickness: 1),

      appBarTheme: AppBarTheme(
        backgroundColor: cs.surface,
        foregroundColor: cs.onSurface,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        centerTitle: false,
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: cs.primary,
          foregroundColor: ColorConstant.white,
          disabledBackgroundColor: ColorConstant.grey700,
          disabledForegroundColor: ColorConstant.grey500,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: cs.primary,
          side: BorderSide(color: cs.primary),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: cs.primary),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: cs.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: cs.outlineVariant),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: cs.outlineVariant),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: cs.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: cs.error, width: 1.5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: cs.error, width: 2),
        ),
        labelStyle: TextStyle(color: ColorConstant.textLabelDark),
        hintStyle: TextStyle(color: ColorConstant.textCaptionDark),
      ),

      cardTheme: CardThemeData(
        color: ColorConstant.cardDark,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: cs.outlineVariant),
        ),
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        surfaceTintColor: Colors.transparent,
      ),
    );
  }
}

/// Listens for severe threats and shows a single dialog.
class _SecurityDialogListener extends StatefulWidget {
  const _SecurityDialogListener({required this.navKey});
  final GlobalKey<NavigatorState> navKey;

  @override
  State<_SecurityDialogListener> createState() =>
      _SecurityDialogListenerState();
}

class _SecurityDialogListenerState extends State<_SecurityDialogListener> {
  bool _dialogShowing = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<SecurityCubit, SecurityState>(
      listenWhen: (p, c) => p.active != c.active,
      listener: (context, state) async {
        final severe = _firstSevere(state);
        if (severe == null || _dialogShowing) return;

        _dialogShowing = true;
        final ctx = widget.navKey.currentContext ?? context;

        await showDialog<void>(
          context: ctx,
          barrierDismissible: false,
          barrierColor: Colors.black54,
          builder: (context) => AlertDialog(
            title: TextWidget.heading3('Security Alert', context: ctx),
            content: TextWidget.body(_msg(severe), context: ctx),
            actions: [
              TextButton(
                onPressed: () {
                  context.read<SecurityCubit>().clear(severe);
                  Navigator.of(context).pop();
                  _dialogShowing = false;
                },
                child: TextWidget.label('OK', context: ctx),
              ),
            ],
          ),
        );
      },
      child: const SizedBox.shrink(),
    );
  }

  SecurityThreat? _firstSevere(SecurityState s) {
    const severeSet = {
      SecurityThreat.privilegedAccess,
      SecurityThreat.hooks,
      SecurityThreat.appIntegrity,
    };
    for (final t in s.active) {
      if (severeSet.contains(t)) return t;
    }
    return null;
  }

  String _msg(SecurityThreat t) {
    switch (t) {
      case SecurityThreat.privilegedAccess:
        return 'Root/Jailbreak or elevated access detected. For safety, access is restricted.';
      case SecurityThreat.hooks:
        return 'Hooking/Instrumentation detected (e.g., Frida/Xposed). App cannot continue safely.';
      case SecurityThreat.appIntegrity:
        return 'App integrity failed (tamper or repackaging).';
      default:
        return 'Security anomaly detected.';
    }
  }
}
