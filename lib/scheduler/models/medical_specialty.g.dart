// GENERATED CODE - DO NOT MODIFY BY HAND

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
          specialtyId: $checkedConvert('SpecialtyId', (v) => v as int),
          specialtyName: $checkedConvert('SpecialtyName', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {
        'specialtyId': 'SpecialtyId',
        'specialtyName': 'SpecialtyName'
      },
    );

Map<String, dynamic> _$MedicalSpecialtyToJson(MedicalSpecialty instance) =>
    <String, dynamic>{
      'SpecialtyId': instance.specialtyId,
      'SpecialtyName': instance.specialtyName,
    };
