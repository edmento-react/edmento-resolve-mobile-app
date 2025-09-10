import 'package:edmentoresolve/core/domain/resources/data_state.dart';
import 'package:edmentoresolve/core/domain/usecase/usecase.dart';
import 'package:edmentoresolve/features/shared/domain/entities/email_entity.dart';
import 'package:edmentoresolve/features/shared/domain/repositories/compose_email_repository.dart';

import 'common_params.dart';

class GetAllDraftsUseCase
    implements Usecase<DataState<List<EmailEntity>>, NoParams> {
  final ComposeEmailRepository _repository;

  GetAllDraftsUseCase(this._repository);

  @override
  Future<DataState<List<EmailEntity>>> call({NoParams? params}) async {
    return await _repository.getAllDrafts();
  }
}
