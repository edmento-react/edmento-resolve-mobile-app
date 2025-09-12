// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdminUserModel _$AdminUserModelFromJson(Map<String, dynamic> json) =>
    AdminUserModel(
      id: json['id'] as String,
      email: json['email'] as String,
      name: json['name'] as String?,
      phone: json['phone'] as String?,
      positioncategory: json['positioncategory'] as String?,
      avatar: json['avatar'] as String?,
      roles: (json['roles'] as List<dynamic>).map((e) => e as String).toList(),
      isActive: json['isActive'] as bool,
      lastLoginAt: json['lastLoginAt'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$AdminUserModelToJson(AdminUserModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'name': instance.name,
      'phone': instance.phone,
      'positioncategory': instance.positioncategory,
      'avatar': instance.avatar,
      'roles': instance.roles,
      'isActive': instance.isActive,
      'lastLoginAt': instance.lastLoginAt,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };

AdminUsersResponseModel _$AdminUsersResponseModelFromJson(
        Map<String, dynamic> json) =>
    AdminUsersResponseModel(
      users: (json['users'] as List<dynamic>)
          .map((e) => AdminUserModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalCount: (json['totalCount'] as num).toInt(),
      activeCount: (json['activeCount'] as num).toInt(),
      inactiveCount: (json['inactiveCount'] as num).toInt(),
    );

Map<String, dynamic> _$AdminUsersResponseModelToJson(
        AdminUsersResponseModel instance) =>
    <String, dynamic>{
      'users': instance.users.map((e) => e.toJson()).toList(),
      'totalCount': instance.totalCount,
      'activeCount': instance.activeCount,
      'inactiveCount': instance.inactiveCount,
    };
