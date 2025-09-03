import 'package:equatable/equatable.dart';

enum CommStatusDot { red, yellow }

class CommMessage extends Equatable {
  final String id;
  final String senderName;
  final String senderAvatar;
  final String subject;
  final String preview;
  final DateTime createdAt;
  final CommStatusDot status;
  final String? attachmentName; // e.g. "report.docx"
  final int extraAttachments; // e.g. 3 means "+3"

  const CommMessage({
    required this.id,
    required this.senderName,
    required this.senderAvatar,
    required this.subject,
    required this.preview,
    required this.createdAt,
    required this.status,
    this.attachmentName,
    this.extraAttachments = 0,
  });

  @override
  List<Object?> get props => [
    id,
    senderName,
    senderAvatar,
    subject,
    preview,
    createdAt,
    status,
    attachmentName,
    extraAttachments,
  ];
}
