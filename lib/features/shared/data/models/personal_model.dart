// data/models/person_model.dart
import 'package:edmentoresolve/features/shared/domain/entities/person.dart';

/// Data-layer model for AssignedRole
class AssignedRoleModel extends AssignedRole {
  const AssignedRoleModel({
    required super.roleId,
    required super.positionName,
    required super.category,
  });

  /// Create AssignedRoleModel from JSON
  factory AssignedRoleModel.fromJson(Map<String, dynamic> json) {
    // Handle both snake_case and camelCase from APIs
    int parseInt(dynamic v) {
      if (v is int) return v;
      if (v is String) return int.tryParse(v) ?? 0;
      return 0;
    }

    return AssignedRoleModel(
      roleId: parseInt(json['roleid'] ?? json['roleId'] ?? json['role_id']),
      positionName:
          (json['positionname'] ??
                  json['positionName'] ??
                  json['position_name'] ??
                  '')
              .toString(),
      category: (json['category'] ?? '').toString(),
    );
  }

  /// Convert AssignedRoleModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'roleId': roleId,
      'positionName': positionName,
      'category': category,
    };
  }

  /// Create AssignedRoleModel from domain entity
  factory AssignedRoleModel.fromEntity(AssignedRole role) {
    return AssignedRoleModel(
      roleId: role.roleId,
      positionName: role.positionName,
      category: role.category,
    );
  }

  /// Convert model back to domain entity
  AssignedRole toEntity() {
    return AssignedRole(
      roleId: roleId,
      positionName: positionName,
      category: category,
    );
  }
}

/// Data-layer model for Person
class PersonModel extends Person {
  const PersonModel({
    required super.id,
    required super.name,
    required super.email,
    super.positionName,
    super.phone,
    super.assignedRoles,
  });

  /// Create PersonModel from JSON
  factory PersonModel.fromJson(Map<String, dynamic> json) {
    // Helpers
    String? s(dynamic v) => v?.toString();

    List<AssignedRole>? parseAssignedRoles(dynamic v) {
      if (v is List) {
        return v
            .whereType<Map<String, dynamic>>()
            .map((e) => AssignedRoleModel.fromJson(e).toEntity())
            .toList();
      }
      return null;
    }

    return PersonModel(
      id: (json['id'] ?? json['userId'] ?? json['personId']).toString(),
      name: (json['name'] ?? json['fullName'] ?? '').toString(),
      email: (json['email'] ?? '').toString(),
      positionName: s(json['positionName'] ?? json['positionname']),
      phone: s(json['phone'] ?? json['mobile'] ?? json['phoneNumber']),
      assignedRoles: parseAssignedRoles(
        json['assigned_roles'] ?? json['assignedRoles'] ?? json['roles'],
      ),
    );
  }

  /// Convert PersonModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'positionName': positionName,
      'phone': phone,
      'assignedRoles': assignedRoles
          ?.map((r) => AssignedRoleModel.fromEntity(r).toJson())
          .toList(),
    };
  }

  /// Create PersonModel from domain entity
  factory PersonModel.fromEntity(Person person) {
    return PersonModel(
      id: person.id,
      name: person.name,
      email: person.email,
      positionName: person.positionName,
      phone: person.phone,
      assignedRoles: person.assignedRoles,
    );
  }

  /// Convert model back to domain entity
  Person toEntity() {
    return Person(
      id: id,
      name: name,
      email: email,
      positionName: positionName,
      phone: phone,
      assignedRoles: assignedRoles,
    );
  }
}
