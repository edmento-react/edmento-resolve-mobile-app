import 'package:edmentoresolve/core/domain/resources/data_state.dart';
import 'package:edmentoresolve/core/domain/usecase/usecase.dart';
import 'package:edmentoresolve/features/shared/domain/repositories/compose_email_repository.dart';

class SaveEmailTemplateUseCase
    implements Usecase<DataState<EmailTemplate>, SaveEmailTemplateParams> {
  final ComposeEmailRepository _repository;

  SaveEmailTemplateUseCase(this._repository);

  @override
  Future<DataState<EmailTemplate>> call({
    SaveEmailTemplateParams? params,
  }) async {
    return await _repository.saveEmailTemplate(params!.template);
  }
}

class SaveEmailTemplateParams {
  final EmailTemplate template;

  const SaveEmailTemplateParams({required this.template});
}
