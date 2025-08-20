import 'package:flutter_bloc/flutter_bloc.dart';

class LoginState {
  final bool obscurePassword;
  final bool isTermsAccepted;
  final String email;
  final String password;
  final bool emailHasFocus;
  final bool passwordHasFocus;

  LoginState({
    this.obscurePassword = true,
    this.isTermsAccepted = false,
    this.email = '',
    this.password = '',
    this.emailHasFocus = false,
    this.passwordHasFocus = false,
  });

  bool get isEmailValid => email.isNotEmpty
      ? RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)
      : true;

  bool get isPasswordValid => password.isNotEmpty
      ? password.length >= 3
      : true; // You can customize further

  bool get isFormValid =>
      isTermsAccepted &&
      isEmailValid &&
      isPasswordValid &&
      email.isNotEmpty &&
      password.isNotEmpty;

  LoginState copyWith({
    bool? obscurePassword,
    bool? isTermsAccepted,
    String? email,
    String? password,
    bool? emailHasFocus,
    bool? passwordHasFocus,
  }) {
    return LoginState(
      obscurePassword: obscurePassword ?? this.obscurePassword,
      isTermsAccepted: isTermsAccepted ?? this.isTermsAccepted,
      email: email ?? this.email,
      password: password ?? this.password,
      emailHasFocus: emailHasFocus ?? this.emailHasFocus,
      passwordHasFocus: passwordHasFocus ?? this.passwordHasFocus,
    );
  }

  // Helper getters for validation
  bool get canSubmit =>
      isTermsAccepted && email.isNotEmpty && password.isNotEmpty;
}

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginState());

  // Business logic methods
  void toggleObscurePassword() {
    emit(state.copyWith(obscurePassword: !state.obscurePassword));
  }

  void setTermsAccepted(bool accepted) {
    emit(state.copyWith(isTermsAccepted: accepted));
  }

  void setEmail(String value) {
    emit(state.copyWith(email: value));
  }

  void setPassword(String value) {
    emit(state.copyWith(password: value));
  }

  // UI state methods with business logic
  void setEmailFocus(bool hasFocus) {
    emit(
      state.copyWith(
        emailHasFocus: hasFocus,
        // When email gets focus, remove password focus
        passwordHasFocus: hasFocus ? false : state.passwordHasFocus,
      ),
    );
  }

  void setPasswordFocus(bool hasFocus) {
    emit(
      state.copyWith(
        passwordHasFocus: hasFocus,
        // When password gets focus, remove email focus
        emailHasFocus: hasFocus ? false : state.emailHasFocus,
      ),
    );
  }

  void clearAllFocus({bool? isLogin = false}) {
    isLogin == false
        ? emit(state.copyWith(emailHasFocus: false, passwordHasFocus: false))
        : emit(
            state.copyWith(
              email: '',
              password: '',
              emailHasFocus: false,
              passwordHasFocus: false,
              obscurePassword: true,
            ),
          );
  }
}
