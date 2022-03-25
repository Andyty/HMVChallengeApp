import 'dart:async';

import 'package:schedule_api/schedule_api.dart' hide Schedule, Medic, MedicalSpecialty;
import 'package:schedule_repository/schedule_repository.dart';

class ScheduleFailure implements Exception {}

class ScheduleRepository {
  ScheduleRepository({ScheduleApiClient? scheduleApiClient})
    : _scheduleApiClient = scheduleApiClient ?? ScheduleApiClient();

  final ScheduleApiClient _scheduleApiClient;

  Future<List<Medic>> getMedics(int idSpecialty) async {
    final medicList = await _scheduleApiClient.getMedics(idSpecialty);
    return medicList.map<Medic>((e) => Medic(medicId: e.idMedico, medicName: e.nomeMedico)).toList();
  }

  Future<List<MedicalSpecialty>> getMedicalSpecialties() async {
    final specialtyList = await _scheduleApiClient.getSpecialties();
    return specialtyList.map<MedicalSpecialty>((e) => MedicalSpecialty(specialtyId: e.idEspecialidade, specialtyName: e.nomeEspecialidade)).toList();
  }

  Future<List<Schedule>> getFreeSchedules(DateTime start, DateTime end, int idSpecialty, int? idMedic) async {
    final schedulesList = await _scheduleApiClient.getFreeSchedule(idSpecialty, start, end, idMedic);
    return schedulesList.map((e) => Schedule(scheduleId: e.idAgenda, scheduleDate: e.dtAgendamento, medicId: e.idMedico, medicName: e.nomeMedico)).toList();
  }

  Future<List<Schedule>> getPacientSchedules(int idPacient) async {
    final schedulesList = await _scheduleApiClient.getPacientSchedule(idPacient);
    return schedulesList.map((e) => Schedule(scheduleId: e.idAgenda, scheduleDate: e.dtAgendamento, medicId: e.idMedico, medicName: e.nomeMedico)).toList();
  }
}