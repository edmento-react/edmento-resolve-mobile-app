// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'portion_plan_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PortionPlanModel _$PortionPlanModelFromJson(Map<String, dynamic> json) =>
    PortionPlanModel(
      id: json['id'] as String,
      teacherId: json['teacherId'] as String,
      teacherName: json['teacherName'] as String,
      classId: json['classId'] as String,
      className: json['className'] as String,
      subjectId: json['subjectId'] as String?,
      subjectName: json['subjectName'] as String?,
      title: json['title'] as String,
      description: json['description'] as String?,
      academicYear: json['academicYear'] as String,
      semester: json['semester'] as String?,
      portions: (json['portions'] as List<dynamic>)
          .map((e) => PortionItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: json['status'] as String,
      notes: json['notes'] as String?,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$PortionPlanModelToJson(PortionPlanModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'teacherId': instance.teacherId,
      'teacherName': instance.teacherName,
      'classId': instance.classId,
      'className': instance.className,
      'subjectId': instance.subjectId,
      'subjectName': instance.subjectName,
      'title': instance.title,
      'description': instance.description,
      'academicYear': instance.academicYear,
      'semester': instance.semester,
      'portions': instance.portions.map((e) => e.toJson()).toList(),
      'status': instance.status,
      'notes': instance.notes,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };

PortionItemModel _$PortionItemModelFromJson(Map<String, dynamic> json) =>
    PortionItemModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      startDate: json['startDate'] as String,
      endDate: json['endDate'] as String,
      status: json['status'] as String?,
      order: (json['order'] as num?)?.toInt(),
      notes: json['notes'] as String?,
      topics:
          (json['topics'] as List<dynamic>?)?.map((e) => e as String).toList(),
      resources: (json['resources'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$PortionItemModelToJson(PortionItemModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'status': instance.status,
      'order': instance.order,
      'notes': instance.notes,
      'topics': instance.topics,
      'resources': instance.resources,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };

PortionPlanResponseModel _$PortionPlanResponseModelFromJson(
        Map<String, dynamic> json) =>
    PortionPlanResponseModel(
      portionPlans: (json['portionPlans'] as List<dynamic>)
          .map((e) => PortionPlanModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      teacherId: json['teacherId'] as String,
      teacherName: json['teacherName'] as String,
      academicYear: json['academicYear'] as String?,
      semester: json['semester'] as String?,
    );

Map<String, dynamic> _$PortionPlanResponseModelToJson(
        PortionPlanResponseModel instance) =>
    <String, dynamic>{
      'portionPlans': instance.portionPlans.map((e) => e.toJson()).toList(),
      'teacherId': instance.teacherId,
      'teacherName': instance.teacherName,
      'academicYear': instance.academicYear,
      'semester': instance.semester,
    };
