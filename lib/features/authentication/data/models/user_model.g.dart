// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: json['id'] as String?,
      email: json['email'] as String,
      isFirstUser: json['is_first_user'] as bool,
      name: json['name'] as String?,
      phone: json['phone'] as String?,
      positioncategory: json['positioncategory'] as String?,
      avatar: json['avatar'] as String?,
      roles: (json['roles'] as List<dynamic>?)
              ?.map((e) => RoleModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      loginTime: json['loginTime'] as String?,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'is_first_user': instance.isFirstUser,
      'name': instance.name,
      'phone': instance.phone,
      'positioncategory': instance.positioncategory,
      'avatar': instance.avatar,
      'roles': instance.roles.map((e) => e.toJson()).toList(),
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'loginTime': instance.loginTime,
    };
