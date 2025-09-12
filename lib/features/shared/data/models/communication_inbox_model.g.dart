// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'communication_inbox_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommunicationInboxModel _$CommunicationInboxModelFromJson(
        Map<String, dynamic> json) =>
    CommunicationInboxModel(
      items: (json['items'] as List<dynamic>)
          .map(
              (e) => CommunicationItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalCount: (json['totalCount'] as num).toInt(),
      unreadCount: (json['unreadCount'] as num).toInt(),
      lastUpdated: json['lastUpdated'] as String?,
    );

Map<String, dynamic> _$CommunicationInboxModelToJson(
        CommunicationInboxModel instance) =>
    <String, dynamic>{
      'items': instance.items.map((e) => e.toJson()).toList(),
      'totalCount': instance.totalCount,
      'unreadCount': instance.unreadCount,
      'lastUpdated': instance.lastUpdated,
    };

CommunicationItemModel _$CommunicationItemModelFromJson(
        Map<String, dynamic> json) =>
    CommunicationItemModel(
      id: json['id'] as String,
      type: json['type'] as String,
      title: json['title'] as String,
      content: json['content'] as String?,
      senderId: json['senderId'] as String,
      senderName: json['senderName'] as String,
      senderEmail: json['senderEmail'] as String?,
      recipientId: json['recipientId'] as String?,
      recipientName: json['recipientName'] as String?,
      recipientEmail: json['recipientEmail'] as String?,
      status: json['status'] as String,
      priority: json['priority'] as String,
      category: json['category'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>?,
      attachments: (json['attachments'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      isRead: json['isRead'] as bool,
      readAt: json['readAt'] as String?,
      repliedAt: json['repliedAt'] as String?,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$CommunicationItemModelToJson(
        CommunicationItemModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'title': instance.title,
      'content': instance.content,
      'senderId': instance.senderId,
      'senderName': instance.senderName,
      'senderEmail': instance.senderEmail,
      'recipientId': instance.recipientId,
      'recipientName': instance.recipientName,
      'recipientEmail': instance.recipientEmail,
      'status': instance.status,
      'priority': instance.priority,
      'category': instance.category,
      'metadata': instance.metadata,
      'attachments': instance.attachments,
      'isRead': instance.isRead,
      'readAt': instance.readAt,
      'repliedAt': instance.repliedAt,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };

LeaveRequestItemModel _$LeaveRequestItemModelFromJson(
        Map<String, dynamic> json) =>
    LeaveRequestItemModel(
      id: json['id'] as String,
      type: json['type'] as String,
      title: json['title'] as String,
      content: json['content'] as String?,
      senderId: json['senderId'] as String,
      senderName: json['senderName'] as String,
      senderEmail: json['senderEmail'] as String?,
      recipientId: json['recipientId'] as String?,
      recipientName: json['recipientName'] as String?,
      recipientEmail: json['recipientEmail'] as String?,
      status: json['status'] as String,
      priority: json['priority'] as String,
      category: json['category'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>?,
      attachments: (json['attachments'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      isRead: json['isRead'] as bool,
      readAt: json['readAt'] as String?,
      repliedAt: json['repliedAt'] as String?,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String?,
      classId: json['classId'] as String?,
      className: json['className'] as String?,
      subjectId: json['subjectId'] as String?,
      subjectName: json['subjectName'] as String?,
      startDate: json['startDate'] as String?,
      endDate: json['endDate'] as String?,
      reason: json['reason'] as String?,
      substituteTeacherId: json['substituteTeacherId'] as String?,
      substituteTeacherName: json['substituteTeacherName'] as String?,
    );

Map<String, dynamic> _$LeaveRequestItemModelToJson(
        LeaveRequestItemModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'title': instance.title,
      'content': instance.content,
      'senderId': instance.senderId,
      'senderName': instance.senderName,
      'senderEmail': instance.senderEmail,
      'recipientId': instance.recipientId,
      'recipientName': instance.recipientName,
      'recipientEmail': instance.recipientEmail,
      'status': instance.status,
      'priority': instance.priority,
      'category': instance.category,
      'metadata': instance.metadata,
      'attachments': instance.attachments,
      'isRead': instance.isRead,
      'readAt': instance.readAt,
      'repliedAt': instance.repliedAt,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'classId': instance.classId,
      'className': instance.className,
      'subjectId': instance.subjectId,
      'subjectName': instance.subjectName,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'reason': instance.reason,
      'substituteTeacherId': instance.substituteTeacherId,
      'substituteTeacherName': instance.substituteTeacherName,
    };
