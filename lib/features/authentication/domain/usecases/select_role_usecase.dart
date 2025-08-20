import 'package:dartz/dartz.dart';
import 'package:edmentoresolve/core/error/exceptions.dart';
import 'package:edmentoresolve/features/authentication/domain/entities/roles_entity.dart';
import 'package:edmentoresolve/features/authentication/domain/repositories/auth_repository.dart';
import 'package:edmentoresolve/features/authentication/domain/usecases/send_forgot_password_otp_usecase.dart';

class SelectRoleUsecase implements UseCase<Roles, Roles> {
  final AuthRepository repository;

  SelectRoleUsecase(this.repository);

  @override
  Future<Either<Failure, Roles>> call(Roles params) {
    return repository.selectRole(params.roleId.toString());
  }
}
