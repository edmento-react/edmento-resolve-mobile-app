import 'package:edmentoresolve/core/constants/app_constants.dart';
import 'package:edmentoresolve/core/constants/color_constant.dart';
import 'package:edmentoresolve/core/constants/routes.dart';
import 'package:edmentoresolve/core/utils/screen_util.dart';
import 'package:edmentoresolve/core/widgets/index.dart';
import 'package:edmentoresolve/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:edmentoresolve/features/authentication/presentation/bloc/role_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

// ignore: must_be_immutable
class RoleSelectingPage extends StatelessWidget {
  RoleSelectingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextWidget.heading1(context: context, 'Select your role!'),

          BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state is AuthSuccess) {
                final apiRoleIds = state.authResult.user.roles
                    .map((r) => r.roleId)
                    .whereType<int>()
                    .toSet();

                // Keep only roles the user actually has
                final matchedRoles = roles
                    .where((role) => apiRoleIds.contains(role.roleId))
                    .toList();
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: matchedRoles.length,
                  itemBuilder: (context, index) {
                    final data = matchedRoles[index];
                    return ContainerWidget.withPadding(
                      child: ListTile(
                        onTap: () async {
                          // Persist via cubit and let the gate render the right page
                          // Navigator.pushNamedAndRemoveUntil(
                          //   context,
                          //   data.route,
                          //   (route) => false,
                          // );
                          context.read<RoleResolverCubit>().setSelectedRole(
                            data.roleId,
                          );
                          context.go(AppRoutes.authWrapper);
                        },
                        minVerticalPadding: ScreenUtil.screenHeight * 0.04,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        title: TextWidget.heading1(context: context, data.name),
                        leading: Icon(null),
                        trailing: Icon(
                          data.icon,
                          size: ScreenUtil.pixelRatio * 20,
                        ),
                        tileColor: ColorConstant.grey200,
                      ),
                    );
                  },
                );
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
        ],
      ),
    );
  }

  List<Role> roles = [
    Role(UserRoles.principal, 'Principal', Icons.person),
    Role(UserRoles.teacher, 'Teacher', Icons.school_rounded),
    Role(UserRoles.coordinator, 'Coordinator', Icons.person_4_rounded),
    Role(UserRoles.parent, 'Parent', Icons.person_3_rounded),
    Role(UserRoles.student, 'Student', Icons.person_2_rounded),
  ];
}

class Role {
  final int roleId;
  final String name;
  final IconData icon;
  Role(this.roleId, this.name, this.icon);
}
