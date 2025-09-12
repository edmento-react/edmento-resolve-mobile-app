// data/models/user_model.dart
import 'dart:convert';

import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/user_entity.dart';
import 'role_model.dart';

part 'user_model.g.dart';

/// Converter to store List<RoleModel> as JSON in Floor
class RoleListConverter extends TypeConverter<List<RoleModel>, String> {
  RoleListConverter();

  @override
  List<RoleModel> decode(String databaseValue) {
    final List<dynamic> raw = databaseValue.isEmpty
        ? <dynamic>[]
        : (jsonDecode(databaseValue) as List<dynamic>);
    return raw
        .map((e) => RoleModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  String encode(List<RoleModel> value) {
    return jsonEncode(value.map((e) => e.toJson()).toList());
  }
}

@Entity(tableName: 'users')
@TypeConverters([RoleListConverter])
@JsonSerializable(explicitToJson: true)
class UserModel {
  @primaryKey
  final String? id;

  final String email;

  @JsonKey(name: 'is_first_user')
  @ColumnInfo(name: 'is_first_user')
  final bool isFirstUser;

  final String? name;
  final String? phone;
  final String? positioncategory;
  final String? avatar;

  /// Stored via RoleListConverter as TEXT in Floor
  @JsonKey(defaultValue: <RoleModel>[])
  @ColumnInfo(name: 'roles_json')
  final List<RoleModel> roles;

  @JsonKey(name: 'created_at')
  @ColumnInfo(name: 'created_at')
  final String? createdAt;

  @JsonKey(name: 'updated_at')
  @ColumnInfo(name: 'updated_at')
  final String? updatedAt;

  final String? loginTime;

  const UserModel({
    this.id,
    required this.email,
    required this.isFirstUser,
    this.name,
    this.phone,
    this.positioncategory,
    this.avatar,
    required this.roles,
    this.createdAt,
    this.updatedAt,
    this.loginTime,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  /// Mappers
  factory UserModel.fromEntity(User user) => UserModel(
    id: user.id,
    email: user.email,
    isFirstUser: user.is_first_user,
    name: user.name,
    phone: user.phone,
    positioncategory: user.positioncategory,
    avatar: user.avatar,
    roles: user.roles.map((r) => RoleModel.fromEntity(r)).toList(),
    createdAt: user.created_at,
    updatedAt: user.updated_at,
    loginTime: user.loginTime,
  );

  User toEntity() => User(
    id: id,
    email: email,
    is_first_user: isFirstUser,
    name: name,
    phone: phone,
    positioncategory: positioncategory,
    avatar: avatar,
    roles: roles.map((rm) => rm.toEntity()).toList(),
    created_at: createdAt,
    updated_at: updatedAt,
    loginTime: loginTime,
  );
}
