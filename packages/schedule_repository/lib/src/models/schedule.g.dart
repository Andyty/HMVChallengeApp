// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Schedule _$ScheduleFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Schedule',
      json,
      ($checkedConvert) {
        final val = Schedule(
          scheduleId: $checkedConvert('ScheduleId', (v) => v as int),
          scheduleDate: $checkedConvert(
              'ScheduleDate', (v) => DateTime.parse(v as String)),
          medicId: $checkedConvert('MedicId', (v) => v as int),
          medicName: $checkedConvert('MedicName', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {
        'scheduleId': 'ScheduleId',
        'scheduleDate': 'ScheduleDate',
        'medicId': 'MedicId',
        'medicName': 'MedicName'
      },
    );

Map<String, dynamic> _$ScheduleToJson(Schedule instance) => <String, dynamic>{
      'ScheduleId': instance.scheduleId,
      'ScheduleDate': instance.scheduleDate.toIso8601String(),
      'MedicId': instance.medicId,
      'MedicName': instance.medicName,
    };
