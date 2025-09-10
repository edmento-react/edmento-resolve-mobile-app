import 'package:edmentoresolve/core/config/routing_transaction.dart';
import 'package:edmentoresolve/features/authentication/presentation/pages/auth_wrapper.dart';
import 'package:edmentoresolve/features/authentication/presentation/pages/forgot_password.dart';
import 'package:edmentoresolve/features/authentication/presentation/pages/login_page.dart';
import 'package:edmentoresolve/features/authentication/presentation/pages/new_password.dart';
import 'package:edmentoresolve/features/authentication/presentation/pages/otp_screen.dart';
import 'package:edmentoresolve/features/authentication/presentation/pages/role_selecting_page.dart';
import 'package:edmentoresolve/features/notifications/presentation/pages/notification_page.dart';
import 'package:edmentoresolve/features/profile/presentation/pages/profile_page.dart';
import 'package:edmentoresolve/features/settings/presentation/pages/settings_page.dart';
import 'package:edmentoresolve/features/shared/presentation/pages/index.dart';
import 'package:edmentoresolve/features/splash/presentation/pages/splash_screen.dart';
import 'package:edmentoresolve/features/user_roles/coordinator/presentation/pages/assignments_page.dart';
import 'package:edmentoresolve/features/user_roles/coordinator/presentation/pages/classes_page.dart';
import 'package:edmentoresolve/features/user_roles/coordinator/presentation/pages/dashboard_page.dart'
    as coordinator;
import 'package:edmentoresolve/features/user_roles/coordinator/presentation/pages/reports_page.dart';
import 'package:edmentoresolve/features/user_roles/office_admin/presentation/pages/dashboard_page.dart'
    as office;
import 'package:edmentoresolve/features/user_roles/office_admin/presentation/pages/leave_request_page.dart';
import 'package:edmentoresolve/features/user_roles/parent/presentation/pages/children_page.dart';
import 'package:edmentoresolve/features/user_roles/parent/presentation/pages/dashboard_page.dart'
    as parent;
import 'package:edmentoresolve/features/user_roles/parent/presentation/pages/grades_page.dart';
import 'package:edmentoresolve/features/user_roles/parent/presentation/pages/schedule_page.dart';
import 'package:edmentoresolve/features/user_roles/principal/presentation/pages/dashboard_page.dart'
    as principal;
import 'package:edmentoresolve/features/user_roles/principal/presentation/pages/reports_page.dart';
import 'package:edmentoresolve/features/user_roles/principal/presentation/pages/staff_page.dart';
import 'package:edmentoresolve/features/user_roles/principal/presentation/pages/students_page.dart';
import 'package:edmentoresolve/features/user_roles/student/presentation/pages/assignments_page.dart';
import 'package:edmentoresolve/features/user_roles/student/presentation/pages/dashboard_page.dart'
    as student;
import 'package:edmentoresolve/features/user_roles/student/presentation/pages/grades_page.dart';
import 'package:edmentoresolve/features/user_roles/student/presentation/pages/schedule_page.dart';
import 'package:edmentoresolve/features/user_roles/teacher/presentation/pages/classroom_page.dart';
import 'package:edmentoresolve/features/user_roles/teacher/presentation/pages/dashboard_page.dart'
    as teacher;
