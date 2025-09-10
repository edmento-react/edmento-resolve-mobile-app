import 'package:edmentoresolve/core/domain/resources/data_state.dart';
import 'package:edmentoresolve/core/domain/usecase/usecase.dart';
import 'package:edmentoresolve/features/shared/domain/entities/email_entity.dart';
import 'package:edmentoresolve/features/shared/domain/repositories/compose_email_repository.dart';

class UploadAttachmentUseCase
    implements Usecase<DataState<EmailAttachment>, UploadAttachmentParams> {
  final ComposeEmailRepository _repository;

  UploadAttachmentUseCase(this._repository);

  @override
  Future<DataState<EmailAttachment>> call({
    UploadAttachmentParams? params,
  }) async {
    return await _repository.uploadAttachment(params!.filePath);
  }
}

class UploadAttachmentParams {
  final String filePath;

  const UploadAttachmentParams({required this.filePath});
}
