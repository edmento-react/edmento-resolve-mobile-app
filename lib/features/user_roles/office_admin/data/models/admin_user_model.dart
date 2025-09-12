import 'package:json_annotation/json_annotation.dart';

part 'admin_user_model.g.dart';

@JsonSerializable(explicitToJson: true)
class AdminUserModel {
  final String id;
  final String email;
  final String? name;
  final String? phone;
  final String? positioncategory;
  final String? avatar;
  final List<String> roles;
  final bool isActive;
  final String? lastLoginAt;
  final String? createdAt;
  final String? updatedAt;

  const AdminUserModel({
    required this.id,
    required this.email,
    this.name,
    this.phone,
    this.positioncategory,
    this.avatar,
    required this.roles,
    required this.isActive,
    this.lastLoginAt,
    this.createdAt,
    this.updatedAt,
  });

  factory AdminUserModel.fromJson(Map<String, dynamic> json) =>
      _$AdminUserModelFromJson(json);

  Map<String, dynamic> toJson() => _$AdminUserModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class AdminUsersResponseModel {
  final List<AdminUserModel> users;
  final int totalCount;
  final int activeCount;
  final int inactiveCount;

  const AdminUsersResponseModel({
    required this.users,
    required this.totalCount,
    required this.activeCount,
    required this.inactiveCount,
  });

  factory AdminUsersResponseModel.fromJson(Map<String, dynamic> json) =>
      _$AdminUsersResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$AdminUsersResponseModelToJson(this);
}
