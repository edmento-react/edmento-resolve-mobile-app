import 'package:flutter/foundation.dart';

import '../../../../core/utils/storage_util.dart';
import '../models/auth_result_model.dart';
import '../models/user_model.dart';
import 'auth_local_data_source.dart';

/// Local cache for auth-related data:
/// - Secure: sessionId / access token
/// - Prefs : lightweight user snapshot (non-sensitive)
class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final StorageService storage;

  AuthLocalDataSourceImpl(this.storage);

  @override
  Future<void> cacheAuthResult(AuthResultModel authResult) async {
    if (kDebugMode) {
      debugPrint(
        'AuthLocalDataSourceImpl.cacheAuthResult -> ${authResult.toJson()}',
      );
    }

    // 1) Store sessionId/access token securely
    final sessionId = authResult.sessionId;
    if (sessionId != null && sessionId.isNotEmpty) {
      await storage.setAuthToken(sessionId);
    }

    // 2) Cache non-sensitive user snapshot in prefs
    await storage.cacheUser(authResult.user.toJson());
  }

  @override
  Future<AuthResultModel?> getCachedAuthResult() async {
    try {
      final userJson = await storage.getCachedUser(); // sync prefs getter
      final sessionId = await storage.getAuthToken(); // secure

      if (userJson == null || sessionId == null || sessionId.isEmpty) {
        return null;
      }

      // Your model already supports this constructor
      return AuthResultModel.fromJsonWithSessionId(userJson, sessionId);
    } catch (e) {
      if (kDebugMode) {
        debugPrint('AuthLocalDataSourceImpl.getCachedAuthResult error: $e');
      }
      return null;
    }
  }

  @override
  Future<void> clearCache() async {
    // Clear only auth-related data, keep UI prefs (theme/lang) intact
    await storage.clearAllSecure(); // clears token/userId/email in secure store
    await storage.clearAllPrefs(); // removes cached user snapshot
  }

  @override
  Future<String?> getCachedSessionId() async {
    try {
      return await storage.getAuthToken();
    } catch (e) {
      if (kDebugMode) {
        debugPrint('AuthLocalDataSourceImpl.getCachedSessionId error: $e');
      }
      return null;
    }
  }

  @override
  Future<UserModel?> getCachedUser() async {
    try {
      final json = await storage.getCachedUser();
      return UserModel.fromJson(json!);
    } catch (e) {
      if (kDebugMode) {
        debugPrint('AuthLocalDataSourceImpl.getCachedUser parse error: $e');
      }
      return null;
    }
  }
}
