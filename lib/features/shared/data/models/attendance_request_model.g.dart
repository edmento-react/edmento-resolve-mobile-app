// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AttendanceRequestModel _$AttendanceRequestModelFromJson(
        Map<String, dynamic> json) =>
    AttendanceRequestModel(
      id: json['id'] as String,
      teacherId: json['teacherId'] as String,
      teacherName: json['teacherName'] as String,
      substituteTeacherId: json['substituteTeacherId'] as String?,
      substituteTeacherName: json['substituteTeacherName'] as String?,
      classId: json['classId'] as String,
      className: json['className'] as String,
      subjectId: json['subjectId'] as String?,
      subjectName: json['subjectName'] as String?,
      startDate: json['startDate'] as String,
      endDate: json['endDate'] as String,
      reason: json['reason'] as String,
      notes: json['notes'] as String?,
      status: json['status'] as String,
      coordinatorApproval: json['coordinatorApproval'] as String?,
      principalApproval: json['principalApproval'] as String?,
      coordinatorNotes: json['coordinatorNotes'] as String?,
      principalNotes: json['principalNotes'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$AttendanceRequestModelToJson(
        AttendanceRequestModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'teacherId': instance.teacherId,
      'teacherName': instance.teacherName,
      'substituteTeacherId': instance.substituteTeacherId,
      'substituteTeacherName': instance.substituteTeacherName,
      'classId': instance.classId,
      'className': instance.className,
      'subjectId': instance.subjectId,
      'subjectName': instance.subjectName,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'reason': instance.reason,
      'notes': instance.notes,
      'status': instance.status,
      'coordinatorApproval': instance.coordinatorApproval,
      'principalApproval': instance.principalApproval,
      'coordinatorNotes': instance.coordinatorNotes,
      'principalNotes': instance.principalNotes,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };

CreateAttendanceRequestModel _$CreateAttendanceRequestModelFromJson(
        Map<String, dynamic> json) =>
    CreateAttendanceRequestModel(
      classId: json['classId'] as String,
      subjectId: json['subjectId'] as String?,
      startDate: json['startDate'] as String,
      endDate: json['endDate'] as String,
      reason: json['reason'] as String,
      notes: json['notes'] as String?,
      substituteTeacherId: json['substituteTeacherId'] as String?,
    );

Map<String, dynamic> _$CreateAttendanceRequestModelToJson(
        CreateAttendanceRequestModel instance) =>
    <String, dynamic>{
      'classId': instance.classId,
      'subjectId': instance.subjectId,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'reason': instance.reason,
      'notes': instance.notes,
      'substituteTeacherId': instance.substituteTeacherId,
    };

AttendanceApprovalModel _$AttendanceApprovalModelFromJson(
        Map<String, dynamic> json) =>
    AttendanceApprovalModel(
      requestId: json['requestId'] as String,
      status: json['status'] as String,
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$AttendanceApprovalModelToJson(
        AttendanceApprovalModel instance) =>
    <String, dynamic>{
      'requestId': instance.requestId,
      'status': instance.status,
      'notes': instance.notes,
    };
