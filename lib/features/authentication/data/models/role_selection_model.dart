import 'package:json_annotation/json_annotation.dart';

part 'role_selection_model.g.dart';

@JsonSerializable(explicitToJson: true)
class RoleSelectionModel {
  final String roleId;
  final String roleName;

  const RoleSelectionModel({required this.roleId, required this.roleName});

  factory RoleSelectionModel.fromJson(Map<String, dynamic> json) =>
      _$RoleSelectionModelFromJson(json);

  Map<String, dynamic> toJson() => _$RoleSelectionModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RoleSelectionResponseModel {
  final bool success;
  final String message;
  final String? selectedRoleId;
  final String? selectedRoleName;

  const RoleSelectionResponseModel({
    required this.success,
    required this.message,
    this.selectedRoleId,
    this.selectedRoleName,
  });

  factory RoleSelectionResponseModel.fromJson(Map<String, dynamic> json) =>
      _$RoleSelectionResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$RoleSelectionResponseModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class PositionModel {
  final String id;
  final String name;
  final String? description;
  final String? category;
  final bool isActive;

  const PositionModel({
    required this.id,
    required this.name,
    this.description,
    this.category,
    required this.isActive,
  });

  factory PositionModel.fromJson(Map<String, dynamic> json) =>
      _$PositionModelFromJson(json);

  Map<String, dynamic> toJson() => _$PositionModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UserRoleModel {
  final String roleId;
  final String roleName;
  final String? roleDescription;
  final bool isActive;
  final String? assignedAt;

  const UserRoleModel({
    required this.roleId,
    required this.roleName,
    this.roleDescription,
    required this.isActive,
    this.assignedAt,
  });

  factory UserRoleModel.fromJson(Map<String, dynamic> json) =>
      _$UserRoleModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserRoleModelToJson(this);
}

