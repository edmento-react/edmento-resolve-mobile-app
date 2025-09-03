import 'package:edmentoresolve/core/widgets/app_bar_widget.dart';
import 'package:edmentoresolve/core/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../authentication/presentation/bloc/auth_bloc.dart';

class OfficeAdminProfilePage extends StatelessWidget {
  const OfficeAdminProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: 'Profile'),
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AuthSuccess) {
            final user = state.authResult.user;
            return Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 36,
                        backgroundImage: user.avatar != null
                            ? NetworkImage(user.avatar!)
                            : null,
                        child: user.avatar == null
                            ? const Icon(Icons.person, size: 36)
                            : null,
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextWidget.heading3(
                            user.name ?? 'Office Admin',
                            context: context,
                            fontWeight: FontWeight.bold,
                          ),
                          TextWidget.body(user.email, context: context),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  TextWidget.heading4(
                    'Account Actions',
                    context: context,
                    fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () =>
                          context.read<AuthBloc>().add(LogoutRequested()),
                      icon: const Icon(Icons.logout),
                      label: TextWidget.label('Sign Out', context: context),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.red,
                        backgroundColor: Colors.white,
                        side: const BorderSide(color: Colors.red),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else if (state is AuthFailure) {
            return Center(
              child: TextWidget.body(
                'Failed to load profile: ${state.message}',
                context: context,
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
