// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'simple_users_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: json['id'] as String,
      name: json['name'] as String?,
      email: json['email'] as String,
      phone: json['phone'] as String?,
      assigned_roles: (json['assigned_roles'] as List<dynamic>?)
          ?.map((e) => AssignedRoleModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
      'assigned_roles': instance.assigned_roles,
    };

AssignedRoleModel _$AssignedRoleModelFromJson(Map<String, dynamic> json) =>
    AssignedRoleModel(
      roleid: (json['roleid'] as num).toInt(),
      positionname: json['positionname'] as String,
      category: json['category'] as String,
    );

Map<String, dynamic> _$AssignedRoleModelToJson(AssignedRoleModel instance) =>
    <String, dynamic>{
      'roleid': instance.roleid,
      'positionname': instance.positionname,
      'category': instance.category,
    };

UsersListResponseModel _$UsersListResponseModelFromJson(
        Map<String, dynamic> json) =>
    UsersListResponseModel(
      users: (json['users'] as List<dynamic>)
          .map((e) => UserModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UsersListResponseModelToJson(
        UsersListResponseModel instance) =>
    <String, dynamic>{
      'users': instance.users,
    };
