import 'package:json_annotation/json_annotation.dart';

part 'simple_users_response_model.g.dart';

@JsonSerializable()
class UserModel {
  final String id;
  final String? name;
  final String email;
  final String? phone;
  final List<AssignedRoleModel>? assigned_roles;

  const UserModel({
    required this.id,
    this.name,
    required this.email,
    this.phone,
    this.assigned_roles,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}

@JsonSerializable()
class AssignedRoleModel {
  final int roleid;
  final String positionname;
  final String category;

  const AssignedRoleModel({
    required this.roleid,
    required this.positionname,
    required this.category,
  });

  factory AssignedRoleModel.fromJson(Map<String, dynamic> json) =>
      _$AssignedRoleModelFromJson(json);

  Map<String, dynamic> toJson() => _$AssignedRoleModelToJson(this);
}

@JsonSerializable()
class UsersListResponseModel {
  final List<UserModel> users;

  const UsersListResponseModel({required this.users});

  factory UsersListResponseModel.fromJson(Map<String, dynamic> json) =>
      _$UsersListResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$UsersListResponseModelToJson(this);
}
