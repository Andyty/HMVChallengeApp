import 'package:json_annotation/json_annotation.dart';

part 'post_schedule.g.dart';

@JsonSerializable()
class PostSchedule {

  const PostSchedule({
    required this.agendado,
    required this.idMedico,
    required this.dtAgendamento,
    required this.createdIn,
    required this.tipoAgendamento
  });

  factory PostSchedule.fromJson(Map<String, dynamic> json) =>
      _$PostScheduleFromJson(json);

  final bool agendado;
  final int idMedico;
  final DateTime dtAgendamento;
  final DateTime createdIn;
  final String tipoAgendamento;

}