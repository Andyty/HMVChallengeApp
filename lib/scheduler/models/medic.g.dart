// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medic.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Medic _$MedicFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Medic',
      json,
      ($checkedConvert) {
        final val = Medic(
          medicId: $checkedConvert('MedicId', (v) => v as int),
          medicName: $checkedConvert('MedicName', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {'medicId': 'MedicId', 'medicName': 'MedicName'},
    );

Map<String, dynamic> _$MedicToJson(Medic instance) => <String, dynamic>{
      'MedicId': instance.medicId,
      'MedicName': instance.medicName,
    };
