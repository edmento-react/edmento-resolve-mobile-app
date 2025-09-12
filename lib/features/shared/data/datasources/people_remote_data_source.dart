import 'package:edmentoresolve/core/data/network/api_service.dart';
import 'package:edmentoresolve/core/data/storage/storage_util.dart';
import 'package:edmentoresolve/features/shared/data/models/personal_model.dart';
import 'package:edmentoresolve/features/shared/domain/entities/person.dart';

/// Remote data source for people/staff data
abstract class IPeopleRemoteDataSource {
  Future<List<Person>> getPeople({
    StaffRole? role,
    int page = 1,
    int limit = 50,
  });
}

/// Implementation of people remote data source using real API data
class PeopleRemoteDataSourceImpl implements IPeopleRemoteDataSource {
  final ApiService apiService;
  final StorageService storage;

  PeopleRemoteDataSourceImpl(this.apiService, this.storage);
  @override
  Future<List<Person>> getPeople({
    StaffRole? role,
    int page = 1,
    int limit = 50,
  }) async {
    try {
      // Call the API to get admin users
      final userId = await storage.getUserId();
      print('🔍 Getting people for userId: $userId');

      final response = await apiService.getAdminUsers(userId!);
      print('📡 API Response received: ${response.users.length} users');
      print(
        '📡 First user: ${response.users.isNotEmpty ? response.users.first.name : 'No users'}',
      );

      // Convert UserModel list to Person domain entities
      List<Person> people = response.users.map((user) {
        // Create a map that matches the API response structure
        final userMap = {
          'id': user.id,
          'name': user.name,
          'email': user.email,
          'phone': user.phone,
          'assigned_roles':
              user.assigned_roles
                  ?.map(
                    (role) => {
                      'roleid': role.roleid,
                      'positionname': role.positionname,
                      'category': role.category,
                    },
                  )
                  .toList() ??
              [],
        };

        print('🔄 Converting user: ${user.name} -> ${userMap['name']}');
        return PersonModel.fromJson(userMap);
      }).toList();

      print('👥 Converted people: ${people.length}');
      if (people.isNotEmpty) {
        print('👤 First person: ${people.first.name} (${people.first.email})');
      }

      // Search filtering is now handled on the frontend

      // Filter by role if specified
      if (role != null) {
        people = people.where((person) {
          return person.positionName?.toLowerCase() ==
                  role.displayName.toLowerCase() ||
              (person.assignedRoles?.any(
                    (assignedRole) =>
                        assignedRole.positionName.toLowerCase() ==
                        role.displayName.toLowerCase(),
                  ) ??
                  false);
        }).toList();
      }

      // Apply pagination
      final startIndex = (page - 1) * limit;
      final endIndex = startIndex + limit;

      if (startIndex >= people.length) {
        return [];
      }

      return people.sublist(
        startIndex,
        endIndex > people.length ? people.length : endIndex,
      );
    } catch (e) {
      // Handle API errors appropriately
      throw Exception('Failed to fetch people: $e');
    }
  }
}
