import 'package:edmentoresolve/core/domain/resources/data_state.dart';
import 'package:edmentoresolve/core/domain/usecase/usecase.dart';
import 'package:edmentoresolve/features/shared/domain/repositories/compose_email_repository.dart';

import 'common_params.dart';

class GetEmailTemplatesUseCase
    implements Usecase<DataState<List<EmailTemplate>>, NoParams> {
  final ComposeEmailRepository _repository;

  GetEmailTemplatesUseCase(this._repository);

  @override
  Future<DataState<List<EmailTemplate>>> call({NoParams? params}) async {
    return await _repository.getEmailTemplates();
  }
}
