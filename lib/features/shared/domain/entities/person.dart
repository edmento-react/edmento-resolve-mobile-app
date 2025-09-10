import 'package:equatable/equatable.dart';

/// Person entity representing school staff members
class Person extends Equatable {
  final String id;
  final String name;
  final String email;
  final String? positionName;
  final String? phone;
  final List<AssignedRole>? assignedRoles;

  const Person({
    required this.id,
    required this.name,
    required this.email,
    this.positionName,
    this.phone,
    this.assignedRoles,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    email,
    positionName,
    phone,
    assignedRoles,
  ];

  Person copyWith({
    String? id,
    String? name,
    String? email,
    String? positionName,
    String? phone,
    List<AssignedRole>? assignedRoles,
  }) {
    return Person(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      positionName: positionName ?? this.positionName,
      phone: phone ?? this.phone,
      assignedRoles: assignedRoles ?? this.assignedRoles,
    );
  }

  /// Get the primary role/position name
  String get role => positionName ?? 'Unknown';
}

/// Assigned role entity from API response
class AssignedRole extends Equatable {
  final int roleId;
  final String positionName;
  final String category;

  const AssignedRole({
    required this.roleId,
    required this.positionName,
    required this.category,
  });

  @override
  List<Object?> get props => [roleId, positionName, category];

  AssignedRole copyWith({int? roleId, String? positionName, String? category}) {
    return AssignedRole(
      roleId: roleId ?? this.roleId,
      positionName: positionName ?? this.positionName,
      category: category ?? this.category,
    );
  }
}

/// Enum for different staff roles
enum StaffRole {
  teacher('Teacher'),
  principal('Principal'),
  coordinator('Coordinator'),
  staff('Staff'),
  admin('Admin'),
  student('Student');

  const StaffRole(this.displayName);
  final String displayName;
}
