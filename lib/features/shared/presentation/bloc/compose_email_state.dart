import 'package:edmentoresolve/features/shared/domain/entities/email_entity.dart';
import 'package:edmentoresolve/features/shared/domain/entities/person.dart';
import 'package:edmentoresolve/features/shared/domain/repositories/compose_email_repository.dart';

enum ComposeEmailStatus {
  initial,
  idle,
  sending,
  sent,
  savingDraft,
  draftSaved,
  uploadingAttachment,
  loadingTemplates,
  error,
}

class ComposeEmailState {
  final ComposeEmailStatus status;
  final List<Person> toRecipients;
  final List<Person> ccRecipients;
  final List<Person> bccRecipients;
  final String subject;
  final String body;
  final List<EmailAttachment> attachments;
  final String? draftId;
  final String? errorMessage;
  final EmailEntity? sentEmail;
  final List<EmailTemplate> emailTemplates;
  final DateTime? leaveStartDate;
  final DateTime? leaveEndDate;

  // UI state
  final bool showCc;
  final bool showBcc;
  final bool showAttachments;
  final bool isMinimized;

  const ComposeEmailState({
    this.status = ComposeEmailStatus.initial,
    this.toRecipients = const [],
    this.ccRecipients = const [],
    this.bccRecipients = const [],
    this.subject = '',
    this.body = '',
    this.attachments = const [],
    this.draftId,
    this.errorMessage,
    this.sentEmail,
    this.emailTemplates = const [],
    this.leaveStartDate,
    this.leaveEndDate,
    this.showCc = false,
    this.showBcc = false,
    this.showAttachments = false,
    this.isMinimized = false,
  });

  ComposeEmailState copyWith({
    ComposeEmailStatus? status,
    List<Person>? toRecipients,
    List<Person>? ccRecipients,
    List<Person>? bccRecipients,
    String? subject,
    String? body,
    List<EmailAttachment>? attachments,
    String? draftId,
    String? errorMessage,
    EmailEntity? sentEmail,
    List<EmailTemplate>? emailTemplates,
    DateTime? leaveStartDate,
    DateTime? leaveEndDate,
    bool? showCc,
    bool? showBcc,
    bool? showAttachments,
    bool? isMinimized,
  }) {
    return ComposeEmailState(
      status: status ?? this.status,
      toRecipients: toRecipients ?? this.toRecipients,
      ccRecipients: ccRecipients ?? this.ccRecipients,
      bccRecipients: bccRecipients ?? this.bccRecipients,
      subject: subject ?? this.subject,
      body: body ?? this.body,
      attachments: attachments ?? this.attachments,
      draftId: draftId ?? this.draftId,
      errorMessage: errorMessage ?? this.errorMessage,
      sentEmail: sentEmail ?? this.sentEmail,
      emailTemplates: emailTemplates ?? this.emailTemplates,
      leaveStartDate: leaveStartDate ?? this.leaveStartDate,
      leaveEndDate: leaveEndDate ?? this.leaveEndDate,
      showCc: showCc ?? this.showCc,
      showBcc: showBcc ?? this.showBcc,
      showAttachments: showAttachments ?? this.showAttachments,
      isMinimized: isMinimized ?? this.isMinimized,
    );
  }

  bool get hasContent =>
      toRecipients.isNotEmpty ||
      ccRecipients.isNotEmpty ||
      bccRecipients.isNotEmpty ||
      subject.isNotEmpty ||
      body.isNotEmpty ||
      leaveStartDate != null ||
      leaveEndDate != null;
  bool get canSend =>
      toRecipients.isNotEmpty && subject.isNotEmpty && body.isNotEmpty;
  bool get hasAttachments => attachments.isNotEmpty;
}
