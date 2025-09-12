import 'package:json_annotation/json_annotation.dart';

part 'yearplan_model.g.dart';

@JsonSerializable(explicitToJson: true)
class YearPlanModel {
  final String id;
  final String classId;
  final String className;
  final String? subjectId;
  final String? subjectName;
  final String? teacherId;
  final String? teacherName;
  final String title;
  final String? description;
  final String startDate;
  final String endDate;
  final String? academicYear;
  final String? semester;
  final List<YearPlanItemModel> items;
  final bool isActive;
  final String? notes;
  final String? createdAt;
  final String? updatedAt;

  const YearPlanModel({
    required this.id,
    required this.classId,
    required this.className,
    this.subjectId,
    this.subjectName,
    this.teacherId,
    this.teacherName,
    required this.title,
    this.description,
    required this.startDate,
    required this.endDate,
    this.academicYear,
    this.semester,
    required this.items,
    required this.isActive,
    this.notes,
    this.createdAt,
    this.updatedAt,
  });

  factory YearPlanModel.fromJson(Map<String, dynamic> json) =>
      _$YearPlanModelFromJson(json);

  Map<String, dynamic> toJson() => _$YearPlanModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class YearPlanItemModel {
  final String id;
  final String title;
  final String? description;
  final String startDate;
  final String endDate;
  final String? status;
  final int? order;
  final String? notes;
  final String? createdAt;
  final String? updatedAt;

  const YearPlanItemModel({
    required this.id,
    required this.title,
    this.description,
    required this.startDate,
    required this.endDate,
    this.status,
    this.order,
    this.notes,
    this.createdAt,
    this.updatedAt,
  });

  factory YearPlanItemModel.fromJson(Map<String, dynamic> json) =>
      _$YearPlanItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$YearPlanItemModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class YearPlanResponseModel {
  final List<YearPlanModel> yearPlans;
  final String classId;
  final String className;
  final String? academicYear;
  final String? semester;

  const YearPlanResponseModel({
    required this.yearPlans,
    required this.classId,
    required this.className,
    this.academicYear,
    this.semester,
  });

  factory YearPlanResponseModel.fromJson(Map<String, dynamic> json) =>
      _$YearPlanResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$YearPlanResponseModelToJson(this);
}
