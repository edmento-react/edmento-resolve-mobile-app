import 'package:edmentoresolve/core/error/exceptions.dart';
import 'package:edmentoresolve/features/authentication/domain/usecases/verify_otp_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

part 'otp_state.dart';

class OtpCubit extends Cubit<OtpState> {
  final VerifyOtpUsecase verifyOtpUsecase;

  final logger = Logger();

  OtpCubit({required this.email, required this.verifyOtpUsecase})
    : super(OtpState.initial(email)) {
    _startTimer();
  }

  final String email;
  Duration _lastTick = Duration.zero;
  late final Stopwatch _stopwatch;
  bool _isActive = true;

  void _startTimer() {
    _stopwatch = Stopwatch()..start();
    _tick();
  }

  void _tick() async {
    while (_isActive && _stopwatch.isRunning) {
      await Future.delayed(const Duration(seconds: 1));
      if (!_isActive) break;

      final elapsed = _stopwatch.elapsed;
      if (elapsed.inSeconds > _lastTick.inSeconds) {
        _lastTick = elapsed;
        final seconds = 60 - elapsed.inSeconds;
        if (seconds > 0) {
          emit(state.copyWith(secondsRemaining: seconds));
        } else {
          _stopwatch.stop();
          emit(state.copyWith(secondsRemaining: 0));
        }
      }
    }
  }

  void updateOtpDigit(int index, String value) {
    final updatedOtp = [...state.otpDigits];
    updatedOtp[index] = value;
    emit(state.copyWith(otpDigits: updatedOtp, errorMessage: null));
  }

  void submitOtp() async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    await Future.delayed(const Duration(seconds: 2)); // simulate API call

    final enteredOtp = state.otpDigits.join();
    final result = await verifyOtpUsecase(
      VerifyOtpParams(email: email, otp: enteredOtp),
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
          emit(state.copyWith(isLoading: false, otpVerified: true));
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

  void resendOtp() {
    _stopwatch.reset();
    _lastTick = Duration.zero;
    _stopwatch.start();
    emit(
      state.copyWith(
        secondsRemaining: 60,
        errorMessage: null,
        otpDigits: List.filled(6, ''),
      ),
    );
    // Simulate resend call here if needed
  }

  @override
  Future<void> close() {
    _isActive = false;
    _stopwatch.stop();
    return super.close();
  }

  String _mapFailureToMessage(Failure failure) {
    return failure.message ?? 'An error occurred. Please try again.';
  }
}
