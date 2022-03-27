// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'post_schedule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostSchedule _$PostScheduleFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'PostSchedule',
      json,
      ($checkedConvert) {
        final val = PostSchedule(
          agendado: $checkedConvert('Agendado', (v) => v as bool),
          idMedico: $checkedConvert('IdMedico', (v) => v as int),
          dtAgendamento: $checkedConvert(
              'DtAgendamento', (v) => DateTime.parse(v as String)),
          createdIn:
              $checkedConvert('CreatedIn', (v) => DateTime.parse(v as String)),
          tipoAgendamento:
              $checkedConvert('TipoAgendamento', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {
        'agendado': 'Agendado',
        'idMedico': 'IdMedico',
        'dtAgendamento': 'DtAgendamento',
        'createdIn': 'CreatedIn',
        'tipoAgendamento': 'TipoAgendamento'
      },
    );
