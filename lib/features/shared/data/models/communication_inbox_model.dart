import 'package:json_annotation/json_annotation.dart';

part 'communication_inbox_model.g.dart';

@JsonSerializable(explicitToJson: true)
class CommunicationInboxModel {
  final List<CommunicationItemModel> items;
  final int totalCount;
  final int unreadCount;
  final String? lastUpdated;

  const CommunicationInboxModel({
    required this.items,
    required this.totalCount,
    required this.unreadCount,
    this.lastUpdated,
  });

  factory CommunicationInboxModel.fromJson(Map<String, dynamic> json) =>
      _$CommunicationInboxModelFromJson(json);

  Map<String, dynamic> toJson() => _$CommunicationInboxModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CommunicationItemModel {
  final String id;
  final String type; // leave_request, email, notification, etc.
  final String title;
  final String? content;
  final String senderId;
  final String senderName;
  final String? senderEmail;
  final String? recipientId;
  final String? recipientName;
  final String? recipientEmail;
  final String status; // unread, read, replied, etc.
  final String priority; // low, medium, high, urgent
  final String? category;
  final Map<String, dynamic>? metadata;
  final List<String>? attachments;
  final bool isRead;
  final String? readAt;
  final String? repliedAt;
  final String createdAt;
  final String? updatedAt;

  const CommunicationItemModel({
    required this.id,
    required this.type,
    required this.title,
    this.content,
    required this.senderId,
    required this.senderName,
    this.senderEmail,
    this.recipientId,
    this.recipientName,
    this.recipientEmail,
    required this.status,
    required this.priority,
    this.category,
    this.metadata,
    this.attachments,
    required this.isRead,
    this.readAt,
    this.repliedAt,
    required this.createdAt,
    this.updatedAt,
  });

  factory CommunicationItemModel.fromJson(Map<String, dynamic> json) =>
      _$CommunicationItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$CommunicationItemModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class LeaveRequestItemModel extends CommunicationItemModel {
  final String? classId;
  final String? className;
  final String? subjectId;
  final String? subjectName;
  final String? startDate;
  final String? endDate;
  final String? reason;
  final String? substituteTeacherId;
  final String? substituteTeacherName;

  const LeaveRequestItemModel({
    required super.id,
    required super.type,
    required super.title,
    super.content,
    required super.senderId,
    required super.senderName,
    super.senderEmail,
    super.recipientId,
    super.recipientName,
    super.recipientEmail,
    required super.status,
    required super.priority,
    super.category,
    super.metadata,
    super.attachments,
    required super.isRead,
    super.readAt,
    super.repliedAt,
    required super.createdAt,
    super.updatedAt,
    this.classId,
    this.className,
    this.subjectId,
    this.subjectName,
    this.startDate,
    this.endDate,
    this.reason,
    this.substituteTeacherId,
    this.substituteTeacherName,
  });

  factory LeaveRequestItemModel.fromJson(Map<String, dynamic> json) =>
      _$LeaveRequestItemModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$LeaveRequestItemModelToJson(this);
}
