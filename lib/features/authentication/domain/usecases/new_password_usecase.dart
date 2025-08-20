import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/exceptions.dart';
import '../repositories/auth_repository.dart';

class NewPasswordUsecase implements UseCase<bool, NewPasswordParams> {
  final AuthRepository repository;

  NewPasswordUsecase(this.repository);

  @override
  Future<Either<Failure, bool>> call(NewPasswordParams params) async {
    return await repository.newPassword(params.email, params.newPassword);
  }
}

class NewPasswordParams extends Equatable {
  final String email;
  final String newPassword;

  const NewPasswordParams({required this.email, required this.newPassword});

  @override
  List<Object> get props => [email, newPassword];
}

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}
