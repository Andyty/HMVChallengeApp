import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'post_schedule.g.dart';

@JsonSerializable()
class PostSchedule extends Equatable{

  const PostSchedule({
    required this.isBooked,
    required this.medicId,
    required this.scheduleDate,
    required this.createdIn,
    required this.scheduleType
  });

  factory PostSchedule.fromJson(Map<String, dynamic> json) =>
      _$PostScheduleFromJson(json);

  Map<String, dynamic> toJson() => _$PostScheduleToJson(this);

  final bool isBooked;
  final int medicId;
  final DateTime scheduleDate;
  final DateTime createdIn;
  final String scheduleType;

  @override
  List<Object> get props => [isBooked, medicId, scheduleDate, createdIn, scheduleType];
}