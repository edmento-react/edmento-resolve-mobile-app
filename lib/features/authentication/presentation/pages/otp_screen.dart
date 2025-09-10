import 'package:edmentoresolve/core/constants/color_constant.dart';
import 'package:edmentoresolve/core/config/routes.dart';
import 'package:edmentoresolve/core/widgets/buttons/primary_button.dart';
import 'package:edmentoresolve/core/widgets/text_widget.dart';
import 'package:edmentoresolve/features/authentication/domain/usecases/verify_otp_usecase.dart';
import 'package:edmentoresolve/features/authentication/presentation/bloc/otp_cubit.dart';
import 'package:edmentoresolve/core/widgets/spacer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class OtpPage extends StatelessWidget {
  final String email;
  const OtpPage({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          OtpCubit(email: email, verifyOtpUsecase: GetIt.I<VerifyOtpUsecase>()),
      child: const _OtpView(),
    );
  }
}

class _OtpView extends StatefulWidget {
  const _OtpView({super.key});

  @override
  State<_OtpView> createState() => _OtpViewState();
}

class _OtpViewState extends State<_OtpView> {
  final List<TextEditingController> _controllers = List.generate(
    6,
    (_) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  void _onChanged(int index, String value) {
    context.read<OtpCubit>().updateOtpDigit(index, value);
    if (value.isNotEmpty && index < 5) {
      _focusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OtpCubit, OtpState>(
      listenWhen: (prev, curr) => curr.otpVerified && !prev.otpVerified,
      listener: (context, state) {
        // Navigate to next screen
        context.go(AppRoutes.newPassword, extra: state.email);
      },
      builder: (context, state) {
        final theme = Theme.of(context);

        // Update text controllers based on state
        for (int i = 0; i < 6; i++) {
          if (_controllers[i].text != state.otpDigits[i]) {
            _controllers[i].text = state.otpDigits[i];
            _controllers[i].selection = TextSelection.collapsed(
              offset: _controllers[i].text.length,
            );
          }
        }

        return Scaffold(
          backgroundColor: ColorConstant.scaffoldLight,
          floatingActionButton: FloatingActionButton(
            elevation: 0,
            backgroundColor: ColorConstant.transparent,
            onPressed: () => context.pop(),
            child: const Icon(Icons.arrow_back_ios_rounded),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.miniStartTop,
          body: Center(
            child: SingleChildScrollView(
              // padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                                      SpacerWidget.xlarge(),
                    TextWidget.heading1('Enter OTP', context: context),
                  SpacerWidget.small(),
                  TextWidget.body(
                    'We have sent a 6-digit verification code to',
                    context: context,
                  ),
                  TextWidget.body(
                    state.email,
                    context: context,
                    color: ColorConstant.primaryLight,
                    fontWeight: FontWeight.bold,
                  ),
                  SpacerWidget.xlarge(),
                  Wrap(
                    children: List.generate(6, (index) {
                      return Container(
                        width: 48.w,
                        margin: EdgeInsets.symmetric(horizontal: 6.w),
                        child: TextField(
                          controller: _controllers[index],
                          focusNode: _focusNodes[index],
                          keyboardType: TextInputType.number,
                          maxLength: 1,
                          textAlign: TextAlign.center,
                          style: theme.textTheme.headlineMedium?.copyWith(
                            color: ColorConstant.primaryLight,
                            fontWeight: FontWeight.bold,
                          ),
                          decoration: InputDecoration(
                            counterText: '',
                            filled: true,
                            fillColor: ColorConstant.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: ColorConstant.primaryLight.withOpacity(
                                  0.2,
                                ),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: ColorConstant.primaryLight,
                                width: 2,
                              ),
                            ),
                          ),
                          onChanged: (value) => _onChanged(index, value),
                        ),
                      );
                    }),
                  ),
                  SpacerWidget.large(),
                  if (state.errorMessage != null)
                    Column(
                      children: [
                        TextWidget.body(
                          state.errorMessage!,
                          context: context,
                          color: Colors.red,
                          fontWeight: FontWeight.w600,
                        ),
                        SpacerWidget.custom(12),
                      ],
                    ),
                  PrimaryButton(
                    label: 'Verify',
                    loading: state.isLoading,
                    onPressed:
                        !state.isLoading &&
                            state.otpDigits.every((d) => d.isNotEmpty)
                        ? () => context.read<OtpCubit>().submitOtp()
                        : null,
                  ),
                  SpacerWidget.large(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextWidget.body(
                        'Didn\'t receive the code?',
                        context: context,
                      ),
                      SpacerWidget.widthSmall(),
                      state.secondsRemaining > 0
                          ? TextWidget.body(
                              'Resend in 0:${state.secondsRemaining.toString().padLeft(2, '0')}',
                              context: context,
                              color: ColorConstant.primaryLight,
                            )
                          : GestureDetector(
                              onTap: () => context.read<OtpCubit>().resendOtp(),
                              child: TextWidget.body(
                                'Resend OTP',
                                context: context,
                                color: ColorConstant.primaryLight,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ],
                  ),
                  SpacerWidget.xlarge(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
