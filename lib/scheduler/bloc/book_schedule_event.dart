part of 'book_schedule_bloc.dart';

@immutable
abstract class BookScheduleEvent extends Equatable {
  const BookScheduleEvent();

  @override
  List<Object?> get props => [];
}

class BookNewSchedule extends BookScheduleEvent {
  const BookNewSchedule(this.pacientId, this.scheduleId, this.scheduleType);

  final int pacientId;
  final int scheduleId;
  final String scheduleType;

  @override
  List<Object?> get props => [pacientId, scheduleId, scheduleType];
}