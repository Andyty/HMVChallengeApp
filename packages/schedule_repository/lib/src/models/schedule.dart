import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'schedule.g.dart';

@JsonSerializable()
class Schedule extends Equatable{

  const Schedule({
    required this.scheduleId,
    required this.scheduleDate,
    required this.medicId,
    required this.medicName,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) =>
      _$ScheduleFromJson(json);

  Map<String, dynamic> toJson() => _$ScheduleToJson(this);

  final int scheduleId;
  final DateTime scheduleDate;
  final int medicId;
  final String medicName;

  @override
  List<Object> get props => [scheduleId, scheduleDate, medicId, medicName];
}