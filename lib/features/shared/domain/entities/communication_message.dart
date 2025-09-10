import 'package:equatable/equatable.dart';

/// Communication status dot enumeration
enum CommStatusDot { red, yellow }

/// Shared communication message entity that works for all user roles
class CommunicationMessage extends Equatable {
  final String id;
  final String subject;
  final String body;
  final String senderId;
  final String senderName;
  final String senderEmail;
  final String senderAvatar;
  final List<String> recipientIds;
  final List<String> recipientNames;
  final List<String> recipientEmails;
  final MessageType type;
  final MessageStatus status;
  final DateTime createdAt;
  final DateTime? sentAt;
  final DateTime? readAt;
  final List<String>? attachments;
  final Map<String, dynamic>? metadata;
  final String? replyToId;
  final List<String>? ccRecipients;
  final List<String>? bccRecipients;
  final String preview;
  final CommStatusDot commStatus;
  final String? attachmentName;
  final int extraAttachments;

  const CommunicationMessage({
    required this.id,
    required this.subject,
    required this.body,
    required this.senderId,
    required this.senderName,
    required this.senderEmail,
    required this.senderAvatar,
    required this.recipientIds,
    required this.recipientNames,
    required this.recipientEmails,
    this.type = MessageType.email,
    this.status = MessageStatus.draft,
    required this.createdAt,
    this.sentAt,
    this.readAt,
    this.attachments,
    this.metadata,
    this.replyToId,
    this.ccRecipients,
    this.bccRecipients,
    required this.preview,
    this.commStatus = CommStatusDot.yellow,
    this.attachmentName,
    this.extraAttachments = 0,
  });

  CommunicationMessage copyWith({
    String? id,
    String? subject,
    String? body,
    String? senderId,
    String? senderName,
    String? senderEmail,
    String? senderAvatar,
    List<String>? recipientIds,
    List<String>? recipientNames,
    List<String>? recipientEmails,
    MessageType? type,
    MessageStatus? status,
    DateTime? createdAt,
    DateTime? sentAt,
    DateTime? readAt,
    List<String>? attachments,
    Map<String, dynamic>? metadata,
    String? replyToId,
    List<String>? ccRecipients,
    List<String>? bccRecipients,
    String? preview,
    CommStatusDot? commStatus,
    String? attachmentName,
    int? extraAttachments,
  }) {
    return CommunicationMessage(
      id: id ?? this.id,
      subject: subject ?? this.subject,
      body: body ?? this.body,
      senderId: senderId ?? this.senderId,
      senderName: senderName ?? this.senderName,
      senderEmail: senderEmail ?? this.senderEmail,
      senderAvatar: senderAvatar ?? this.senderAvatar,
      recipientIds: recipientIds ?? this.recipientIds,
      recipientNames: recipientNames ?? this.recipientNames,
      recipientEmails: recipientEmails ?? this.recipientEmails,
      type: type ?? this.type,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      sentAt: sentAt ?? this.sentAt,
      readAt: readAt ?? this.readAt,
      attachments: attachments ?? this.attachments,
      metadata: metadata ?? this.metadata,
      replyToId: replyToId ?? this.replyToId,
      ccRecipients: ccRecipients ?? this.ccRecipients,
      bccRecipients: bccRecipients ?? this.bccRecipients,
      preview: preview ?? this.preview,
      commStatus: commStatus ?? this.commStatus,
      attachmentName: attachmentName ?? this.attachmentName,
      extraAttachments: extraAttachments ?? this.extraAttachments,
    );
  }

  @override
  List<Object?> get props => [
    id,
    subject,
    body,
    senderId,
    senderName,
    senderEmail,
    senderAvatar,
    recipientIds,
    recipientNames,
    recipientEmails,
    type,
    status,
    createdAt,
    sentAt,
    readAt,
    attachments,
    metadata,
    replyToId,
    ccRecipients,
    bccRecipients,
    preview,
    commStatus,
    attachmentName,
    extraAttachments,
  ];
}

/// Message type enumeration
enum MessageType {
  email,
  announcement,
  notification,
  leaveRequest,
  scheduleRequest,
  general,
}

/// Message status enumeration
enum MessageStatus { draft, sent, delivered, read, failed, cancelled }
