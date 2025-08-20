// lib/core/storage/storage_service.dart
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// One facade for app storage:
/// - Sensitive: FlutterSecureStorage
/// - Non-sensitive: SharedPreferences
///
/// Notes:
/// - roleId is intentionally kept in SharedPreferences (not sensitive).
/// - No migration logic (project is in build stage).
class StorageService {
  StorageService._(this._prefs, this._secure);

  static StorageService? _instance;
  final SharedPreferences _prefs;
  final FlutterSecureStorage _secure;

  /// Initialize once at app bootstrap (e.g., main())
  static Future<StorageService> init() async {
    if (_instance != null) return _instance!;
    final prefs = await SharedPreferences.getInstance();
    const secure = FlutterSecureStorage(
      aOptions: AndroidOptions(encryptedSharedPreferences: true),
      iOptions: IOSOptions(
        accessibility: KeychainAccessibility.first_unlock_this_device,
      ),
    );
    _instance = StorageService._(prefs, secure);
    return _instance!;
  }

  /// Get the initialized singleton (after calling init()).
  static StorageService get I {
    final i = _instance;
    assert(i != null, 'StorageService.init() must be called before use.');
    return i!;
  }

  // ---------------------------------------------------------------------------
  // Keys
  // ---------------------------------------------------------------------------

  // Secure keys (sensitive)
  static const String _kAuthToken = 'auth_token';
  static const String _kRefreshToken = 'refresh_token';
  static const String _kUserId = 'user_id';
  static const String _kUserEmail = 'user_email';
  static const String _kApiKey = 'api_key';
  static const String _kApiSecret = 'api_secret';

  // Prefs keys (non-sensitive)
  static const String _kRoleId = '_roleId'; // chosen role for session
  static const String _kThemeMode = 'theme_mode';
  static const String _kLanguage = 'language';
  static const String _kOnboardingDone = 'onboarding_completed';
  static const String _kNotifications = 'notifications_enabled';
  static const String _kBiometric = 'biometric_enabled';
  static const String _kLastSync = 'last_sync_timestamp';
  static const String _kUserData = 'user_data';

  // ---------------------------------------------------------------------------
  // Sensitive (SecureStorage)
  // ---------------------------------------------------------------------------

  Future<void> setAuthToken(String token) => _writeSecure(_kAuthToken, token);
  Future<String?> getAuthToken() => _readSecure(_kAuthToken);

  Future<void> setRefreshToken(String token) =>
      _writeSecure(_kRefreshToken, token);
  Future<String?> getRefreshToken() => _readSecure(_kRefreshToken);

  Future<void> setUserId(String userId) => _writeSecure(_kUserId, userId);
  Future<String?> getUserId() => _readSecure(_kUserId);

  Future<void> setUserEmail(String email) => _writeSecure(_kUserEmail, email);
  Future<String?> getUserEmail() => _readSecure(_kUserEmail);

  // Optional API keys (keep only if you actually use them)
  Future<void> setApiKey(String value) => _writeSecure(_kApiKey, value);
  Future<String?> getApiKey() => _readSecure(_kApiKey);

  Future<void> setApiSecret(String value) => _writeSecure(_kApiSecret, value);
  Future<String?> getApiSecret() => _readSecure(_kApiSecret);

  /// Store any small JSON object securely
  Future<void> setSecureObject(String key, Map<String, dynamic> object) =>
      _writeSecure(key, jsonEncode(object));

  Future<Map<String, dynamic>?> getSecureObject(String key) async {
    final v = await _readSecure(key);
    return v == null ? null : (jsonDecode(v) as Map<String, dynamic>);
  }

  ///Cache user snapshot
  Future<void> cacheUser(Map<String, dynamic> user) =>
      _writeSecure(_kUserData, jsonEncode(user));

  Future<Map<String, dynamic>?> getCachedUser() async {
    final s = await _readSecure(_kUserData);
    if (s == null) return null;
    try {
      return jsonDecode(s) as Map<String, dynamic>;
    } catch (e) {
      debugPrint('Failed to decode cached user: $e');
      return null;
    }
  }

