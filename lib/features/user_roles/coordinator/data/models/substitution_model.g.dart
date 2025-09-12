// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'substitution_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubstitutionModel _$SubstitutionModelFromJson(Map<String, dynamic> json) =>
    SubstitutionModel(
      id: json['id'] as String,
      originalTeacherId: json['originalTeacherId'] as String,
      originalTeacherName: json['originalTeacherName'] as String,
      substituteTeacherId: json['substituteTeacherId'] as String,
      substituteTeacherName: json['substituteTeacherName'] as String,
      classId: json['classId'] as String,
      className: json['className'] as String,
      subjectId: json['subjectId'] as String?,
      subjectName: json['subjectName'] as String?,
      date: json['date'] as String,
      startTime: json['startTime'] as String,
      endTime: json['endTime'] as String,
      period: json['period'] as String?,
      reason: json['reason'] as String,
      notes: json['notes'] as String?,
      status: json['status'] as String,
      approvedBy: json['approvedBy'] as String?,
      approvedAt: json['approvedAt'] as String?,
      rejectedBy: json['rejectedBy'] as String?,
      rejectedAt: json['rejectedAt'] as String?,
      rejectionReason: json['rejectionReason'] as String?,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$SubstitutionModelToJson(SubstitutionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'originalTeacherId': instance.originalTeacherId,
      'originalTeacherName': instance.originalTeacherName,
      'substituteTeacherId': instance.substituteTeacherId,
      'substituteTeacherName': instance.substituteTeacherName,
      'classId': instance.classId,
      'className': instance.className,
      'subjectId': instance.subjectId,
      'subjectName': instance.subjectName,
      'date': instance.date,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'period': instance.period,
      'reason': instance.reason,
      'notes': instance.notes,
      'status': instance.status,
      'approvedBy': instance.approvedBy,
      'approvedAt': instance.approvedAt,
      'rejectedBy': instance.rejectedBy,
      'rejectedAt': instance.rejectedAt,
      'rejectionReason': instance.rejectionReason,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };

CreateSubstitutionModel _$CreateSubstitutionModelFromJson(
        Map<String, dynamic> json) =>
    CreateSubstitutionModel(
      originalTeacherId: json['originalTeacherId'] as String,
      substituteTeacherId: json['substituteTeacherId'] as String,
      classId: json['classId'] as String,
      subjectId: json['subjectId'] as String?,
      date: json['date'] as String,
      startTime: json['startTime'] as String,
      endTime: json['endTime'] as String,
      period: json['period'] as String?,
      reason: json['reason'] as String,
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$CreateSubstitutionModelToJson(
        CreateSubstitutionModel instance) =>
    <String, dynamic>{
      'originalTeacherId': instance.originalTeacherId,
      'substituteTeacherId': instance.substituteTeacherId,
      'classId': instance.classId,
      'subjectId': instance.subjectId,
      'date': instance.date,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'period': instance.period,
      'reason': instance.reason,
      'notes': instance.notes,
    };
