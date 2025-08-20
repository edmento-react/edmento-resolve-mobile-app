// new_password_cubit.dart
import 'package:edmentoresolve/core/error/exceptions.dart';
import 'package:edmentoresolve/features/authentication/domain/usecases/new_password_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

part 'new_password_state.dart';

class NewPasswordCubit extends Cubit<NewPasswordState> {
  final NewPasswordUsecase newPasswordUsecase;
  final String email;

  final logger = Logger();

  NewPasswordCubit(this.email, this.newPasswordUsecase)
    : super(NewPasswordState.initial());

  void newPasswordChanged(String value) {
    emit(state.copyWith(newPassword: value, errorMessage: '', success: false));
  }

  void confirmPasswordChanged(String value) {
    emit(
      state.copyWith(confirmPassword: value, errorMessage: '', success: false),
    );
  }

  Future<void> submit() async {
    // Basic validation
    if (state.newPassword.length < 8) {
      emit(
        state.copyWith(errorMessage: "Password must be at least 8 characters"),
      );
      return;
    }
    if (state.newPassword != state.confirmPassword) {
      emit(state.copyWith(errorMessage: "Passwords do not match"));
      return;
    }
    emit(state.copyWith(isLoading: true, errorMessage: '', success: false));

    // TODO: Call ResetPasswordUseCase or repository here
    await Future.delayed(const Duration(seconds: 1)); // Simulate network

    final result = await newPasswordUsecase(
      NewPasswordParams(email: email, newPassword: state.newPassword),
    );

    result.fold(
      (failure) {
        logger.e('Failed to send OTP', error: failure.message);
        emit(
          state.copyWith(
            isLoading: false,
            errorMessage: _mapFailureToMessage(failure),
            success: false,
          ),
        );
      },
      (success) {
        if (success) {
          logger.i('OTP sent to $email');
          emit(state.copyWith(isLoading: false, success: true));
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

    // On error
    // emit(state.copyWith(isLoading: false, errorMessage: "Failed to reset password"));
  }

  String _mapFailureToMessage(Failure failure) {
    return failure.message ?? 'An error occurred. Please try again.';
  }
}
