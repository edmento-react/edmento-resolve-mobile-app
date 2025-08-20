import 'package:dartz/dartz.dart';
import 'package:edmentoresolve/features/authentication/domain/entities/roles_entity.dart';

import '../../../../core/error/exceptions.dart';
import '../entities/auth_result_entity.dart';
import '../entities/user_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, AuthResult>> login(String email, String password);
  Future<Either<Failure, void>> logout();
  Future<Either<Failure, User>> getCurrentUser();
  Future<Either<Failure, bool>> isAuthenticated();
  Future<Either<Failure, AuthResult>> refreshToken(String refreshToken);
  Future<Either<Failure, bool>> sendForgotPasswordOtp(String email);
  Future<Either<Failure, bool>> verifyOtp(String email, String otp);
  Future<Either<Failure, bool>> newPassword(String email, String newPassword);
  Future<Either<Failure, Roles>> selectRole(String roleId);
}
