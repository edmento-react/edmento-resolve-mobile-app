import 'package:edmentoresolve/core/constants/routing_transaction.dart';
import 'package:edmentoresolve/features/authentication/presentation/pages/auth_wrapper.dart';
import 'package:edmentoresolve/features/authentication/presentation/pages/forgot_password.dart';
import 'package:edmentoresolve/features/authentication/presentation/pages/login_page.dart';
import 'package:edmentoresolve/features/authentication/presentation/pages/new_password.dart';
import 'package:edmentoresolve/features/authentication/presentation/pages/otp_screen.dart';
import 'package:edmentoresolve/features/authentication/presentation/pages/role_selecting_page.dart';
import 'package:edmentoresolve/features/coordinator/presentation/pages/dashboard_page.dart'
    as coordinator;
import 'package:edmentoresolve/features/office_admin/presentation/pages/dashboard_page.dart'
    as office;
import 'package:edmentoresolve/features/parent/presentation/pages/dashboard_page.dart'
    as parent;
import 'package:edmentoresolve/features/principal/presentation/pages/dashboard_page.dart'
    as principal;
import 'package:edmentoresolve/features/profile/presentation/pages/profile_page.dart';
import 'package:edmentoresolve/features/settings/presentation/pages/settings_page.dart';
import 'package:edmentoresolve/features/splash/presentation/pages/splash_screen.dart';
import 'package:edmentoresolve/features/student/presentation/pages/dashboard_page.dart'
    as student;
import 'package:edmentoresolve/features/student/presentation/pages/schedule_page.dart';
import 'package:edmentoresolve/features/teacher/presentation/pages/dashboard_page.dart'
    as teacher;
import 'package:go_router/go_router.dart';

class AppRoutes {
  // Initial Route
  static const String initial = '/';

  // Authentication Routes
  static const String login = '/login';
  static const String forgotPassword = '/forgot-password';
  static const String otpScreen = '/otp-screen';
  static const String newPassword = '/new-password';
  static const String roleSelecting = '/role-selecting';
  static const String authWrapper = '/auth-wrapper';

  // Main App Routes
  static const String home = '/home';
  static const String profile = '/profile';
  static const String setting = '/settings';
  static const String schedule = '/schedule';

  // Feature Routes
  static const String notifications = '/notifications';

  // Role-specific Dashboard Routes
  static const String principalDashboard = '/principal-dashboard';
  static const String coordinatorDashboard = '/coordinator-dashboard';
  static const String teacherDashboard = '/teacher-dashboard';
  static const String parentDashboard = '/parent-dashboard';
  static const String studentDashboard = '/student-dashboard';
  static const String officeAdminDashboard = '/office-admin-dashboard';

  // Error Routes
  static const String error = '/error';
  static const String notFound = '/not-found';

  /// go_router configuration with custom transition on every route
  static final GoRouter router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: initial,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const SplashPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              getTransitionByType(
                TransitionType.rightToLeft,
                context,
                animation,
                secondaryAnimation,
                child,
              ),
        ),
      ),
      GoRoute(
        path: login,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const LoginPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              getTransitionByType(
                TransitionType.rightToLeft,
                context,
                animation,
                secondaryAnimation,
                child,
              ),
        ),
      ),
      GoRoute(
        path: authWrapper,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const AuthWrapper(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              getTransitionByType(
                TransitionType.fade,
                context,
                animation,
                secondaryAnimation,
                child,
              ),
        ),
      ),
      GoRoute(
        path: forgotPassword,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const ForgotPasswordPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              getTransitionByType(
                TransitionType.rightToLeft,
                context,
                animation,
                secondaryAnimation,
                child,
              ),
        ),
      ),
      GoRoute(
        path: roleSelecting,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: RoleSelectingPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              getTransitionByType(
                TransitionType.rightToLeft,
                context,
                animation,
                secondaryAnimation,
                child,
              ),
        ),
      ),
      GoRoute(
        path: otpScreen,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: OtpPage(email: state.extra as String),
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              getTransitionByType(
                TransitionType.rightToLeft,
                context,
                animation,
                secondaryAnimation,
                child,
              ),
        ),
      ),
      GoRoute(
        path: newPassword,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: NewPasswordPage(email: state.extra as String),
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              getTransitionByType(
                TransitionType.rightToLeft,
                context,
                animation,
                secondaryAnimation,
                child,
              ),
        ),
      ),
      GoRoute(
        path: profile,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const ProfilePage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              getTransitionByType(
                TransitionType.rightToLeft,
                context,
                animation,
                secondaryAnimation,
                child,
              ),
        ),
      ),
      GoRoute(
        path: setting,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const SettingsPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              getTransitionByType(
                TransitionType.rightToLeft,
                context,
                animation,
                secondaryAnimation,
                child,
              ),
        ),
      ),
      GoRoute(
        path: schedule,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: SchedulePage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              getTransitionByType(
                TransitionType
                    .bottomToTop, // example of custom transition on schedule page
                context,
                animation,
                secondaryAnimation,
                child,
              ),
        ),
      ),
      // Role-specific dashboards
      GoRoute(
        path: principalDashboard,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const principal.PrincipalDashboardPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              getTransitionByType(
                TransitionType.rightToLeft,
                context,
                animation,
                secondaryAnimation,
                child,
              ),
        ),
      ),
      GoRoute(
        path: coordinatorDashboard,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const coordinator.CoordinatorDashboardPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              getTransitionByType(
                TransitionType.rightToLeft,
                context,
                animation,
                secondaryAnimation,
                child,
              ),
        ),
      ),
      GoRoute(
        path: teacherDashboard,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const teacher.TeacherDashboardPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              getTransitionByType(
                TransitionType.rightToLeft,
                context,
                animation,
                secondaryAnimation,
                child,
              ),
        ),
      ),
      GoRoute(
        path: parentDashboard,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const parent.ParentDashboardPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              getTransitionByType(
                TransitionType.rightToLeft,
                context,
                animation,
                secondaryAnimation,
                child,
              ),
        ),
      ),
      GoRoute(
        path: studentDashboard,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const student.StudentDashboardPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              getTransitionByType(
                TransitionType.rightToLeft,
                context,
                animation,
                secondaryAnimation,
                child,
              ),
        ),
      ),
      GoRoute(
        path: officeAdminDashboard,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const office.OfficeAdminDashboardPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              getTransitionByType(
                TransitionType.rightToLeft,
                context,
                animation,
                secondaryAnimation,
                child,
              ),
        ),
      ),
    ],
  );
}
