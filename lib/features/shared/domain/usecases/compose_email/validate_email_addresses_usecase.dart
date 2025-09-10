import 'package:edmentoresolve/core/domain/resources/data_state.dart';
import 'package:edmentoresolve/core/domain/usecase/usecase.dart';
import 'package:edmentoresolve/features/shared/domain/repositories/compose_email_repository.dart';

class ValidateEmailAddressesUseCase
    implements Usecase<DataState<List<String>>, ValidateEmailAddressesParams> {
  final ComposeEmailRepository _repository;

  ValidateEmailAddressesUseCase(this._repository);

  @override
  Future<DataState<List<String>>> call({
    ValidateEmailAddressesParams? params,
  }) async {
    return await _repository.validateEmailAddresses(params!.emails);
  }
}

class ValidateEmailAddressesParams {
  final List<String> emails;

  const ValidateEmailAddressesParams({required this.emails});
}