  /// Clear only auth-related secure data
  Future<void> clearSecureAuth() async {
    await _secure.delete(key: _kAuthToken);
    await _secure.delete(key: _kRefreshToken);
    await _secure.delete(key: _kUserId);
    await _secure.delete(key: _kUserEmail);
  }

  /// Danger: clears all secure entries
  Future<void> clearAllSecure() => _secure.deleteAll();

  // ---------------------------------------------------------------------------
  // Non-sensitive (SharedPreferences)
  // ---------------------------------------------------------------------------

  // Role selection (multi-role users) — not sensitive
  Future<void> setUserRoleId(int roleId) async {
    try {
      await _prefs.setInt(_kRoleId, roleId);
    } catch (e) {
      debugPrint('setUserRoleId error: $e');
    }
  }

  int? getUserRoleId() {
    try {
      return _prefs.getInt(_kRoleId);
    } catch (e) {
      debugPrint('getUserRoleId error: $e');
      return null;
    }
  }

  Future<void> clearUserRoleId() async {
    try {
      await _prefs.remove(_kRoleId);
    } catch (e) {
      debugPrint('clearUserRoleId error: $e');
    }
  }

  // Theme & language
  Future<void> setThemeMode(String mode) async =>
      _prefs.setString(_kThemeMode, mode);
  String getThemeMode() => _prefs.getString(_kThemeMode) ?? 'system';

  Future<void> setLanguage(String code) async =>
      _prefs.setString(_kLanguage, code);
  String getLanguage() => _prefs.getString(_kLanguage) ?? 'en';

  // Onboarding
  Future<void> setOnboardingCompleted(bool done) async =>
      _prefs.setBool(_kOnboardingDone, done);
  bool isOnboardingCompleted() => _prefs.getBool(_kOnboardingDone) ?? false;

  // Settings
  Future<void> setNotificationsEnabled(bool enabled) async =>
      _prefs.setBool(_kNotifications, enabled);
  bool areNotificationsEnabled() => _prefs.getBool(_kNotifications) ?? true;

  Future<void> setBiometricEnabled(bool enabled) async =>
      _prefs.setBool(_kBiometric, enabled);
  bool isBiometricEnabled() => _prefs.getBool(_kBiometric) ?? false;

  // Sync helpers
  Future<void> setLastSyncTimestamp(int tsMs) async =>
      _prefs.setInt(_kLastSync, tsMs);
  int getLastSyncTimestamp() => _prefs.getInt(_kLastSync) ?? 0;

  bool needsSync({int maxAgeMs = 60 * 60 * 1000}) {
    final last = getLastSyncTimestamp();
    final now = DateTime.now().millisecondsSinceEpoch;
    return (now - last) > maxAgeMs;
  }

  // Cache lightweight user snapshot (non-sensitive)
  // Future<void> cacheUser(Map<String, dynamic> user) async =>
  //     _prefs.setString(_kUserData, jsonEncode(user));

  // Map<String, dynamic>? getCachedUser() {
  //   final s = _prefs.getString(_kUserData);
  //   return s == null ? null : (jsonDecode(s) as Map<String, dynamic>);
  // }

  // Future<void> clearCachedUser() async => _prefs.remove(_kUserData);

  /// Danger: clears ALL non-sensitive preferences
  Future<void> clearAllPrefs() async => _prefs.clear();

  // ---------------------------------------------------------------------------
  // Private helpers
  // ---------------------------------------------------------------------------

  Future<void> _writeSecure(String key, String value) async {
    try {
      await _secure.write(key: key, value: value);
    } catch (e) {
      throw SecureStorageException('Failed to store $key: $e');
    }
  }

  Future<String?> _readSecure(String key) async {
    try {
      return await _secure.read(key: key);
    } catch (e) {
      throw SecureStorageException('Failed to read $key: $e');
    }
  }
}

class SecureStorageException implements Exception {
  final String message;
  SecureStorageException(this.message);
  @override
  String toString() => 'SecureStorageException: $message';
}
