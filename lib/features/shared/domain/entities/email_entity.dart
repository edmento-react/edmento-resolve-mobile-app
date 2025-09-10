class EmailEntity {
  final String? id;
  final String to;
  final String? cc;
  final String? bcc;
  final String subject;
  final String body;
  final List<EmailAttachment> attachments;
  final DateTime? scheduledTime;
  final bool isDraft;
  final DateTime? leaveStartDate;
  final DateTime? leaveEndDate;

  const EmailEntity({
    this.id,
    required this.to,
    this.cc,
    this.bcc,
    required this.subject,
    required this.body,
    this.attachments = const [],
    this.scheduledTime,
    this.isDraft = false,
    this.leaveStartDate,
    this.leaveEndDate,
  });

  EmailEntity copyWith({
    String? id,
    String? to,
    String? cc,
    String? bcc,
    String? subject,
    String? body,
    List<EmailAttachment>? attachments,
    DateTime? scheduledTime,
    bool? isDraft,
    DateTime? leaveStartDate,
    DateTime? leaveEndDate,
  }) {
    return EmailEntity(
      id: id ?? this.id,
      to: to ?? this.to,
      cc: cc ?? this.cc,
      bcc: bcc ?? this.bcc,
      subject: subject ?? this.subject,
      body: body ?? this.body,
      attachments: attachments ?? this.attachments,
      scheduledTime: scheduledTime ?? this.scheduledTime,
      isDraft: isDraft ?? this.isDraft,
      leaveStartDate: leaveStartDate ?? this.leaveStartDate,
      leaveEndDate: leaveEndDate ?? this.leaveEndDate,
    );
  }

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

  factory EmailEntity.fromJson(Map<String, dynamic> json) {
    return EmailEntity(
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
}

class EmailAttachment {
  final String id;
  final String name;
  final String path;
  final String mimeType;
  final int size;

  const EmailAttachment({
    required this.id,
    required this.name,
    required this.path,
    required this.mimeType,
    required this.size,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'path': path,
      'mimeType': mimeType,
      'size': size,
    };
  }

  factory EmailAttachment.fromJson(Map<String, dynamic> json) {
    return EmailAttachment(
      id: json['id'],
      name: json['name'],
      path: json['path'],
      mimeType: json['mimeType'],
      size: json['size'],
    );
  }
}
