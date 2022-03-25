// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'medic.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Medic _$MedicFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Medic',
      json,
      ($checkedConvert) {
        final val = Medic(
          idMedico: $checkedConvert('IdMedico', (v) => v as int),
          nomeMedico: $checkedConvert('NomeMedico', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {'idMedico': 'IdMedico', 'nomeMedico': 'NomeMedico'},
    );
