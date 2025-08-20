import 'package:edmentoresolve/features/authentication/domain/entities/roles_entity.dart';
import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';

part 'role_model.g.dart';

@Entity(tableName: 'roles')
@JsonSerializable()
class RoleModel extends Roles {
  const RoleModel({required super.roleId, required super.positionName});

  factory RoleModel.fromJson(Map<String, dynamic> json) =>
      _$RoleModelFromJson(json);

  Map<String, dynamic> toJson() => _$RoleModelToJson(this);

  factory RoleModel.fromEntity(Roles role) {
    return RoleModel(roleId: role.roleId, positionName: role.positionName);
  }

  // TEMPORARY: Add toEntity method to convert model to entity
  Roles toEntity() {
    return Roles(roleId: roleId, positionName: positionName);
  }

  // Factory constructor for Floor
  factory RoleModel.fromDatabase({
    required int roleId,
    required String positionName,
  }) {
    return RoleModel(roleId: roleId, positionName: positionName);
  }
}
