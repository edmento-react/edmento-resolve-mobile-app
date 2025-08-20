import 'package:edmentoresolve/core/error/exceptions.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

import '../../domain/usecases/send_forgot_password_otp_usecase.dart';

final logger = Logger();

class ForgotPasswordState extends Equatable {
  final String email;
  final bool emailHasFocus;
  final bool isLoading;
  final String? errorMessage;
  final bool otpSent;

  const ForgotPasswordState({
    this.email = '',
    this.emailHasFocus = false,
    this.isLoading = false,
    this.errorMessage,
    this.otpSent = false,
  });

  bool get isEmailValid => email.isNotEmpty
      ? RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)
      : true;

  static bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  ForgotPasswordState copyWith({
    String? email,
    bool? emailHasFocus,
    bool? isLoading,
    String? errorMessage,
    bool? otpSent,
  }) {
    return ForgotPasswordState(
      email: email ?? this.email,
      emailHasFocus: emailHasFocus ?? this.emailHasFocus,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      otpSent: otpSent ?? this.otpSent,
    );
  }

  @override
  List<Object?> get props => [
    email,
    emailHasFocus,
    isLoading,
    errorMessage,
    otpSent,
  ];
}

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  final SendForgotPasswordOtpUseCase sendOtpUseCase;

  ForgotPasswordCubit(this.sendOtpUseCase) : super(const ForgotPasswordState());

  void setEmail(String value) {
    emit(state.copyWith(email: value, errorMessage: null));
  }

  void clearOtp() {
    emit(state.copyWith(otpSent: false));
  }

  void setEmailFocus(bool hasFocus) {
    emit(state.copyWith(emailHasFocus: hasFocus));
  }

  Future<void> sendOtp() async {
    final email = state.email;

    if (!ForgotPasswordState._isValidEmail(email)) {
      emit(state.copyWith(errorMessage: 'Please enter a valid email address.'));
      return;
    }

    emit(state.copyWith(isLoading: true, errorMessage: null));

    final result = await sendOtpUseCase(
      SendForgotPasswordOtpParams(email: email),
    );

    result.fold(
      (failure) {
        logger.e('Failed to send OTP', error: failure.message);
        emit(
          state.copyWith(
            isLoading: false,
            errorMessage: _mapFailureToMessage(failure),
          ),
        );
      },
      (success) {
        if (success) {
          logger.i('OTP sent to $email');
          emit(state.copyWith(isLoading: false, otpSent: true));
        } else {
          emit(
            state.copyWith(
              isLoading: false,
              errorMessage: 'Failed to send OTP. Please try again.',
            ),
          );
        }
      },
    );
  }

  void resetOtpStatus() {
    emit(state.copyWith(otpSent: false));
  }

  String _mapFailureToMessage(Failure failure) {
    return failure.message ?? 'An error occurred. Please try again.';
  }
}
