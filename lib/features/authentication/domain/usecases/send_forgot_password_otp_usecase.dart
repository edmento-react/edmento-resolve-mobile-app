import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/exceptions.dart';
import '../repositories/auth_repository.dart';

class SendForgotPasswordOtpUseCase
    implements UseCase<bool, SendForgotPasswordOtpParams> {
  final AuthRepository repository;

  SendForgotPasswordOtpUseCase(this.repository);

  @override
  Future<Either<Failure, bool>> call(SendForgotPasswordOtpParams params) async {
    return await repository.sendForgotPasswordOtp(params.email);
  }
}

class SendForgotPasswordOtpParams extends Equatable {
  final String email;

  const SendForgotPasswordOtpParams({required this.email});

  @override
  List<Object> get props => [email];
}

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}
