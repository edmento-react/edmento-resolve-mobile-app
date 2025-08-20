import '../models/auth_result_model.dart';
import '../models/user_model.dart';

abstract class AuthLocalDataSource {
  Future<void> cacheAuthResult(AuthResultModel authResult);
  Future<AuthResultModel?> getCachedAuthResult();
  Future<void> clearCache();
  Future<String?> getCachedSessionId();
  Future<UserModel?> getCachedUser();
}
