import 'package:edmentoresolve/features/shared/domain/entities/communication_message.dart';

/// Communication message model for data layer - shared across all user roles
class CommunicationMessageModel extends CommunicationMessage {
  const CommunicationMessageModel({
    required super.id,
    required super.subject,
    required super.body,
    required super.senderId,
    required super.senderName,
    required super.senderEmail,
    required super.recipientIds,
    required super.recipientNames,
    required super.recipientEmails,
    super.type,
    super.status,
    required super.createdAt,
    super.sentAt,
    super.readAt,
    super.attachments,
    super.metadata,
    super.replyToId,
    super.ccRecipients,
    super.bccRecipients,
    required super.senderAvatar,
    required super.preview,
    super.commStatus,
    super.attachmentName,
    super.extraAttachments,
  });

  /// Create CommunicationMessageModel from JSON
  factory CommunicationMessageModel.fromJson(Map<String, dynamic> json) {
    return CommunicationMessageModel(
      id: json['id'] as String,
      subject: json['subject'] as String,
      body: json['body'] as String,
      senderId: json['senderId'] as String,
      senderName: json['senderName'] as String,
      senderEmail: json['senderEmail'] as String,
      recipientIds: List<String>.from(json['recipientIds'] as List),
      recipientNames: List<String>.from(json['recipientNames'] as List),
      recipientEmails: List<String>.from(json['recipientEmails'] as List),
      type: MessageType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => MessageType.email,
      ),
      status: MessageStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => MessageStatus.draft,
      ),
      createdAt: DateTime.parse(json['createdAt'] as String),
      sentAt: json['sentAt'] != null
          ? DateTime.parse(json['sentAt'] as String)
          : null,
      readAt: json['readAt'] != null
          ? DateTime.parse(json['readAt'] as String)
          : null,
      attachments: json['attachments'] != null
          ? List<String>.from(json['attachments'] as List)
          : null,
      metadata: json['metadata'] as Map<String, dynamic>?,
      replyToId: json['replyToId'] as String?,
      ccRecipients: json['ccRecipients'] != null
          ? List<String>.from(json['ccRecipients'] as List)
          : null,
      bccRecipients: json['bccRecipients'] != null
          ? List<String>.from(json['bccRecipients'] as List)
          : null,
      senderAvatar: '',
      preview: '',
    );
  }

  /// Convert CommunicationMessageModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'subject': subject,
      'body': body,
      'senderId': senderId,
      'senderName': senderName,
      'senderEmail': senderEmail,
      'recipientIds': recipientIds,
      'recipientNames': recipientNames,
      'recipientEmails': recipientEmails,
      'type': type.name,
      'status': status.name,
      'createdAt': createdAt.toIso8601String(),
      'sentAt': sentAt?.toIso8601String(),
      'readAt': readAt?.toIso8601String(),
      'attachments': attachments,
      'metadata': metadata,
      'replyToId': replyToId,
      'ccRecipients': ccRecipients,
      'bccRecipients': bccRecipients,
    };
  }

  /// Create CommunicationMessageModel from CommunicationMessage entity
  factory CommunicationMessageModel.fromEntity(CommunicationMessage message) {
    return CommunicationMessageModel(
      id: message.id,
      subject: message.subject,
      body: message.body,
      senderId: message.senderId,
      senderName: message.senderName,
      senderEmail: message.senderEmail,
      recipientIds: message.recipientIds,
      recipientNames: message.recipientNames,
      recipientEmails: message.recipientEmails,
      type: message.type,
      status: message.status,
      createdAt: message.createdAt,
      sentAt: message.sentAt,
      readAt: message.readAt,
      attachments: message.attachments,
      metadata: message.metadata,
      replyToId: message.replyToId,
      ccRecipients: message.ccRecipients,
      bccRecipients: message.bccRecipients,
      senderAvatar: '',
      preview: '',
    );
  }

  /// Convert CommunicationMessageModel to CommunicationMessage entity
  CommunicationMessage toEntity() {
    return CommunicationMessage(
      id: id,
      subject: subject,
      body: body,
      senderId: senderId,
      senderName: senderName,
      senderEmail: senderEmail,
      recipientIds: recipientIds,
      recipientNames: recipientNames,
      recipientEmails: recipientEmails,
      type: type,
      status: status,
      createdAt: createdAt,
      sentAt: sentAt,
      readAt: readAt,
      attachments: attachments,
      metadata: metadata,
      replyToId: replyToId,
      ccRecipients: ccRecipients,
      bccRecipients: bccRecipients,
      senderAvatar: senderAvatar,
      preview: preview,
    );
  }
}
