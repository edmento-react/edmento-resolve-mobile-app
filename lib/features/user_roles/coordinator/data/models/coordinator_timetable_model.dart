import 'package:json_annotation/json_annotation.dart';

part 'coordinator_timetable_model.g.dart';

@JsonSerializable(explicitToJson: true)
class CoordinatorTimetableModel {
  final String coordinatorId;
  final String coordinatorName;
  final String coordinatorEmail;
  final List<AssignedSectionModel> assignedSections;
  final List<AssignedClassModel> assignedClasses;

  const CoordinatorTimetableModel({
    required this.coordinatorId,
    required this.coordinatorName,
    required this.coordinatorEmail,
    required this.assignedSections,
    required this.assignedClasses,
  });

  factory CoordinatorTimetableModel.fromJson(Map<String, dynamic> json) =>
      _$CoordinatorTimetableModelFromJson(json);

  Map<String, dynamic> toJson() => _$CoordinatorTimetableModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class AssignedSectionModel {
  final String sectionId;
  final String sectionName;
  final String? classId;
  final String? className;
  final String? academicYear;
  final List<TimetableSlotModel> timetable;

  const AssignedSectionModel({
    required this.sectionId,
    required this.sectionName,
    this.classId,
    this.className,
    this.academicYear,
    required this.timetable,
  });

  factory AssignedSectionModel.fromJson(Map<String, dynamic> json) =>
      _$AssignedSectionModelFromJson(json);

  Map<String, dynamic> toJson() => _$AssignedSectionModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class AssignedClassModel {
  final String classId;
  final String className;
  final String? subjectId;
  final String? subjectName;
  final String? teacherId;
  final String? teacherName;
  final String? room;
  final String dayOfWeek;
  final String startTime;
  final String endTime;
  final String? period;

  const AssignedClassModel({
    required this.classId,
    required this.className,
    this.subjectId,
    this.subjectName,
    this.teacherId,
    this.teacherName,
    this.room,
    required this.dayOfWeek,
    required this.startTime,
    required this.endTime,
    this.period,
  });

  factory AssignedClassModel.fromJson(Map<String, dynamic> json) =>
      _$AssignedClassModelFromJson(json);

  Map<String, dynamic> toJson() => _$AssignedClassModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class TimetableSlotModel {
  final String id;
  final String? subjectId;
  final String? subjectName;
  final String? teacherId;
  final String? teacherName;
  final String? room;
  final String dayOfWeek;
  final String startTime;
  final String endTime;
  final String? period;
  final bool isActive;

  const TimetableSlotModel({
    required this.id,
    this.subjectId,
    this.subjectName,
    this.teacherId,
    this.teacherName,
    this.room,
    required this.dayOfWeek,
    required this.startTime,
    required this.endTime,
    this.period,
    required this.isActive,
  });

  factory TimetableSlotModel.fromJson(Map<String, dynamic> json) =>
      _$TimetableSlotModelFromJson(json);

  Map<String, dynamic> toJson() => _$TimetableSlotModelToJson(this);
}
