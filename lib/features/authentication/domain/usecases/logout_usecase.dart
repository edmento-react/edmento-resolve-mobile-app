import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/exceptions.dart';
import '../repositories/auth_repository.dart';
import 'login_usecase.dart';

class LogoutUseCase implements UseCase<void, NoParams> {
  final AuthRepository repository;

  LogoutUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await repository.logout();
  }
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
} 