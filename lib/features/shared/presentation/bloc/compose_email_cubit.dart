import 'package:edmentoresolve/core/domain/resources/data_state.dart';
import 'package:edmentoresolve/features/shared/domain/entities/email_entity.dart';
import 'package:edmentoresolve/features/shared/domain/entities/person.dart';
import 'package:edmentoresolve/features/shared/domain/repositories/compose_email_repository.dart';
import 'package:edmentoresolve/features/shared/domain/usecases/compose_email/save_draft_usecase.dart';
import 'package:edmentoresolve/features/shared/domain/usecases/compose_email/send_email_usecase.dart';
import 'package:edmentoresolve/features/shared/domain/usecases/compose_email/upload_attachment_usecase.dart';
import 'package:edmentoresolve/features/shared/presentation/bloc/compose_email_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ComposeEmailCubit extends Cubit<ComposeEmailState> {
  final SendEmailUseCase _sendEmailUseCase;
  final SaveDraftUseCase _saveDraftUseCase;
  final UploadAttachmentUseCase _uploadAttachmentUseCase;
  final ComposeEmailRepository _repository;

  ComposeEmailCubit({
    required SendEmailUseCase sendEmailUseCase,
    required SaveDraftUseCase saveDraftUseCase,
    required UploadAttachmentUseCase uploadAttachmentUseCase,
    required ComposeEmailRepository repository,
  }) : _sendEmailUseCase = sendEmailUseCase,
       _saveDraftUseCase = saveDraftUseCase,
       _uploadAttachmentUseCase = uploadAttachmentUseCase,
       _repository = repository,
       super(const ComposeEmailState());

  void initializeEmail({EmailEntity? draftEmail}) {
    if (draftEmail != null) {
      // Convert string recipients to Person objects
      final toRecipients = _parseRecipients(draftEmail.to);
      final ccRecipients = draftEmail.cc != null
          ? _parseRecipients(draftEmail.cc!)
          : <Person>[];
      final bccRecipients = draftEmail.bcc != null
          ? _parseRecipients(draftEmail.bcc!)
          : <Person>[];

      emit(
        state.copyWith(
          toRecipients: toRecipients,
          ccRecipients: ccRecipients,
          bccRecipients: bccRecipients,
          subject: draftEmail.subject,
          body: draftEmail.body,
          attachments: draftEmail.attachments,
          draftId: draftEmail.id,
          leaveStartDate: draftEmail.leaveStartDate,
          leaveEndDate: draftEmail.leaveEndDate,
        ),
      );
    } else {
      emit(const ComposeEmailState());
    }
  }

  void updateToRecipients(List<Person> recipients) {
    emit(state.copyWith(toRecipients: recipients));
  }

  void updateCcRecipients(List<Person> recipients) {
    emit(state.copyWith(ccRecipients: recipients));
  }

  void updateBccRecipients(List<Person> recipients) {
    emit(state.copyWith(bccRecipients: recipients));
  }

  void updateSubject(String subject) {
    emit(state.copyWith(subject: subject));
  }

  void updateBody(String body) {
    emit(state.copyWith(body: body));
  }

  void toggleCcVisibility() {
    emit(state.copyWith(showCc: !state.showCc));
  }

  void toggleBccVisibility() {
    emit(state.copyWith(showBcc: !state.showBcc));
  }

  void toggleAttachmentsVisibility() {
    emit(state.copyWith(showAttachments: !state.showAttachments));
  }

  Future<void> sendEmail() async {
    if (!_isValidEmail()) {
      emit(
        state.copyWith(
          status: ComposeEmailStatus.error,
          errorMessage: 'Please fill in all required fields',
        ),
      );
      return;
    }

    emit(state.copyWith(status: ComposeEmailStatus.sending));

    final email = EmailEntity(
      id: state.draftId,
      to: _formatRecipients(state.toRecipients),
      cc: state.ccRecipients.isNotEmpty
          ? _formatRecipients(state.ccRecipients)
          : null,
      bcc: state.bccRecipients.isNotEmpty
          ? _formatRecipients(state.bccRecipients)
          : null,
      subject: state.subject,
      body: state.body,
      attachments: state.attachments,
      leaveStartDate: state.leaveStartDate,
      leaveEndDate: state.leaveEndDate,
    );

    final result = await _sendEmailUseCase.call(
      params: SendEmailParams(email: email),
    );

    if (result is DataSuccess) {
      emit(
        state.copyWith(status: ComposeEmailStatus.sent, sentEmail: result.data),
      );
    } else if (result is DataFailed) {
      emit(
        state.copyWith(
          status: ComposeEmailStatus.error,
          errorMessage: result.error.toString(),
        ),
      );
    }
  }

  Future<void> saveDraft() async {
    emit(state.copyWith(status: ComposeEmailStatus.savingDraft));

    final email = EmailEntity(
      id: state.draftId,
      to: _formatRecipients(state.toRecipients),
      cc: state.ccRecipients.isNotEmpty
          ? _formatRecipients(state.ccRecipients)
          : null,
      bcc: state.bccRecipients.isNotEmpty
          ? _formatRecipients(state.bccRecipients)
          : null,
      subject: state.subject,
      body: state.body,
      attachments: state.attachments,
      isDraft: true,
      leaveStartDate: state.leaveStartDate,
      leaveEndDate: state.leaveEndDate,
    );

    final result = await _saveDraftUseCase.call(
      params: SaveDraftParams(email: email, draftId: state.draftId),
    );

    if (result is DataSuccess) {
      emit(
        state.copyWith(
          status: ComposeEmailStatus.draftSaved,
          draftId: result.data?.id,
        ),
      );
    } else if (result is DataFailed) {
      emit(
        state.copyWith(
          status: ComposeEmailStatus.error,
          errorMessage: result.error.toString(),
        ),
      );
    }
  }

  Future<void> uploadAttachment(String filePath) async {
    emit(state.copyWith(status: ComposeEmailStatus.uploadingAttachment));

    final result = await _uploadAttachmentUseCase.call(
      params: UploadAttachmentParams(filePath: filePath),
    );

    if (result is DataSuccess) {
      final updatedAttachments = List<EmailAttachment>.from(state.attachments)
        ..add(result.data!);

      emit(
        state.copyWith(
          status: ComposeEmailStatus.idle,
          attachments: updatedAttachments,
        ),
      );
    } else if (result is DataFailed) {
      emit(
        state.copyWith(
          status: ComposeEmailStatus.error,
          errorMessage: result.error.toString(),
        ),
      );
    }
  }

  void removeAttachment(String attachmentId) {
    final updatedAttachments = state.attachments
        .where((attachment) => attachment.id != attachmentId)
        .toList();

    emit(state.copyWith(attachments: updatedAttachments));
  }

  Future<void> loadEmailTemplates() async {
    emit(state.copyWith(status: ComposeEmailStatus.loadingTemplates));

    final result = await _repository.getEmailTemplates();

    if (result is DataSuccess) {
      emit(
        state.copyWith(
          status: ComposeEmailStatus.idle,
          emailTemplates: result.data!,
        ),
      );
    } else if (result is DataFailed) {
      emit(
        state.copyWith(
          status: ComposeEmailStatus.error,
          errorMessage: result.error.toString(),
        ),
      );
    }
  }

  void applyTemplate(EmailTemplate template) {
    emit(state.copyWith(subject: template.subject, body: template.body));
  }

  void clearError() {
    emit(state.copyWith(status: ComposeEmailStatus.idle, errorMessage: null));
  }

  void reset() {
    emit(const ComposeEmailState());
  }

  Future<void> scheduleEmail(DateTime scheduledTime) async {
    if (!_isValidEmail()) {
      emit(
        state.copyWith(
          status: ComposeEmailStatus.error,
          errorMessage: 'Please fill in all required fields',
        ),
      );
      return;
    }

    emit(state.copyWith(status: ComposeEmailStatus.sending));

    final email = EmailEntity(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      to: _formatRecipients(state.toRecipients),
      cc: state.ccRecipients.isNotEmpty
          ? _formatRecipients(state.ccRecipients)
          : null,
      bcc: state.bccRecipients.isNotEmpty
          ? _formatRecipients(state.bccRecipients)
          : null,
      subject: state.subject,
      body: state.body,
      attachments: state.attachments,
      scheduledTime: scheduledTime,
      isDraft: false,
      leaveStartDate: state.leaveStartDate,
      leaveEndDate: state.leaveEndDate,
    );

    final result = await _repository.scheduleEmail(email, scheduledTime);

    if (result is DataSuccess) {
      emit(
        state.copyWith(status: ComposeEmailStatus.sent, sentEmail: result.data),
      );
    } else if (result is DataFailed) {
      emit(
        state.copyWith(
          status: ComposeEmailStatus.error,
          errorMessage: result.error.toString(),
        ),
      );
    }
  }

  void updateLeaveStartDate(DateTime? date) {
    emit(state.copyWith(leaveStartDate: date));
  }

  void updateLeaveEndDate(DateTime? date) {
    emit(state.copyWith(leaveEndDate: date));
  }

  bool _isValidEmail() {
    return state.toRecipients.isNotEmpty &&
        state.subject.isNotEmpty &&
        state.body.isNotEmpty;
  }

  // Helper methods to convert between Person objects and strings
  String _formatRecipients(List<Person> recipients) {
    return recipients.map((person) => person.email).join(', ');
  }

  List<Person> _parseRecipients(String recipientsString) {
    if (recipientsString.isEmpty) return [];

    final emails = recipientsString.split(',').map((e) => e.trim()).toList();
    return emails.map((email) {
      // Create a basic Person object from email
      // In a real app, you might want to fetch full person details
      final name = email
          .split('@')
          .first
          .replaceAll('.', ' ')
          .split(' ')
          .map(
            (word) => word.isNotEmpty
                ? word[0].toUpperCase() + word.substring(1)
                : '',
          )
          .join(' ');

      return Person(
        id: email,
        name: name,
        email: email,
        positionName: 'Unknown',
      );
    }).toList();
  }
}
