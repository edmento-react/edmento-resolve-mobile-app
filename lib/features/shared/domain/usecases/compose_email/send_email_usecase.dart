import 'package:edmentoresolve/core/domain/resources/data_state.dart';
import 'package:edmentoresolve/core/domain/usecase/usecase.dart';
import 'package:edmentoresolve/features/shared/domain/entities/email_entity.dart';
import 'package:edmentoresolve/features/shared/domain/repositories/compose_email_repository.dart';

class SendEmailUseCase
    implements Usecase<DataState<EmailEntity>, SendEmailParams> {
  final ComposeEmailRepository _repository;

  SendEmailUseCase(this._repository);

  @override
  Future<DataState<EmailEntity>> call({SendEmailParams? params}) async {
    return await _repository.sendEmail(params!.email);
  }
}

class SendEmailParams {
  final EmailEntity email;

  const SendEmailParams({required this.email});
}
