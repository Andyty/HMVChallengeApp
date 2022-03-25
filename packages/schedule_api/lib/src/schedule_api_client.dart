import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:schedule_api/schedule_api.dart';

/// Exception thrown when getSpecialties fails.
class GetSpecialtiesFailure implements Exception {}

/// Exception thrown when getMedics fails.
class GetMedicsFailure implements Exception {}

/// Exception thrown when getMedics fails.
class GetSchedulesFailure implements Exception {}

/// {@template schedule_api_client}
/// Dart API Client which wraps the Schedule API.
/// {@endtemplate}
class ScheduleApiClient {
  /// {@macro schedule_api_client}
  ScheduleApiClient({http.Client? httpClient})
    : _httpClient = httpClient ?? http.Client();

  static const _baseUrl = 'svydq5dhle.execute-api.us-east-1.amazonaws.com';
  final http.Client _httpClient;

  Future<List<MedicalSpecialty>> getSpecialties() async {
    final request = Uri.https(
      _baseUrl,
      '/dev/especialidadesmedico'
    );

    final response = await _httpClient.get(request);

    if (response.statusCode != 200) {
      throw GetSpecialtiesFailure();
    }

    final specialtiesJson = jsonDecode(response.body) as List;
    List<MedicalSpecialty> _returnList = [];

    if (specialtiesJson.isEmpty) {
      return _returnList;
    }

    for (var item in specialtiesJson) {
      _returnList.add(MedicalSpecialty.fromJson(item as Map<String, dynamic>));
    }

    return _returnList;
  }

  Future<List<Medic>> getMedics(int idSpecialty) async {
    final request = Uri.https(
        _baseUrl,
        '/dev/medicoporespecialidade',
        <String, int>{'idEspecialidade': idSpecialty}
    );

    final response = await _httpClient.get(request);

    if (response.statusCode != 200) {
      throw GetMedicsFailure();
    }

    final medicsJson = jsonDecode(response.body) as List;
    List<Medic> _returnList = [];

    if (medicsJson.isEmpty) {
      return _returnList;
    }

    for (var item in medicsJson) {
      _returnList.add(Medic.fromJson(item as Map<String, dynamic>));
    }

    return _returnList;
  }

  Future<List<Schedule>> getFreeSchedule(int idSpecialty, DateTime start, DateTime end, int? idMedic) async {
    final DateFormat dateFormat = DateFormat("yyyy/MM/yyTkk:mm");
    Map<String, dynamic> params = {
      'dtAgendamentoInicio': dateFormat.format(start),
      'dtAgendamentoFim': dateFormat.format(end),
      'idEspecialidade': idSpecialty,
      'idMedico': idMedic
    };

    final request = Uri.https(
        _baseUrl,
        '/dev/agendamentoconsulta',
        params
    );

    final response = await _httpClient.get(request);

    if (response.statusCode != 200) {
      throw GetSchedulesFailure();
    }

    final schedulesJson = jsonDecode(response.body) as List;
    List<Schedule> _returnList = [];

    if (schedulesJson.isEmpty) {
      return _returnList;
    }

    for (var item in schedulesJson) {
      _returnList.add(Schedule.fromJson(item as Map<String, dynamic>));
    }

    return _returnList;
  }

  Future<List<Schedule>> getPacientSchedule(int idPacient) async {
    final DateFormat dateFormat = DateFormat("yyyy/MM/yyTkk:mm");
    Map<String, String> params = {
      'idUsuario': idPacient.toString(),
    };

    final request = Uri.https(
        _baseUrl,
        '/dev/agendamentopaciente',
        params
    );

    final response = await _httpClient.get(request);

    if (response.statusCode != 200) {
      throw GetSchedulesFailure();
    }

    final schedulesJson = jsonDecode(response.body) as List;
    List<Schedule> _returnList = [];

    if (schedulesJson.isEmpty) {
      return _returnList;
    }

    for (var item in schedulesJson) {
      _returnList.add(Schedule.fromJson(item as Map<String, dynamic>));
    }

    return _returnList;
  }
}