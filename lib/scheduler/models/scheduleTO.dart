import 'package:equatable/equatable.dart';

class ScheduleTO extends Equatable {

  const ScheduleTO({
    required this.idAgenda,
    required this.idTipoExame,
    required this.nmMedico,
    required this.nmExame,
    required this.dtAgenda,
  });

  final int idAgenda;
  final int idTipoExame;
  final String nmMedico;
  final String nmExame;
  final DateTime dtAgenda;

  @override
  // TODO: implement props
  List<Object?> get props => [idAgenda, idTipoExame, nmMedico, nmExame, dtAgenda];

}