
part of 'schedule_bloc.dart';

@immutable
abstract class ScheduleEvent extends Equatable {
  const ScheduleEvent();

  @override
  List<Object?> get props => [];
}

class ScheduleGetFreeSchedules extends ScheduleEvent {
  const ScheduleGetFreeSchedules(this.dtStart, this.dtEnd, this.idSpecialty, this.idMedic);

  final DateTime dtStart;
  final DateTime dtEnd;
  final int idSpecialty;
  final int? idMedic;

  @override
  List<Object?> get props => [dtStart, dtEnd, idSpecialty, idMedic];
}