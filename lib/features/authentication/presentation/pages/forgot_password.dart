import 'package:edmentoresolve/core/constants/color_constant.dart';
import 'package:edmentoresolve/core/constants/routes.dart';
import 'package:edmentoresolve/core/utils/screen_util.dart';
import 'package:edmentoresolve/core/widgets/primary_button.dart';
import 'package:edmentoresolve/core/widgets/reusable_text_field.dart';
import 'package:edmentoresolve/core/widgets/spacer_widget.dart';
import 'package:edmentoresolve/core/widgets/text_widget.dart';
import 'package:edmentoresolve/features/authentication/presentation/bloc/forgot_password_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../domain/usecases/send_forgot_password_otp_usecase.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ForgotPasswordCubit(GetIt.I<SendForgotPasswordOtpUseCase>()),
      child: const _ForgotPasswordView(),
    );
  }
}

class _ForgotPasswordView extends StatefulWidget {
  const _ForgotPasswordView();

  @override
  State<_ForgotPasswordView> createState() => __ForgotPasswordViewState();
}

class __ForgotPasswordViewState extends State<_ForgotPasswordView> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final emailFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    emailController.addListener(() {
      if (mounted) {
        context.read<ForgotPasswordCubit>().setEmail(emailController.text);
      }
    });
    emailFocusNode.addListener(() {
      if (mounted) {
        context.read<ForgotPasswordCubit>().setEmailFocus(
          emailFocusNode.hasFocus,
        );
      }
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    emailFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final currentFocus = FocusScope.of(context);
        if (currentFocus.focusedChild is! FocusScopeNode &&
            currentFocus.focusedChild?.context?.widget is! EditableText) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.miniStartTop,
        floatingActionButton: FloatingActionButton(
          elevation: 0,
          backgroundColor: ColorConstant.transparent,
          child: Icon(Icons.arrow_back_ios_rounded),
          onPressed: () {
            context.pop();
          },
        ),
        body: Center(
          child: Padding(
            padding: ScreenUtil.getAdaptivePadding(
              horizontal: 24,
              tabletHorizontal: 48,
            ),
            child: BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
              listener: (context, state) {
                // Debug removed
                if (state.otpSent) {
                  context.go(AppRoutes.otpScreen, extra: state.email);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('OTP sent! Please check your email.'),
                    ),
                  );
                  context.read<ForgotPasswordCubit>().clearOtp();
                  // Optionally navigate to OTP screen
                } else if (state.errorMessage != null) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
                }
              },
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextWidget.heading1('Forgot Password', context: context),
                    TextWidget.body(
                      'Enter your registered email address to recieve a verfication code.',
                      context: context,
                    ),
                    SpacerWidget.xxlarge(),
                    Form(
                      key: formKey,
                      child: ReusableTextField(
                        isShadow: state.emailHasFocus,
                        controller: emailController,
                        focusNode: emailFocusNode,
                        isDark: Theme.of(context).brightness == Brightness.dark,
                        onTap: () {
                          context.read<ForgotPasswordCubit>().setEmailFocus(
                            true,
                          );
                        },
                        isValid: state.isEmailValid,
                        labelText: 'Email',
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        onChanged: (value) {
                          context.read<ForgotPasswordCubit>().setEmail(value);
                        },

                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return null;
                          }
                          if (!RegExp(
                            r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}',
                          ).hasMatch(value)) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      ),
                    ),
                    SpacerWidget.xlarge(),
                    PrimaryButton(
                      label: 'Continue',
                      onPressed:
                          state.isEmailValid &&
                              state.email.isNotEmpty &&
                              !state.isLoading
                          ? () {
                              context.read<ForgotPasswordCubit>().sendOtp();
                            }
                          : null,
                      loading: state.isLoading,
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
