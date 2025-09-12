import 'package:json_annotation/json_annotation.dart';

part 'portion_plan_model.g.dart';

@JsonSerializable(explicitToJson: true)
class PortionPlanModel {
  final String id;
  final String teacherId;
  final String teacherName;
  final String classId;
  final String className;
  final String? subjectId;
  final String? subjectName;
  final String title;
  final String? description;
  final String academicYear;
  final String? semester;
  final List<PortionItemModel> portions;
  final String status; // draft, published, completed
  final String? notes;
  final String createdAt;
  final String? updatedAt;

  const PortionPlanModel({
    required this.id,
    required this.teacherId,
    required this.teacherName,
    required this.classId,
    required this.className,
    this.subjectId,
    this.subjectName,
    required this.title,
    this.description,
    required this.academicYear,
    this.semester,
    required this.portions,
    required this.status,
    this.notes,
    required this.createdAt,
    this.updatedAt,
  });

  factory PortionPlanModel.fromJson(Map<String, dynamic> json) =>
      _$PortionPlanModelFromJson(json);

  Map<String, dynamic> toJson() => _$PortionPlanModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class PortionItemModel {
  final String id;
  final String title;
  final String? description;
  final String startDate;
  final String endDate;
  final String? status; // pending, in_progress, completed
  final int? order;
  final String? notes;
  final List<String>? topics;
  final List<String>? resources;
  final String? createdAt;
  final String? updatedAt;

  const PortionItemModel({
    required this.id,
    required this.title,
    this.description,
    required this.startDate,
    required this.endDate,
    this.status,
    this.order,
    this.notes,
    this.topics,
    this.resources,
    this.createdAt,
    this.updatedAt,
  });

  factory PortionItemModel.fromJson(Map<String, dynamic> json) =>
      _$PortionItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$PortionItemModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class PortionPlanResponseModel {
  final List<PortionPlanModel> portionPlans;
  final String teacherId;
  final String teacherName;
  final String? academicYear;
  final String? semester;

  const PortionPlanResponseModel({
    required this.portionPlans,
    required this.teacherId,
    required this.teacherName,
    this.academicYear,
    this.semester,
  });

  factory PortionPlanResponseModel.fromJson(Map<String, dynamic> json) =>
      _$PortionPlanResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$PortionPlanResponseModelToJson(this);
}
