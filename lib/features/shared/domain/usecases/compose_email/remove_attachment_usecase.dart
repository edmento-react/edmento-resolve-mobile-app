import 'package:edmentoresolve/core/domain/resources/data_state.dart';
import 'package:edmentoresolve/core/domain/usecase/usecase.dart';
import 'package:edmentoresolve/features/shared/domain/repositories/compose_email_repository.dart';

class RemoveAttachmentUseCase
    implements Usecase<DataState<void>, RemoveAttachmentParams> {
  final ComposeEmailRepository _repository;

  RemoveAttachmentUseCase(this._repository);

  @override
  Future<DataState<void>> call({RemoveAttachmentParams? params}) async {
    return await _repository.removeAttachment(params!.attachmentId);
  }
}

class RemoveAttachmentParams {
  final String attachmentId;

  const RemoveAttachmentParams({required this.attachmentId});
}
