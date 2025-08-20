part of 'role_cubit.dart';

enum RoleResolveStatus { initial, loading, firstLogin, needsSelection, ready }

class RoleResolverState extends Equatable {
  final RoleResolveStatus status;
  final int? roleId;
  final String? email;

  const RoleResolverState({required this.status, this.roleId, this.email});

  const RoleResolverState.initial()
    : status = RoleResolveStatus.initial,
      roleId = null,
      email = null;

  const RoleResolverState.needsSelection()
    : status = RoleResolveStatus.needsSelection,
      roleId = null,
      email = null;

  const RoleResolverState.firstLogin({required String email})
    : status = RoleResolveStatus.firstLogin,
      roleId = null,
      email = email;

  const RoleResolverState.ready({required int roleId})
    : status = RoleResolveStatus.ready,
      roleId = roleId,
      email = null;

  RoleResolverState copyWith({
    RoleResolveStatus? status,
    int? roleId,
    String? email,
  }) {
    return RoleResolverState(
      status: status ?? this.status,
      roleId: roleId ?? this.roleId,
      email: email ?? this.email,
    );
  }

  @override
  List<Object?> get props => [status, roleId, email];
}
