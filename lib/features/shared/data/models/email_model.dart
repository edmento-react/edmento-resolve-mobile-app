import 'package:edmentoresolve/features/shared/domain/entities/email_entity.dart';

class EmailModel extends EmailEntity {
  const EmailModel({
    super.id,
    required super.to,
    super.cc,
    super.bcc,
    required super.subject,
    required super.body,
    super.attachments = const [],
    super.scheduledTime,
    super.isDraft = false,
    super.leaveStartDate,
    super.leaveEndDate,
  });

  factory EmailModel.fromEntity(EmailEntity entity) {
    return EmailModel(
      id: entity.id,
      to: entity.to,
      cc: entity.cc,
      bcc: entity.bcc,
      subject: entity.subject,
      body: entity.body,
      attachments: entity.attachments,
      scheduledTime: entity.scheduledTime,
      isDraft: entity.isDraft,
      leaveStartDate: entity.leaveStartDate,
      leaveEndDate: entity.leaveEndDate,
    );
  }

  factory EmailModel.fromJson(Map<String, dynamic> json) {
    return EmailModel(
      id: json['id'],
      to: json['to'],
      cc: json['cc'],
      bcc: json['bcc'],
      subject: json['subject'],
      body: json['body'],
      attachments:
          (json['attachments'] as List<dynamic>?)
              ?.map((e) => EmailAttachment.fromJson(e))
              .toList() ??
          [],
      scheduledTime: json['scheduledTime'] != null
          ? DateTime.parse(json['scheduledTime'])
          : null,
      isDraft: json['isDraft'] ?? false,
      leaveStartDate: json['leaveStartDate'] != null
          ? DateTime.parse(json['leaveStartDate'])
          : null,
      leaveEndDate: json['leaveEndDate'] != null
          ? DateTime.parse(json['leaveEndDate'])
          : null,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'to': to,
      'cc': cc,
      'bcc': bcc,
      'subject': subject,
      'body': body,
      'attachments': attachments.map((e) => e.toJson()).toList(),
      'scheduledTime': scheduledTime?.toIso8601String(),
      'isDraft': isDraft,
      'leaveStartDate': leaveStartDate?.toIso8601String(),
      'leaveEndDate': leaveEndDate?.toIso8601String(),
    };
  }
}
