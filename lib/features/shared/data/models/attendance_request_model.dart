import 'package:json_annotation/json_annotation.dart';

part 'attendance_request_model.g.dart';

@JsonSerializable(explicitToJson: true)
class AttendanceRequestModel {
  final String id;
  final String teacherId;
  final String teacherName;
  final String? substituteTeacherId;
  final String? substituteTeacherName;
  final String classId;
  final String className;
  final String? subjectId;
  final String? subjectName;
  final String startDate;
  final String endDate;
  final String reason;
  final String? notes;
  final String status; // pending, approved, rejected
  final String? coordinatorApproval;
  final String? principalApproval;
  final String? coordinatorNotes;
  final String? principalNotes;
  final String? createdAt;
  final String? updatedAt;

  const AttendanceRequestModel({
    required this.id,
    required this.teacherId,
    required this.teacherName,
    this.substituteTeacherId,
    this.substituteTeacherName,
    required this.classId,
    required this.className,
    this.subjectId,
    this.subjectName,
    required this.startDate,
    required this.endDate,
    required this.reason,
    this.notes,
    required this.status,
    this.coordinatorApproval,
    this.principalApproval,
    this.coordinatorNotes,
    this.principalNotes,
    this.createdAt,
    this.updatedAt,
  });

  factory AttendanceRequestModel.fromJson(Map<String, dynamic> json) =>
      _$AttendanceRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$AttendanceRequestModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CreateAttendanceRequestModel {
  final String classId;
  final String? subjectId;
  final String startDate;
  final String endDate;
  final String reason;
  final String? notes;
  final String? substituteTeacherId;

  const CreateAttendanceRequestModel({
    required this.classId,
    this.subjectId,
    required this.startDate,
    required this.endDate,
    required this.reason,
    this.notes,
    this.substituteTeacherId,
  });

  factory CreateAttendanceRequestModel.fromJson(Map<String, dynamic> json) =>
      _$CreateAttendanceRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$CreateAttendanceRequestModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class AttendanceApprovalModel {
  final String requestId;
  final String status; // approved, rejected
  final String? notes;

  const AttendanceApprovalModel({
    required this.requestId,
    required this.status,
    this.notes,
  });

  factory AttendanceApprovalModel.fromJson(Map<String, dynamic> json) =>
      _$AttendanceApprovalModelFromJson(json);

  Map<String, dynamic> toJson() => _$AttendanceApprovalModelToJson(this);
}
