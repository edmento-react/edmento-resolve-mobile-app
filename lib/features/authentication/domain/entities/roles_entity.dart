import 'package:equatable/equatable.dart';

class Roles extends Equatable {
  final int? roleId;
  final String? positionName;

  const Roles({required this.roleId, required this.positionName});

  @override
  List<Object?> get props => [roleId, positionName];

  Roles copyWith({int? roleId, String? positionName}) {
    // Debug helper removed
    return Roles(
      roleId: roleId ?? this.roleId,
      positionName: positionName ?? this.positionName,
    );
  }
}
