// new_password_state.dart
part of 'new_password_cubit.dart';

class NewPasswordState extends Equatable {
  final String newPassword;
  final String confirmPassword;
  final bool isLoading;
  final String errorMessage;
  final bool success;

  const NewPasswordState({
    required this.newPassword,
    required this.confirmPassword,
    required this.isLoading,
    required this.errorMessage,
    required this.success,
  });

  factory NewPasswordState.initial() => NewPasswordState(
    newPassword: '',
    confirmPassword: '',
    isLoading: false,
    errorMessage: '',
    success: false,
  );

  NewPasswordState copyWith({
    String? newPassword,
    String? confirmPassword,
    bool? isLoading,
    String? errorMessage,
    bool? success,
  }) {
    return NewPasswordState(
      newPassword: newPassword ?? this.newPassword,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      success: success ?? this.success,
    );
  }

  @override
  List<Object?> get props => [
    newPassword,
    confirmPassword,
    isLoading,
    errorMessage,
    success,
  ];
}
