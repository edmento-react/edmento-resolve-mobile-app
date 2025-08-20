import 'dart:async';

import 'package:edmentoresolve/core/utils/storage_util.dart';
import 'package:edmentoresolve/features/authentication/presentation/bloc/role_cubit.dart';
import 'package:edmentoresolve/features/profile/presentation/bloc/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rive/rive.dart';

import 'core/constants/app_constants.dart';
import 'core/constants/color_constant.dart';
import 'core/constants/routes.dart';
import 'core/di/injection_container.dart' as di;
import 'core/utils/performance_utils.dart';
import 'core/utils/screen_util.dart';
import 'features/authentication/presentation/bloc/auth_bloc.dart';
import 'features/authentication/presentation/bloc/login_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize global performance tweaks early
  PerformanceUtils.initialize();
  unawaited(RiveFile.initialize());
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: ColorConstant.transparent, // Transparent status bar
      statusBarBrightness: Brightness.dark, // Dark text for status bar
    ),
  );
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (_) => di.sl<AuthBloc>()),
        BlocProvider<RoleResolverCubit>(
          create: (_) => di.sl<RoleResolverCubit>(),
        ),
        BlocProvider<LoginCubit>(create: (context) => di.sl<LoginCubit>()),
        BlocProvider<ThemeCubit>(
          create: (_) => ThemeCubit(di.sl<StorageService>()),
        ), // Provide ThemeCubit globally

        BlocProvider<RoleResolverCubit>(
          create: (_) => di.sl<RoleResolverCubit>(),
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: AppConstants.appName,
            builder: (context, child) {
              // Initialize ScreenUtil with a context that has MediaQuery
              ScreenUtil.init(context);
              return child ?? const SizedBox.shrink();
            },
            routerConfig: AppRoutes.router,
            theme: ThemeData(
              scaffoldBackgroundColor:
                  ColorConstant.scaffoldBackgroundColorLight,
              colorScheme: ColorScheme.fromSeed(
                seedColor: ColorConstant.primaryColorLight,
              ),
              useMaterial3: true,
              fontFamily: 'Manrope',
              appBarTheme: const AppBarTheme(
                backgroundColor: ColorConstant.primaryColorLight,
                foregroundColor: ColorConstant.white,
                elevation: 0,
              ),
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorConstant.primaryColorLight,
                  foregroundColor: ColorConstant.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            darkTheme: ThemeData(
              brightness: Brightness.dark,
              scaffoldBackgroundColor:
                  ColorConstant.scaffoldBackgroundColorDark,
              // colorScheme: ColorScheme.fromSeed(
              //   seedColor: ColorConstant.primaryColorDark,
              //   brightness: Brightness.dark,
              // ),
              useMaterial3: true,
              fontFamily: 'Manrope',
              appBarTheme: const AppBarTheme(
                backgroundColor: ColorConstant.primaryColorDark,
                foregroundColor: ColorConstant.white,
                elevation: 0,
              ),
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorConstant.primaryColorDark,
                  foregroundColor: ColorConstant.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            themeMode: themeMode, // Use ThemeCubit state
          );
        },
      ),
    );
  }
}
