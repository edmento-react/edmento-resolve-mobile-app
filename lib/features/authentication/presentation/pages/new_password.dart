// new_password_page.dart
import 'package:edmentoresolve/core/constants/routes.dart';
import 'package:edmentoresolve/features/authentication/domain/usecases/new_password_usecase.dart';
import 'package:edmentoresolve/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:edmentoresolve/features/authentication/presentation/bloc/new_password_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class NewPasswordPage extends StatelessWidget {
  final String email;
  const NewPasswordPage({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    // Debug removed
    return BlocProvider(
      create: (_) => NewPasswordCubit(email, GetIt.I<NewPasswordUsecase>()),
      child: const _NewPasswordView(),
    );
  }
}

class _NewPasswordView extends StatelessWidget {
  const _NewPasswordView();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (context.read<AuthBloc>().state is AuthSuccess) {
          context.read<AuthBloc>().add(LogoutRequested());

          // Delay a frame to allow state update before navigating
          await Future.delayed(const Duration(milliseconds: 100));

          // Replace immediately to login screen
          context.go(AppRoutes.login);
          return Future.value(false);
        } else {
          return Future.value(true);
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Set New Password')),
        body: BlocConsumer<NewPasswordCubit, NewPasswordState>(
          listener: (context, state) {
            if (state.success) {
              if (context.read<AuthBloc>().state is AuthSuccess) {
                context.read<AuthBloc>().add(LogoutRequested());
                // Debug removed
              } else {
                // Navigation handled by context.go above

                // Debug removed
              }
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Password reset successful!')),
              );
              // context.read<AuthBloc>().add(LogoutRequested());
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  TextField(
                    obscureText: true,
                    onChanged: (value) => context
                        .read<NewPasswordCubit>()
                        .newPasswordChanged(value),
                    decoration: const InputDecoration(
                      labelText: 'New Password',
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    obscureText: true,
                    onChanged: (value) => context
                        .read<NewPasswordCubit>()
                        .confirmPasswordChanged(value),
                    decoration: const InputDecoration(
                      labelText: 'Confirm Password',
                    ),
                  ),
                  const SizedBox(height: 24),
                  if (state.errorMessage.isNotEmpty)
                    Text(
                      state.errorMessage,
                      style: TextStyle(color: Colors.red),
                    ),
                  SizedBox(height: 8),
                  state.isLoading
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                          onPressed: () =>
                              context.read<NewPasswordCubit>().submit(),
                          child: const Text('Set Password'),
                        ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
