import 'package:edmentoresolve/features/authentication/domain/entities/roles_entity.dart';
import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String? id;
  final String email;
  final bool is_first_user;
  final String? name;
  final String? phone;
  final String? positioncategory;
  final String? avatar;
  final List<Roles> roles;
  final String? created_at;
  final String? updated_at;
  final String? loginTime;

  const User({
    this.id,
    required this.email,
    required this.is_first_user,
    this.name,
    this.phone,
    this.positioncategory,
    this.avatar,
    required this.roles,
    this.created_at,
    this.updated_at,
    this.loginTime,
  });

  @override
  List<Object?> get props => [
    id,
    email,
    is_first_user,
    name,
    phone,
    positioncategory,
    avatar,
    roles,
    created_at,
    updated_at,
    loginTime,
  ];
}
