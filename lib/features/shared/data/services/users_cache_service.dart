import 'package:edmentoresolve/features/shared/domain/entities/person.dart';

/// Service to cache and manage user data for search functionality
class UsersCacheService {
  static final UsersCacheService _instance = UsersCacheService._internal();
  factory UsersCacheService() => _instance;
  UsersCacheService._internal();

  List<Person>? _cachedUsers;
  DateTime? _lastFetchTime;
  static const Duration _cacheValidityDuration = Duration(minutes: 30);

  /// Get cached users if available and not expired
  List<Person>? get cachedUsers {
    if (_cachedUsers == null) return null;

    if (_lastFetchTime == null) return null;

    if (DateTime.now().difference(_lastFetchTime!) > _cacheValidityDuration) {
      // Cache expired
      _cachedUsers = null;
      _lastFetchTime = null;
      return null;
    }

    return _cachedUsers;
  }

  /// Check if cache is valid and not empty
  bool get hasValidCache => cachedUsers != null && cachedUsers!.isNotEmpty;

  /// Cache users data
  void cacheUsers(List<Person> users) {
    _cachedUsers = List.from(
      users,
    ); // Create a copy to avoid external modifications
    _lastFetchTime = DateTime.now();
    print('📦 UsersCacheService: Cached ${users.length} users');
  }

  /// Clear cache
  void clearCache() {
    _cachedUsers = null;
    _lastFetchTime = null;
    print('🗑️ UsersCacheService: Cache cleared');
  }

  /// Force refresh cache (mark as expired)
  void markCacheAsExpired() {
    _lastFetchTime = null;
    print('⏰ UsersCacheService: Cache marked as expired');
  }

  /// Search users in cache
  List<Person> searchUsers(String query) {
    if (!hasValidCache) return [];

    if (query.isEmpty) return _cachedUsers!;

    return _cachedUsers!.where((person) {
      final nameMatch = person.name.toLowerCase().contains(query.toLowerCase());
      final emailMatch = person.email.toLowerCase().contains(
        query.toLowerCase(),
      );
      final positionMatch =
          person.positionName?.toLowerCase().contains(query.toLowerCase()) ??
          false;
      final phoneMatch =
          person.phone?.toLowerCase().contains(query.toLowerCase()) ?? false;

      return nameMatch || emailMatch || positionMatch || phoneMatch;
    }).toList();
  }

  /// Get cache info for debugging
  Map<String, dynamic> getCacheInfo() {
    return {
      'hasCache': _cachedUsers != null,
      'userCount': _cachedUsers?.length ?? 0,
      'lastFetchTime': _lastFetchTime?.toIso8601String(),
      'isExpired': !hasValidCache,
      'cacheAge': _lastFetchTime != null
          ? DateTime.now().difference(_lastFetchTime!).inMinutes
          : null,
    };
  }
}
