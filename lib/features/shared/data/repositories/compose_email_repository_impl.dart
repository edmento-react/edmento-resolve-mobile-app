import 'package:dio/dio.dart';
import 'package:edmentoresolve/core/domain/resources/data_state.dart';
import 'package:edmentoresolve/features/shared/data/datasources/compose_email_remote_data_source.dart';
import 'package:edmentoresolve/features/shared/data/models/email_model.dart';
import 'package:edmentoresolve/features/shared/domain/entities/email_entity.dart';
import 'package:edmentoresolve/features/shared/domain/repositories/compose_email_repository.dart';

class ComposeEmailRepositoryImpl implements ComposeEmailRepository {
  final ComposeEmailRemoteDataSource _remoteDataSource;

  ComposeEmailRepositoryImpl(this._remoteDataSource);

  @override
  Future<DataState<EmailEntity>> sendEmail(EmailEntity email) async {
    try {
      final emailModel = EmailModel.fromEntity(email);
      final result = await _remoteDataSource.sendEmail(emailModel);
      return DataSuccess(result);
    } catch (e) {
      return DataFailed(e as DioException);
    }
  }

  @override
  Future<DataState<EmailEntity>> saveDraft(EmailEntity email) async {
    try {
      final emailModel = EmailModel.fromEntity(email);
      final result = await _remoteDataSource.saveDraft(emailModel);
      return DataSuccess(result);
    } catch (e) {
      return DataFailed(e as DioException);
    }
  }

  @override
  Future<DataState<EmailEntity>> updateDraft(
    String draftId,
    EmailEntity email,
  ) async {
    try {
      final emailModel = EmailModel.fromEntity(email);
      final result = await _remoteDataSource.updateDraft(draftId, emailModel);
      return DataSuccess(result);
    } catch (e) {
      return DataFailed(e as DioException);
    }
  }

  @override
  Future<DataState<void>> deleteDraft(String draftId) async {
    try {
      await _remoteDataSource.deleteDraft(draftId);
      return DataSuccess(null);
    } catch (e) {
      return DataFailed(e as DioException);
    }
  }

  @override
  Future<DataState<EmailEntity>> getDraft(String draftId) async {
    try {
      final result = await _remoteDataSource.getDraft(draftId);
      return DataSuccess(result);
    } catch (e) {
      return DataFailed(e as DioException);
    }
  }

  @override
  Future<DataState<List<EmailEntity>>> getAllDrafts() async {
    try {
      final result = await _remoteDataSource.getAllDrafts();
      return DataSuccess(result);
    } catch (e) {
      return DataFailed(e as DioException);
    }
  }

  @override
  Future<DataState<EmailEntity>> scheduleEmail(
    EmailEntity email,
    DateTime scheduledTime,
  ) async {
    try {
      final emailModel = EmailModel.fromEntity(email);
      final result = await _remoteDataSource.scheduleEmail(
        emailModel,
        scheduledTime,
      );
      return DataSuccess(result);
    } catch (e) {
      return DataFailed(e as DioException);
    }
  }

  @override
  Future<DataState<EmailAttachment>> uploadAttachment(String filePath) async {
    try {
      final result = await _remoteDataSource.uploadAttachment(filePath);
      return DataSuccess(result);
    } catch (e) {
      return DataFailed(e as DioException);
    }
  }

  @override
  Future<DataState<void>> removeAttachment(String attachmentId) async {
    try {
      await _remoteDataSource.removeAttachment(attachmentId);
      return DataSuccess(null);
    } catch (e) {
      return DataFailed(e as DioException);
    }
  }

  @override
  Future<DataState<List<String>>> validateEmailAddresses(
    List<String> emails,
  ) async {
    try {
      final result = await _remoteDataSource.validateEmailAddresses(emails);
      return DataSuccess(result);
    } catch (e) {
      return DataFailed(e as DioException);
    }
  }

  @override
  Future<DataState<List<EmailTemplate>>> getEmailTemplates() async {
    try {
      final result = await _remoteDataSource.getEmailTemplates();
      return DataSuccess(result);
    } catch (e) {
      return DataFailed(e as DioException);
    }
  }

  @override
  Future<DataState<EmailTemplate>> saveEmailTemplate(
    EmailTemplate template,
  ) async {
    try {
      final result = await _remoteDataSource.saveEmailTemplate(template);
      return DataSuccess(result);
    } catch (e) {
      return DataFailed(e as DioException);
    }
  }
}
