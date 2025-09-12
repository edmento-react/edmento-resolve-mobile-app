import 'package:edmentoresolve/features/authentication/data/models/role_model.dart';

import '../../../../core/constants/api_constants.dart';
import '../../../../core/data/network/api_client.dart';
import '../../../../core/error/exceptions.dart';
import '../models/auth_result_model.dart';
import '../models/user_model.dart';
import 'auth_remote_data_source.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiClient apiClient;

  AuthRemoteDataSourceImpl(this.apiClient);

  @override
  Future<AuthResultModel> login(String email, String password) async {
    try {
      final response = await apiClient.post(
        ApiConstants.login,
        data: {'email': email, 'password': password},
      );

      String? sessionId;

      final cookies = response.headers['set-cookie'];
      if (cookies != null && cookies.isNotEmpty) {
        // First cookie
        final cookie = cookies.first;

        // Extract sessionId using RegExp
        final sessionIdMatch = RegExp(r'sessionId=([^;]+)').firstMatch(cookie);
        sessionId = sessionIdMatch?.group(1);

        print('session id: $sessionId');

        // Avoid heavy logging in release
      }

      if (response.statusCode == 200) {
        if (sessionId == null || sessionId.isEmpty) {
          throw const ServerFailure('Missing session ID in login response');
        }
        return AuthResultModel.fromJsonWithSessionId(response.data, sessionId);
      } else {
        throw const ServerFailure('Login failed');
      }
    } catch (e) {
      if (e is Failure) {
        rethrow;
      }
      throw ServerFailure('Login failed $e');
    }
  }

  @override
  Future<void> logout() async {
    // TEMPORARY: Remove logout API call - handle logout only on frontend
    try {
      await apiClient.post(ApiConstants.logout);
    } catch (e) {
      // Even if logout fails on server, we should still clear local data
      // So we don't rethrow the error
    }

    // Just return without making API call - logout will be handled by clearing local cache
    return;
  }

  @override
  Future<UserModel> getCurrentUser() async {
    try {
      final response = await apiClient.get(ApiConstants.userProfile);

      if (response.statusCode == 200) {
        return UserModel.fromJson(response.data);
      } else {
        throw const ServerFailure('Failed to get user profile');
      }
    } catch (e) {
      if (e is Failure) {
        rethrow;
      }
      throw const ServerFailure('Failed to get user profile');
    }
  }

  @override
  Future<AuthResultModel> refreshToken(
    String refreshToken,
    String sessionId,
  ) async {
    try {
      final response = await apiClient.post(
        ApiConstants.refreshToken,
        data: {'refresh_token': refreshToken},
      );

      if (response.statusCode == 200) {
        return AuthResultModel.fromJsonWithSessionId(response.data, sessionId);
      } else {
        throw const AuthenticationFailure('Token refresh failed');
      }
    } catch (e) {
      if (e is Failure) {
        rethrow;
      }
      throw const AuthenticationFailure('Token refresh failed');
    }
  }

  @override
  Future<bool> sendForgotPasswordOtp(String email) async {
    try {
      final response = await apiClient.post(
        ApiConstants.forgotPassword,
        data: {'email': email},
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      if (e is Failure) {
        rethrow;
      }
      throw ServerFailure('Failed to send forgot password OTP: $e');
    }
  }

  @override
  Future<bool> verifyOtp(String email, String otp) async {
    try {
      final response = await apiClient.post(
        ApiConstants.verifyOtp,
        data: {'email': email, 'otp': otp},
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      if (e is Failure) {
        rethrow;
      }
      throw ServerFailure('Failed to verify OTP: $e');
    }
  }

  @override
  Future<bool> newPassword(String email, String newPassword) async {
    try {
      final response = await apiClient.post(
        ApiConstants.resetPassword,
        data: {'email': email, 'new_password': newPassword},
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      if (e is Failure) {
        rethrow;
      }
      throw ServerFailure('Failed to reset password: $e');
    }
  }

  @override
  Future<RoleModel> selectRole(String roleId) async {
    try {
      final response = await apiClient.post(
        ApiConstants.selectRole,
        data: {'roleId': roleId},
      );
      if (response.statusCode == 200) {
        return RoleModel.fromJson(response.data['currentRole']);
      } else {
        throw const ServerFailure('Select role has issue');
      }
    } catch (e) {
      if (e is Failure) {
        rethrow;
      }
      throw ServerFailure('Failed to select role: $e');
    }
  }
}