import 'package:edmentoresolve/features/user_roles/teacher/presentation/pages/home/announce_now_page.dart';
import 'package:edmentoresolve/features/user_roles/teacher/presentation/pages/home/mark_attendance_page.dart';
import 'package:edmentoresolve/features/user_roles/teacher/presentation/pages/home/view_report_page.dart';
import 'package:edmentoresolve/features/user_roles/teacher/presentation/pages/home/view_students_page.dart';
import 'package:edmentoresolve/features/user_roles/teacher/presentation/pages/timetable_page.dart';
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

  //Teacher
  static const String markAttendance = '/mark-attendance';
  static const String viewReport = '/view-report';
  static const String viewStudents = '/view-students';
  static const String announceNow = '/attendance-now';
  static const String teacherCommunication = '/teacher/communication';
  static const String teacherClassroom = '/teacher/classroom';
  static const String teacherTask = '/teacher/task';
  static const String teacherTimetable = '/teacher/timetable';

  // Student Routes
  static const String studentCommunication = '/student/communication';
  static const String studentTask = '/student/task';

  // Office Admin Routes
  static const String officeAdminCommunication = '/office-admin/communication';
  static const String officeAdminTask = '/office-admin/task';

  // Principal Routes
  static const String principalCommunication = '/principal/communication';
  static const String principalTask = '/principal/task';

  // Coordinator Routes
  static const String coordinatorCommunication = '/coordinator/communication';
  static const String coordinatorTask = '/coordinator/task';

  // Parent Routes
  static const String parentCommunication = '/parent/communication';
  static const String parentTask = '/parent/task';

  // Student Routes
  static const String studentAssignments = '/student/assignments';
  static const String studentGrades = '/student/grades';
  static const String studentSchedule = '/student/schedule';

  // Parent Routes
  static const String parentChildren = '/parent/children';
  static const String parentGrades = '/parent/grades';
  static const String parentSchedule = '/parent/schedule';

  // Principal Routes
  static const String principalStudents = '/principal/students';
  static const String principalStaff = '/principal/staff';
  static const String principalReports = '/principal/reports';

  // Coordinator Routes
  static const String coordinatorAssignments = '/coordinator/assignments';
  static const String coordinatorClasses = '/coordinator/classes';
  static const String coordinatorReports = '/coordinator/reports';

  // Office Admin Routes
  static const String officeAdminLeaveRequests = '/office-admin/leave-requests';

  // Compose Email Routes
  static const String composeEmail = '/compose-email';
  static const String composeEmailDraft = '/compose-email/draft';
  static const String composeEmailSchedule = '/compose-email/schedule';
  static const String composeEmailLeave = '/compose-email/leave';

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
                TransitionType.leftToRight,
                context,
                animation,
                secondaryAnimation,
                child,
              ),
        ),
      ),
      GoRoute(
        path: notifications,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const NotificationsPage(),
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
        path: announceNow,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const AnnounceNowPage(),
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
        path: viewStudents,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const ViewStudentsPage(),
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
        path: viewReport,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const ViewReportPage(),
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
        path: markAttendance,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const MarkAttendancePage(),
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
      // Compose Email Routes
      GoRoute(
        path: composeEmail,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: ComposeEmailProvider(mode: ComposeMode.compose),
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
        path: '$composeEmailDraft/:draftId',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: ComposeEmailProvider(
            draftId: state.pathParameters['draftId'],
            mode: ComposeMode.compose,
          ),
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
        path: composeEmailSchedule,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: ComposeEmailProvider(mode: ComposeMode.schedule),
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
        path: composeEmailLeave,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: ComposeEmailProvider(mode: ComposeMode.leave),
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
      // Student Sub-pages
      GoRoute(
        path: studentAssignments,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const StudentAssignmentsPage(),
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
        path: studentGrades,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const StudentGradesPage(),
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
        path: studentSchedule,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: SchedulePage(),
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
      // Teacher Sub-pages
      GoRoute(
        path: teacherCommunication,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const SharedCommunicationPage(),
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
        path: teacherClassroom,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const ClassroomPage(),
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
        path: teacherTask,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const SharedTaskPage(),
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
        path: teacherTimetable,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const TeacherClassesPage(),
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

      // Student Sub-pages
      GoRoute(
        path: studentCommunication,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const SharedCommunicationPage(),
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
        path: studentTask,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const SharedTaskPage(),
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

      // Office Admin Sub-pages
      GoRoute(
        path: officeAdminCommunication,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const SharedCommunicationPage(),
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
        path: officeAdminTask,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const SharedTaskPage(),
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

      // Principal Sub-pages
      GoRoute(
        path: principalCommunication,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const SharedCommunicationPage(),
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
        path: principalTask,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const SharedTaskPage(),
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

      // Coordinator Sub-pages
      GoRoute(
        path: coordinatorCommunication,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const SharedCommunicationPage(),
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
        path: coordinatorTask,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const SharedTaskPage(),
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

      // Parent Sub-pages
      GoRoute(
        path: parentChildren,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const ParentChildrenPage(),
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
        path: parentGrades,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const ParentGradesPage(),
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
        path: parentSchedule,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const ParentSchedulePage(),
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
        path: parentCommunication,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const SharedCommunicationPage(),
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
        path: parentTask,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const SharedTaskPage(),
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
      // Principal Sub-pages
      GoRoute(
        path: principalStudents,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const PrincipalStudentsPage(),
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
        path: principalStaff,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const PrincipalStaffPage(),
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
        path: principalReports,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const PrincipalReportsPage(),
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
      // Coordinator Sub-pages
      GoRoute(
        path: coordinatorAssignments,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const CoordinatorAssignmentsPage(),
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
        path: coordinatorClasses,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const CoordinatorClassesPage(),
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
        path: coordinatorReports,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const CoordinatorReportsPage(),
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
      // Office Admin Sub-pages
      GoRoute(
        path: officeAdminLeaveRequests,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const LeaveRequestPage(),
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
