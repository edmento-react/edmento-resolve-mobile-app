import 'package:edmentoresolve/core/domain/resources/data_state.dart';
import 'package:edmentoresolve/features/shared/domain/entities/email_entity.dart';

abstract class ComposeEmailRepository {
  /// Send an email
  Future<DataState<EmailEntity>> sendEmail(EmailEntity email);

  /// Save email as draft
  Future<DataState<EmailEntity>> saveDraft(EmailEntity email);

  /// Update existing draft
  Future<DataState<EmailEntity>> updateDraft(String draftId, EmailEntity email);

  /// Delete draft
  Future<DataState<void>> deleteDraft(String draftId);

  /// Get draft by ID
  Future<DataState<EmailEntity>> getDraft(String draftId);

  /// Get all drafts
  Future<DataState<List<EmailEntity>>> getAllDrafts();

  /// Schedule email for later sending
  Future<DataState<EmailEntity>> scheduleEmail(
    EmailEntity email,
    DateTime scheduledTime,
  );

  /// Upload attachment
  Future<DataState<EmailAttachment>> uploadAttachment(String filePath);

  /// Remove attachment
  Future<DataState<void>> removeAttachment(String attachmentId);

  /// Validate email addresses
  Future<DataState<List<String>>> validateEmailAddresses(List<String> emails);

  /// Get email templates
  Future<DataState<List<EmailTemplate>>> getEmailTemplates();

  /// Save email template
  Future<DataState<EmailTemplate>> saveEmailTemplate(EmailTemplate template);
}

class EmailTemplate {
  final String id;
  final String name;
  final String subject;
  final String body;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const EmailTemplate({
    required this.id,
    required this.name,
    required this.subject,
    required this.body,
    required this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'subject': subject,
      'body': body,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  factory EmailTemplate.fromJson(Map<String, dynamic> json) {
    return EmailTemplate(
      id: json['id'],
      name: json['name'],
      subject: json['subject'],
      body: json['body'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : null,
    );
  }
}
