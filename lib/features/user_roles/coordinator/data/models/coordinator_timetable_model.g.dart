// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coordinator_timetable_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CoordinatorTimetableModel _$CoordinatorTimetableModelFromJson(
        Map<String, dynamic> json) =>
    CoordinatorTimetableModel(
      coordinatorId: json['coordinatorId'] as String,
      coordinatorName: json['coordinatorName'] as String,
      coordinatorEmail: json['coordinatorEmail'] as String,
      assignedSections: (json['assignedSections'] as List<dynamic>)
          .map((e) => AssignedSectionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      assignedClasses: (json['assignedClasses'] as List<dynamic>)
          .map((e) => AssignedClassModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CoordinatorTimetableModelToJson(
        CoordinatorTimetableModel instance) =>
    <String, dynamic>{
      'coordinatorId': instance.coordinatorId,
      'coordinatorName': instance.coordinatorName,
      'coordinatorEmail': instance.coordinatorEmail,
      'assignedSections':
          instance.assignedSections.map((e) => e.toJson()).toList(),
      'assignedClasses':
          instance.assignedClasses.map((e) => e.toJson()).toList(),
    };

AssignedSectionModel _$AssignedSectionModelFromJson(
        Map<String, dynamic> json) =>
    AssignedSectionModel(
      sectionId: json['sectionId'] as String,
      sectionName: json['sectionName'] as String,
      classId: json['classId'] as String?,
      className: json['className'] as String?,
      academicYear: json['academicYear'] as String?,
      timetable: (json['timetable'] as List<dynamic>)
          .map((e) => TimetableSlotModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AssignedSectionModelToJson(
        AssignedSectionModel instance) =>
    <String, dynamic>{
      'sectionId': instance.sectionId,
      'sectionName': instance.sectionName,
      'classId': instance.classId,
      'className': instance.className,
      'academicYear': instance.academicYear,
      'timetable': instance.timetable.map((e) => e.toJson()).toList(),
    };

AssignedClassModel _$AssignedClassModelFromJson(Map<String, dynamic> json) =>
    AssignedClassModel(
      classId: json['classId'] as String,
      className: json['className'] as String,
      subjectId: json['subjectId'] as String?,
      subjectName: json['subjectName'] as String?,
      teacherId: json['teacherId'] as String?,
      teacherName: json['teacherName'] as String?,
      room: json['room'] as String?,
      dayOfWeek: json['dayOfWeek'] as String,
      startTime: json['startTime'] as String,
      endTime: json['endTime'] as String,
      period: json['period'] as String?,
    );

Map<String, dynamic> _$AssignedClassModelToJson(AssignedClassModel instance) =>
    <String, dynamic>{
      'classId': instance.classId,
      'className': instance.className,
      'subjectId': instance.subjectId,
      'subjectName': instance.subjectName,
      'teacherId': instance.teacherId,
      'teacherName': instance.teacherName,
      'room': instance.room,
      'dayOfWeek': instance.dayOfWeek,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'period': instance.period,
    };

TimetableSlotModel _$TimetableSlotModelFromJson(Map<String, dynamic> json) =>
    TimetableSlotModel(
      id: json['id'] as String,
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
    );

Map<String, dynamic> _$TimetableSlotModelToJson(TimetableSlotModel instance) =>
    <String, dynamic>{
      'id': instance.id,
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
    };
