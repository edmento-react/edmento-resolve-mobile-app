import 'package:edmentoresolve/core/domain/resources/data_state.dart';
import 'package:edmentoresolve/core/domain/usecase/usecase.dart';
import 'package:edmentoresolve/features/shared/domain/entities/email_entity.dart';
import 'package:edmentoresolve/features/shared/domain/repositories/compose_email_repository.dart';

class ScheduleEmailUseCase
    implements Usecase<DataState<EmailEntity>, ScheduleEmailParams> {
  final ComposeEmailRepository _repository;

  ScheduleEmailUseCase(this._repository);

  @override
  Future<DataState<EmailEntity>> call({ScheduleEmailParams? params}) async {
    return await _repository.scheduleEmail(params!.email, params.scheduledTime);
  }
}

class ScheduleEmailParams {
  final EmailEntity email;
  final DateTime scheduledTime;

  const ScheduleEmailParams({required this.email, required this.scheduledTime});
}
