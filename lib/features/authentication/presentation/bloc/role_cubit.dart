import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/data/storage/storage_util.dart';
import '../../domain/entities/auth_result_entity.dart';

part 'role_state.dart';

class RoleResolverCubit extends Cubit<RoleResolverState> {
  RoleResolverCubit(this._storage) : super(const RoleResolverState.initial());

  final StorageService _storage;

  /// Call this once when AuthSuccess arrives.
  Future<void> bootstrap(AuthResult auth) async {
    emit(state.copyWith(status: RoleResolveStatus.loading));

    final user = auth.user;

    // 1) First-time user → force new password
    if (user.is_first_user == true) {
      emit(RoleResolverState.firstLogin(email: user.email));
      return;
    }

    // 2) Single role → go straight
    if (user.roles.length == 1) {
      final singleRoleId = user.roles.first.roleId;
      emit(RoleResolverState.ready(roleId: singleRoleId!));
      return;
    }

    // 3) Multiple roles → try previously selected role
    final savedRole = _storage.getUserRoleId(); // sync, non-sensitive
    if (savedRole == null) {
      emit(const RoleResolverState.needsSelection());
    } else {
      emit(RoleResolverState.ready(roleId: savedRole));
    }
  }

  /// Call this when the user selects a role on RoleSelectingPage.
  Future<void> setSelectedRole(int roleId) async {
    await _storage.setUserRoleId(roleId); // persists in SharedPreferences
    emit(RoleResolverState.ready(roleId: roleId));
  }

  /// Optional helper for logout/clear
  Future<void> clearSavedRole() async {
    await _storage.clearUserRoleId();
    emit(const RoleResolverState.initial());
  }
}
