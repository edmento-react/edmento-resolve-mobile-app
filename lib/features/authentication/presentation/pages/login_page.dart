import 'package:edmentoresolve/core/constants/color_constant.dart';
import 'package:edmentoresolve/core/constants/routes.dart';
import 'package:edmentoresolve/core/constants/style_constant.dart';
import 'package:edmentoresolve/core/utils/screen_util.dart';
import 'package:edmentoresolve/core/widgets/global_snackbar.dart';
import 'package:edmentoresolve/core/widgets/primary_button.dart';
import 'package:edmentoresolve/core/widgets/reusable_text_field.dart';
import 'package:edmentoresolve/core/widgets/spacer_widget.dart';
import 'package:edmentoresolve/core/widgets/text_widget.dart';
import 'package:edmentoresolve/features/authentication/presentation/widgets/or_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../bloc/auth_bloc.dart';
import '../bloc/login_cubit.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _LoginPageView();
  }
}

class _LoginPageView extends StatefulWidget {
  const _LoginPageView();

  @override
  State<_LoginPageView> createState() => _LoginPageViewState();
}

class _LoginPageViewState extends State<_LoginPageView> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // FocusNodes
  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();

  // // Focus state tracking
  // bool emailHasFocus = false;
  // bool passwordHasFocus = false;

  void resetForm() {
    emailController.clear();
    passwordController.clear();
    context.read<LoginCubit>().clearAllFocus();
    emailFocusNode.unfocus();
    passwordFocusNode.unfocus();
    FocusScope.of(context).unfocus();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      FocusScope.of(context).unfocus();
    });
    // Text listeners for business logic
    emailController.addListener(() {
      if (mounted) {
        context.read<LoginCubit>().setEmail(emailController.text);
      }
    });

    passwordController.addListener(() {
      if (mounted) {
        context.read<LoginCubit>().setPassword(passwordController.text);
      }
    });

    // // Focus listeners for UI state
    emailFocusNode.addListener(() {
      if (mounted) {
        context.read<LoginCubit>().setEmailFocus(emailFocusNode.hasFocus);
      }
    });

    passwordFocusNode.addListener(() {
      if (mounted) {
        context.read<LoginCubit>().setPasswordFocus(passwordFocusNode.hasFocus);
      }
    });
  }

  @override
  void dispose() {
    // Dispose controllers
    emailController.dispose();
    passwordController.dispose();

    // Dispose focus nodes
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  void login() {
    if (formKey.currentState!.validate()) {
      context.read<LoginCubit>().clearAllFocus();
      FocusScope.of(context).unfocus();

      context.read<AuthBloc>().add(
        LoginRequested(
          email: emailController.text.trim(),
          password: passwordController.text,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: BlocListener<AuthBloc, AuthState>(
        // Only react to failure or success. Role bootstrap is handled by the dashboard gate.
        listenWhen: (prev, curr) => curr is AuthFailure || curr is AuthSuccess,
        listener: (context, state) {
          if (state is AuthFailure) {
            GlobalSnackBar.show(
              context,
              message: state.message,
              backgroundColor: ColorConstant.red,
            );
          } else if (state is AuthSuccess) {
            // Keep UX snappy: clear focus and let the gate show the right page.
            context.read<LoginCubit>().clearAllFocus(isLogin: true);
          }
        },
        child: SafeArea(
          child: GestureDetector(
            onTap: () {
              // Only unfocus if the current focus is NOT on a text field
              final currentFocus = FocusScope.of(context);
              if (currentFocus.focusedChild is! FocusScopeNode &&
                  currentFocus.focusedChild?.context?.widget is! EditableText) {
                currentFocus.unfocus();
              }
            },
            behavior: HitTestBehavior.translucent,
            child: Center(
              child: Padding(
                padding: ScreenUtil.getAdaptivePadding(
                  horizontal: 24,
                  vertical: 24,
                  tabletHorizontal: 48,
                  tabletVertical: 48,
                ),
                child: Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Image.asset('assets/images/logo.png', height: 150),
                        // SpacerWidget.small(),
                        TextWidget.heading1(
                          'Welcome Back!',
                          textAlign: TextAlign.center,
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                          context: context,
                        ),
                        SpacerWidget.xxlarge(),
                        // SpacerWidget.xxlarge(),

                        // Email field with focus-based shadow
                        // Email field
                        BlocBuilder<LoginCubit, LoginState>(
                          buildWhen: (prev, curr) =>
                              prev.emailHasFocus != curr.emailHasFocus ||
                              prev.email != curr.email ||
                              prev.isEmailValid != curr.isEmailValid,
                          builder: (context, state) {
                            return ReusableTextField(
                              isShadow: state.emailHasFocus,
                              controller: emailController,
                              focusNode: emailFocusNode,
                              isDark:
                                  Theme.of(context).brightness ==
                                  Brightness.dark,
                              onTap: () {
                                context.read<LoginCubit>().setEmailFocus(true);
                                context.read<LoginCubit>().setPasswordFocus(
                                  false,
                                );
                              },
                              isValid: state.isEmailValid,
                              labelText: 'Email',
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              onChanged: (value) {
                                context.read<LoginCubit>().setEmail(value);
                              },
                              onSubmitted: (value) {
                                FocusScope.of(
                                  context,
                                ).requestFocus(passwordFocusNode);
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
                            );
                          },
                        ),
                        SpacerWidget.large(),
                        // Password field
                        BlocBuilder<LoginCubit, LoginState>(
                          buildWhen: (prev, curr) =>
                              prev.passwordHasFocus != curr.passwordHasFocus ||
                              prev.password != curr.password ||
                              prev.obscurePassword != curr.obscurePassword ||
                              prev.isTermsAccepted != curr.isTermsAccepted ||
                              prev.isPasswordValid != curr.isPasswordValid,
                          builder: (context, state) {
                            return ReusableTextField(
                              isShadow: state.passwordHasFocus,
                              onTap: () {
                                context.read<LoginCubit>().setEmailFocus(false);
                                context.read<LoginCubit>().setPasswordFocus(
                                  true,
                                );
                              },
                              isDark:
                                  Theme.of(context).brightness ==
                                  Brightness.dark,
                              isValid: state.isPasswordValid,
                              controller: passwordController,
                              focusNode: passwordFocusNode,
                              labelText: 'Password',
                              obscureText: state.obscurePassword,
                              textInputAction: TextInputAction.done,
                              onChanged: (value) {
                                context.read<LoginCubit>().setPassword(value);
                              },
                              onSubmitted: (value) {
                                state.isTermsAccepted
                                    ? login()
                                    : context
                                          .read<LoginCubit>()
                                          .clearAllFocus();
                              },
                              suffixIcon: IconButton(
                                icon: Icon(
                                  state.obscurePassword
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: ColorConstant.grey800,
                                ),
                                onPressed: () {
                                  context
                                      .read<LoginCubit>()
                                      .toggleObscurePassword();
                                },
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return null;
                                }
                                if (value.length < 3) {
                                  return 'Password must be at least 3 characters';
                                }
                                return null;
                              },
                            );
                          },
                        ),

                        SpacerWidget.medium(),
                        Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: () {
                              resetForm();

                              context.push(AppRoutes.forgotPassword);
                            },
                            child: TextWidget.body(
                              'Forget password?',
                              color: ColorConstant.blueDark,
                              context: context,
                            ),
                          ),
                        ),

                        SpacerWidget.large(),
                        BlocBuilder<LoginCubit, LoginState>(
                          builder: (context, loginState) {
                            return BlocBuilder<AuthBloc, AuthState>(
                              builder: (context, authState) {
                                return PrimaryButton(
                                  label: 'Continue',
                                  onPressed:
                                      authState is AuthLoading ||
                                          !loginState.isFormValid
                                      ? null
                                      : login,
                                  loading:
                                      authState is AuthLoading &&
                                      loginState.isFormValid,
                                );
                              },
                            );
                          },
                        ),

                        SpacerWidget.xxlarge(),

                        OrWidget(),
                        SpacerWidget.xxlarge(),
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton(
                            onPressed: () {
                              // Unfocus before navigation
                              FocusScope.of(context).unfocus();
                            },
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              side: BorderSide(
                                color:
                                    Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? ColorConstant.dividerColorDark
                                    : ColorConstant.dividerColorLight,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.email_outlined,
                                  size: 20,
                                  color:
                                      Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? ColorConstant.textPrimaryColorDark
                                      : ColorConstant.textPrimaryColorLight,
                                ),
                                SpacerWidget.widthMedium(),
                                Text(
                                  'Continue with Email',
                                  style: StyleConstant.body(context).copyWith(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    color:
                                        Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? ColorConstant.textPrimaryColorDark
                                        : ColorConstant.textPrimaryColorLight,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // SpacerWidget.xxlarge(),
                        // GestureDetector(
                        //   onTap: () {
                        //     FocusScope.of(context).unfocus();
                        //   },
                        //   child: Text(
                        //     "Don't have an account? contact\nclass teacher",
                        //     textAlign: TextAlign.center,
                        //     style: StyleConstant.caption(
                        //       context,
                        //     ).copyWith(fontSize: 14),
                        //   ),
                        // ),

                        // SpacerWidget.xxlarge(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      persistentFooterButtons: [
        BlocBuilder<LoginCubit, LoginState>(
          builder: (context, loginState) {
            return Row(
              children: [
                Checkbox(
                  value: loginState.isTermsAccepted,
                  onChanged: (bool? value) {
                    context.read<LoginCubit>().setTermsAccepted(value ?? false);
                  },
                  activeColor: ColorConstant.green,
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      context.read<LoginCubit>().setTermsAccepted(
                        !loginState.isTermsAccepted,
                      );
                    },
                    child: Text(
                      'By proceeding, I agree to the Privacy Policy and Terms & Conditions.',
                      style: TextStyle(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? ColorConstant.grey400
                            : ColorConstant.grey800,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
