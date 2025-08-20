part of 'otp_cubit.dart';

class OtpState extends Equatable {
  final List<String> otpDigits;
  final bool isLoading;
  final String? errorMessage;
  final int secondsRemaining;
  final bool otpVerified;
  final String email;

  const OtpState({
    required this.email,
    required this.otpDigits,
    required this.isLoading,
    required this.errorMessage,
    required this.secondsRemaining,
    required this.otpVerified,
  });

  factory OtpState.initial(String email) {
    return OtpState(
      email: email,
      otpDigits: List.filled(6, ''),
      isLoading: false,
      errorMessage: null,
      secondsRemaining: 60,
      otpVerified: false,
    );
  }

  OtpState copyWith({
    List<String>? otpDigits,
    bool? isLoading,
    String? errorMessage,
    int? secondsRemaining,
    bool? otpVerified,
  }) {
    return OtpState(
      email: email,
      otpDigits: otpDigits ?? this.otpDigits,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      secondsRemaining: secondsRemaining ?? this.secondsRemaining,
      otpVerified: otpVerified ?? this.otpVerified,
    );
  }

  @override
  List<Object?> get props => [
    email,
    otpDigits,
    isLoading,
    errorMessage,
    secondsRemaining,
    otpVerified,
  ];
}
