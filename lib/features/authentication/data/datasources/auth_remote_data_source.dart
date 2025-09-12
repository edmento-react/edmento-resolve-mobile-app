import 'package:edmentoresolve/features/authentication/data/models/role_model.dart';

import '../models/auth_result_model.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<AuthResultModel> login(String email, String password);
  Future<void> logout();
  Future<UserModel> getCurrentUser();
  Future<AuthResultModel> refreshToken(String refreshToken, String sessionId);
  Future<bool> sendForgotPasswordOtp(String email);
  Future<bool> verifyOtp(String email, String otp);
  Future<bool> newPassword(String email, String newPassword);
  Future<RoleModel> selectRole(String roleId);
}
