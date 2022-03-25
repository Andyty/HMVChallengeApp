// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'schedule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Schedule _$ScheduleFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Schedule',
      json,
      ($checkedConvert) {
        final val = Schedule(
          idAgenda: $checkedConvert('IdAgenda', (v) => v as int),
          dtAgendamento: $checkedConvert(
              'DtAgendamento', (v) => DateTime.parse(v as String)),
          idMedico: $checkedConvert('IdMedico', (v) => v as int),
          nomeMedico: $checkedConvert('NomeMedico', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {
        'idAgenda': 'IdAgenda',
        'dtAgendamento': 'DtAgendamento',
        'idMedico': 'IdMedico',
        'nomeMedico': 'NomeMedico'
      },
    );
