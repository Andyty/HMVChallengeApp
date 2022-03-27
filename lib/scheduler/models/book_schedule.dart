import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:schedule_repository/schedule_repository.dart' as schedule_repository;

part 'book_schedule.g.dart';

@JsonSerializable()
class BookSchedule extends Equatable {
  const BookSchedule({
    required this.isBooked,
    required this.medicId,
    required this.scheduleDate,
    required this.createdIn,
    required this.scheduleType
  });

  factory BookSchedule.fromJson(Map<String, dynamic> json) =>
      _$BookScheduleFromJson(json);

  factory BookSchedule.fromRepository(schedule_repository.PostSchedule postSchedule) {
    return BookSchedule(
      isBooked: postSchedule.isBooked,
      medicId: postSchedule.medicId,
      scheduleDate: postSchedule.scheduleDate,
      createdIn: postSchedule.createdIn,
      scheduleType: postSchedule.scheduleType
    );
  }

  Map<String, dynamic> toJson() => _$BookScheduleToJson(this);

  static final BookSchedule empty = BookSchedule(
      isBooked: false,
      scheduleDate: DateTime(0),
      medicId: 0,
      createdIn: DateTime(0),
      scheduleType: 'CONSULTA'
  );

  final bool isBooked;
  final int medicId;
  final DateTime scheduleDate;
  final DateTime createdIn;
  final String scheduleType;

  @override
  List<Object?> get props => [isBooked, medicId, scheduleDate, createdIn, scheduleType];

}