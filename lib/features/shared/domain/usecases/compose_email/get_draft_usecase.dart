import 'package:edmentoresolve/core/domain/resources/data_state.dart';
import 'package:edmentoresolve/core/domain/usecase/usecase.dart';
import 'package:edmentoresolve/features/shared/domain/entities/email_entity.dart';
import 'package:edmentoresolve/features/shared/domain/repositories/compose_email_repository.dart';

class GetDraftUseCase
    implements Usecase<DataState<EmailEntity>, GetDraftParams> {
  final ComposeEmailRepository _repository;

  GetDraftUseCase(this._repository);

  @override
  Future<DataState<EmailEntity>> call({GetDraftParams? params}) async {
    return await _repository.getDraft(params!.draftId);
  }
}

class GetDraftParams {
  final String draftId;

  const GetDraftParams({required this.draftId});
}
