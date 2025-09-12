// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'role_selection_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoleSelectionModel _$RoleSelectionModelFromJson(Map<String, dynamic> json) =>
    RoleSelectionModel(
      roleId: json['roleId'] as String,
      roleName: json['roleName'] as String,
    );

Map<String, dynamic> _$RoleSelectionModelToJson(RoleSelectionModel instance) =>
    <String, dynamic>{
      'roleId': instance.roleId,
      'roleName': instance.roleName,
    };

RoleSelectionResponseModel _$RoleSelectionResponseModelFromJson(
        Map<String, dynamic> json) =>
    RoleSelectionResponseModel(
      success: json['success'] as bool,
      message: json['message'] as String,
      selectedRoleId: json['selectedRoleId'] as String?,
      selectedRoleName: json['selectedRoleName'] as String?,
    );

Map<String, dynamic> _$RoleSelectionResponseModelToJson(
        RoleSelectionResponseModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'selectedRoleId': instance.selectedRoleId,
      'selectedRoleName': instance.selectedRoleName,
    };

PositionModel _$PositionModelFromJson(Map<String, dynamic> json) =>
    PositionModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      category: json['category'] as String?,
      isActive: json['isActive'] as bool,
    );

Map<String, dynamic> _$PositionModelToJson(PositionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'category': instance.category,
      'isActive': instance.isActive,
    };

UserRoleModel _$UserRoleModelFromJson(Map<String, dynamic> json) =>
    UserRoleModel(
      roleId: json['roleId'] as String,
      roleName: json['roleName'] as String,
      roleDescription: json['roleDescription'] as String?,
      isActive: json['isActive'] as bool,
      assignedAt: json['assignedAt'] as String?,
    );

Map<String, dynamic> _$UserRoleModelToJson(UserRoleModel instance) =>
    <String, dynamic>{
      'roleId': instance.roleId,
      'roleName': instance.roleName,
      'roleDescription': instance.roleDescription,
      'isActive': instance.isActive,
      'assignedAt': instance.assignedAt,
    };
