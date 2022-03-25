// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'medical_specialty.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MedicalSpecialty _$MedicalSpecialtyFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'MedicalSpecialty',
      json,
      ($checkedConvert) {
        final val = MedicalSpecialty(
          idEspecialidade: $checkedConvert('IdEspecialidade', (v) => v as int),
          nomeEspecialidade:
              $checkedConvert('NomeEspecialidade', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {
        'idEspecialidade': 'IdEspecialidade',
        'nomeEspecialidade': 'NomeEspecialidade'
      },
    );
