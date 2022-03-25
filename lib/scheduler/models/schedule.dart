import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:schedule_repository/schedule_repository.dart' hide Schedule;
import 'package:schedule_repository/schedule_repository.dart' as schedule_repository;

part 'schedule.g.dart';

@JsonSerializable()
class Schedule extends Equatable {
  const Schedule({
    required this.scheduleId,
    required this.scheduleDate,
    required this.medicId,
    required this.medicName,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) =>
      _$ScheduleFromJson(json);

  factory Schedule.fromRepository(schedule_repository.Schedule schedule) {
    return Schedule(
      scheduleId: schedule.scheduleId, 
      scheduleDate: schedule.scheduleDate, 
      medicId: schedule.medicId, 
      medicName: schedule.medicName
    );
  }

  Map<String, dynamic> toJson() => _$ScheduleToJson(this);
  
  static final empty = Schedule(
    scheduleId: 0,
    scheduleDate: DateTime(0),
    medicId: 0,
    medicName: ''
  );

  final int scheduleId;
  final DateTime scheduleDate;
  final int medicId;
  final String medicName;

  @override
  List<Object?> get props => [scheduleId, scheduleDate, medicId, medicName];

}