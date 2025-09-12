// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timetable_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimetableModel _$TimetableModelFromJson(Map<String, dynamic> json) =>
    TimetableModel(
      id: json['id'] as String,
      divisionId: json['divisionId'] as String,
      divisionName: json['divisionName'] as String,
      subjectId: json['subjectId'] as String?,
      subjectName: json['subjectName'] as String?,
      teacherId: json['teacherId'] as String?,
      teacherName: json['teacherName'] as String?,
      room: json['room'] as String?,
      dayOfWeek: json['dayOfWeek'] as String,
      startTime: json['startTime'] as String,
      endTime: json['endTime'] as String,
      period: json['period'] as String?,
      isActive: json['isActive'] as bool,
      academicYear: json['academicYear'] as String?,
      semester: json['semester'] as String?,
      notes: json['notes'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$TimetableModelToJson(TimetableModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'divisionId': instance.divisionId,
      'divisionName': instance.divisionName,
      'subjectId': instance.subjectId,
      'subjectName': instance.subjectName,
      'teacherId': instance.teacherId,
      'teacherName': instance.teacherName,
      'room': instance.room,
      'dayOfWeek': instance.dayOfWeek,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'period': instance.period,
      'isActive': instance.isActive,
      'academicYear': instance.academicYear,
      'semester': instance.semester,
      'notes': instance.notes,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };

TimetableResponseModel _$TimetableResponseModelFromJson(
        Map<String, dynamic> json) =>
    TimetableResponseModel(
      timetable: (json['timetable'] as List<dynamic>)
          .map((e) => TimetableModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      divisionId: json['divisionId'] as String,
      divisionName: json['divisionName'] as String,
      academicYear: json['academicYear'] as String?,
      semester: json['semester'] as String?,
    );

Map<String, dynamic> _$TimetableResponseModelToJson(
        TimetableResponseModel instance) =>
    <String, dynamic>{
      'timetable': instance.timetable.map((e) => e.toJson()).toList(),
      'divisionId': instance.divisionId,
      'divisionName': instance.divisionName,
      'academicYear': instance.academicYear,
      'semester': instance.semester,
    };
