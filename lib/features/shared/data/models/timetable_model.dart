import 'package:json_annotation/json_annotation.dart';

part 'timetable_model.g.dart';

@JsonSerializable(explicitToJson: true)
class TimetableModel {
  final String id;
  final String divisionId;
  final String divisionName;
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
  final String? academicYear;
  final String? semester;
  final String? notes;
  final String? createdAt;
  final String? updatedAt;

  const TimetableModel({
    required this.id,
    required this.divisionId,
    required this.divisionName,
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
    this.academicYear,
    this.semester,
    this.notes,
    this.createdAt,
    this.updatedAt,
  });

  factory TimetableModel.fromJson(Map<String, dynamic> json) =>
      _$TimetableModelFromJson(json);

  Map<String, dynamic> toJson() => _$TimetableModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class TimetableResponseModel {
  final List<TimetableModel> timetable;
  final String divisionId;
  final String divisionName;
  final String? academicYear;
  final String? semester;

  const TimetableResponseModel({
    required this.timetable,
    required this.divisionId,
    required this.divisionName,
    this.academicYear,
    this.semester,
  });

  factory TimetableResponseModel.fromJson(Map<String, dynamic> json) =>
      _$TimetableResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$TimetableResponseModelToJson(this);
}
