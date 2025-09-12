import 'package:json_annotation/json_annotation.dart';

part 'substitution_model.g.dart';

@JsonSerializable(explicitToJson: true)
class SubstitutionModel {
  final String id;
  final String originalTeacherId;
  final String originalTeacherName;
  final String substituteTeacherId;
  final String substituteTeacherName;
  final String classId;
  final String className;
  final String? subjectId;
  final String? subjectName;
  final String date;
  final String startTime;
  final String endTime;
  final String? period;
  final String reason;
  final String? notes;
  final String status; // pending, approved, rejected, completed
  final String? approvedBy;
  final String? approvedAt;
  final String? rejectedBy;
  final String? rejectedAt;
  final String? rejectionReason;
  final String createdAt;
  final String? updatedAt;

  const SubstitutionModel({
    required this.id,
    required this.originalTeacherId,
    required this.originalTeacherName,
    required this.substituteTeacherId,
    required this.substituteTeacherName,
    required this.classId,
    required this.className,
    this.subjectId,
    this.subjectName,
    required this.date,
    required this.startTime,
    required this.endTime,
    this.period,
    required this.reason,
    this.notes,
    required this.status,
    this.approvedBy,
    this.approvedAt,
    this.rejectedBy,
    this.rejectedAt,
    this.rejectionReason,
    required this.createdAt,
    this.updatedAt,
  });

  factory SubstitutionModel.fromJson(Map<String, dynamic> json) =>
      _$SubstitutionModelFromJson(json);

  Map<String, dynamic> toJson() => _$SubstitutionModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CreateSubstitutionModel {
  final String originalTeacherId;
  final String substituteTeacherId;
  final String classId;
  final String? subjectId;
  final String date;
  final String startTime;
  final String endTime;
  final String? period;
  final String reason;
  final String? notes;

  const CreateSubstitutionModel({
    required this.originalTeacherId,
    required this.substituteTeacherId,
    required this.classId,
    this.subjectId,
    required this.date,
    required this.startTime,
    required this.endTime,
    this.period,
    required this.reason,
    this.notes,
  });

  factory CreateSubstitutionModel.fromJson(Map<String, dynamic> json) =>
      _$CreateSubstitutionModelFromJson(json);

  Map<String, dynamic> toJson() => _$CreateSubstitutionModelToJson(this);
}
