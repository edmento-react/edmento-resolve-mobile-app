import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

import '../../domain/entities/auth_result_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';

final logger = Logger();

// EVENTS
abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class LoginRequested extends AuthEvent {
  final String email;
  final String password;

  const LoginRequested({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class LogoutRequested extends AuthEvent {}

class CheckAuthStatus extends AuthEvent {}

// STATES
abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthChecking extends AuthState {}

class AuthSuccess extends AuthState {
  final AuthResult authResult;

  const AuthSuccess(this.authResult);

  @override
  List<Object> get props => [authResult];
}

class AuthFailure extends AuthState {
  final String message;

  const AuthFailure(this.message);

  @override
  List<Object> get props => [message];
}

// BLOC
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final LogoutUseCase logoutUseCase;
  final AuthRepository authRepository;

  AuthBloc({
    required this.loginUseCase,
    required this.logoutUseCase,
    required this.authRepository,
  }) : super(AuthInitial()) {
    on<LoginRequested>(_onLoginRequested);
    on<LogoutRequested>(_onLogoutRequested);
    on<CheckAuthStatus>(_onCheckAuthStatus);
  }

  Future<void> _onLoginRequested(
    LoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    final result = await loginUseCase(
      LoginParams(email: event.email, password: event.password),
    );

    result.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (authResult) => emit(AuthSuccess(authResult)),
    );
    logger.d('Login result: $result');
  }

  Future<void> _onLogoutRequested(
    LogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    final result = await logoutUseCase(NoParams());

    result.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (_) => emit(AuthInitial()),
    );
  }

  Future<void> _onCheckAuthStatus(
    CheckAuthStatus event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthChecking());

    try {
      final isAuthenticated = await authRepository.isAuthenticated();

      final authResult = await isAuthenticated.fold(
        (failure) async => AuthFailure(failure.message),
        (authenticated) async {
          if (authenticated) {
            final userResult = await authRepository.getCurrentUser();
            return userResult.fold(
              (failure) => AuthFailure(failure.message),
              (user) => AuthSuccess(
                AuthResult(
                  user: user,
                  sessionId: '', // Use null to represent optional session ID
                  refreshToken: null,
                ),
              ),
            );
          } else {
            return AuthInitial();
          }
        },
      );

      logger.d('Auth status resolved to: $authResult');

      try {
        emit(authResult);
      } catch (e) {
        logger.w('Emit failed (BLoC closed?): $e');
      }
    } catch (e) {
      logger.e('Exception during checkAuthStatus', error: e);
      emit(AuthFailure('Authentication check failed'));
    }
  }
}
