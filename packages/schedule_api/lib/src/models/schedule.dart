import 'package:json_annotation/json_annotation.dart';

part 'schedule.g.dart';

@JsonSerializable()
class Schedule {

  const Schedule({
    required this.idAgenda,
    required this.dtAgendamento,
    required this.idMedico,
    required this.nomeMedico,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) =>
      _$ScheduleFromJson(json);

  final int idAgenda;
  final DateTime dtAgendamento;
  final int idMedico;
  final String nomeMedico;

}