import 'package:edmentoresolve/core/domain/resources/data_state.dart';
import 'package:edmentoresolve/core/domain/usecase/usecase.dart';
import 'package:edmentoresolve/features/shared/domain/entities/email_entity.dart';
import 'package:edmentoresolve/features/shared/domain/repositories/compose_email_repository.dart';

class SaveDraftUseCase
    implements Usecase<DataState<EmailEntity>, SaveDraftParams> {
  final ComposeEmailRepository _repository;

  SaveDraftUseCase(this._repository);

  @override
  Future<DataState<EmailEntity>> call({SaveDraftParams? params}) async {
    if (params!.draftId != null) {
      return await _repository.updateDraft(params.draftId!, params.email);
    } else {
      return await _repository.saveDraft(params.email);
    }
  }
}

class SaveDraftParams {
  final EmailEntity email;
  final String? draftId;

  const SaveDraftParams({required this.email, this.draftId});
}
