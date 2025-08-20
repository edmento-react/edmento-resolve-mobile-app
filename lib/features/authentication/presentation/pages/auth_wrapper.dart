import 'package:edmentoresolve/core/constants/app_constants.dart';
import 'package:edmentoresolve/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:edmentoresolve/features/authentication/presentation/bloc/role_cubit.dart';
import 'package:edmentoresolve/features/authentication/presentation/pages/login_page.dart';
import 'package:edmentoresolve/features/authentication/presentation/pages/new_password.dart';
import 'package:edmentoresolve/features/authentication/presentation/pages/role_selecting_page.dart';
import 'package:edmentoresolve/features/coordinator/presentation/pages/dashboard_page.dart'
    as coordinator;
import 'package:edmentoresolve/features/office_admin/presentation/pages/dashboard_page.dart'
    as office;
import 'package:edmentoresolve/features/parent/presentation/pages/dashboard_page.dart'
    as parent;
import 'package:edmentoresolve/features/principal/presentation/pages/dashboard_page.dart'
    as principal;
import 'package:edmentoresolve/features/student/presentation/pages/dashboard_page.dart'
    as student;
import 'package:edmentoresolve/features/teacher/presentation/pages/dashboard_page.dart'
    as teacher;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  bool _bootstrapped = false;

  Widget _pageForRole(int roleId) {
    switch (roleId) {
      case UserRoles.principal:
      case UserRoles.vicePrincipal:
        return const principal.PrincipalDashboardPage();
      case UserRoles.coordinator:
        return const coordinator.CoordinatorDashboardPage();
      case UserRoles.teacher:
        return const teacher.TeacherDashboardPage();
      case UserRoles.officeAdmin:
        return const office.OfficeAdminDashboardPage();
      case UserRoles.parent:
        return const parent.ParentDashboardPage();
      case UserRoles.student:
      default:
        return const student.StudentDashboardPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listenWhen: (prev, curr) => prev is! AuthSuccess && curr is AuthSuccess,
      listener: (context, state) async {
        if (_bootstrapped) return;
        final auth = (state as AuthSuccess).authResult;
        await context.read<RoleResolverCubit>().bootstrap(auth);
        _bootstrapped = true;
        debugPrint('[AuthWrapper] Role bootstrap completed');
      },
      builder: (context, authState) {
        // Not authenticated → Login
        if (authState is! AuthSuccess) {
          _bootstrapped = false;
          // Clear any saved role when logging out
          context.read<RoleResolverCubit>().clearSavedRole();
          return const LoginPage();
        }

        // Authenticated — render by role state
        return BlocBuilder<RoleResolverCubit, RoleResolverState>(
          buildWhen: (prev, curr) =>
              prev.status != curr.status || prev.roleId != curr.roleId,
          builder: (context, roleState) {
            debugPrint(
              '[AuthWrapper] Role state: ${roleState.status}, roleId: ${roleState.roleId}',
            );

            switch (roleState.status) {
              case RoleResolveStatus.ready:
                final roleId = roleState.roleId!;
                return _pageForRole(roleId);

              case RoleResolveStatus.firstLogin:
                return NewPasswordPage(email: roleState.email!);

              case RoleResolveStatus.needsSelection:
                return RoleSelectingPage();

              case RoleResolveStatus.loading:
              case RoleResolveStatus.initial:
                // Show minimal loading for role resolution only
                return const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                );
            }
          },
        );
      },
    );
  }
}
