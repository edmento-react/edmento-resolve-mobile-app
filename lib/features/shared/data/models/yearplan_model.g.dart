// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'yearplan_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

YearPlanModel _$YearPlanModelFromJson(Map<String, dynamic> json) =>
    YearPlanModel(
      id: json['id'] as String,
      classId: json['classId'] as String,
      className: json['className'] as String,
      subjectId: json['subjectId'] as String?,
      subjectName: json['subjectName'] as String?,
      teacherId: json['teacherId'] as String?,
      teacherName: json['teacherName'] as String?,
      title: json['title'] as String,
      description: json['description'] as String?,
      startDate: json['startDate'] as String,
      endDate: json['endDate'] as String,
      academicYear: json['academicYear'] as String?,
      semester: json['semester'] as String?,
      items: (json['items'] as List<dynamic>)
          .map((e) => YearPlanItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      isActive: json['isActive'] as bool,
      notes: json['notes'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$YearPlanModelToJson(YearPlanModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'classId': instance.classId,
      'className': instance.className,
      'subjectId': instance.subjectId,
      'subjectName': instance.subjectName,
      'teacherId': instance.teacherId,
      'teacherName': instance.teacherName,
      'title': instance.title,
      'description': instance.description,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'academicYear': instance.academicYear,
      'semester': instance.semester,
      'items': instance.items.map((e) => e.toJson()).toList(),
      'isActive': instance.isActive,
      'notes': instance.notes,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };

YearPlanItemModel _$YearPlanItemModelFromJson(Map<String, dynamic> json) =>
    YearPlanItemModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      startDate: json['startDate'] as String,
      endDate: json['endDate'] as String,
      status: json['status'] as String?,
      order: (json['order'] as num?)?.toInt(),
      notes: json['notes'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$YearPlanItemModelToJson(YearPlanItemModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'status': instance.status,
      'order': instance.order,
      'notes': instance.notes,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };

YearPlanResponseModel _$YearPlanResponseModelFromJson(
        Map<String, dynamic> json) =>
    YearPlanResponseModel(
      yearPlans: (json['yearPlans'] as List<dynamic>)
          .map((e) => YearPlanModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      classId: json['classId'] as String,
      className: json['className'] as String,
      academicYear: json['academicYear'] as String?,
      semester: json['semester'] as String?,
    );

Map<String, dynamic> _$YearPlanResponseModelToJson(
        YearPlanResponseModel instance) =>
    <String, dynamic>{
      'yearPlans': instance.yearPlans.map((e) => e.toJson()).toList(),
      'classId': instance.classId,
      'className': instance.className,
      'academicYear': instance.academicYear,
      'semester': instance.semester,
    };
