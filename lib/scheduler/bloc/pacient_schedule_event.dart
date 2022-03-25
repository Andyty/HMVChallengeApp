part of 'pacient_schedule_bloc.dart';

@immutable
abstract class PacientScheduleEvent extends Equatable{
  const PacientScheduleEvent();

  @override
  List<Object> get props => [];
}

class GetPacientSchedules extends PacientScheduleEvent {
  const GetPacientSchedules(this.idPacient);

  final int idPacient;

  @override
  List<Object> get props => [idPacient];
}
