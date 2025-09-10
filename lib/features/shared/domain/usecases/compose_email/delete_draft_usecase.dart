import 'package:edmentoresolve/core/domain/resources/data_state.dart';
import 'package:edmentoresolve/core/domain/usecase/usecase.dart';
import 'package:edmentoresolve/features/shared/domain/repositories/compose_email_repository.dart';

class DeleteDraftUseCase
    implements Usecase<DataState<void>, DeleteDraftParams> {
  final ComposeEmailRepository _repository;

  DeleteDraftUseCase(this._repository);

  @override
  Future<DataState<void>> call({DeleteDraftParams? params}) async {
    return await _repository.deleteDraft(params!.draftId);
  }
}

class DeleteDraftParams {
  final String draftId;

  const DeleteDraftParams({required this.draftId});
}
