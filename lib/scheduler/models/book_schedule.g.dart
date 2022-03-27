// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_schedule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookSchedule _$BookScheduleFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'BookSchedule',
      json,
      ($checkedConvert) {
        final val = BookSchedule(
          isBooked: $checkedConvert('IsBooked', (v) => v as bool),
          medicId: $checkedConvert('MedicId', (v) => v as int),
          scheduleDate: $checkedConvert(
              'ScheduleDate', (v) => DateTime.parse(v as String)),
          createdIn:
              $checkedConvert('CreatedIn', (v) => DateTime.parse(v as String)),
          scheduleType: $checkedConvert('ScheduleType', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {
        'isBooked': 'IsBooked',
        'medicId': 'MedicId',
        'scheduleDate': 'ScheduleDate',
        'createdIn': 'CreatedIn',
        'scheduleType': 'ScheduleType'
      },
    );

Map<String, dynamic> _$BookScheduleToJson(BookSchedule instance) =>
    <String, dynamic>{
      'IsBooked': instance.isBooked,
      'MedicId': instance.medicId,
      'ScheduleDate': instance.scheduleDate.toIso8601String(),
      'CreatedIn': instance.createdIn.toIso8601String(),
      'ScheduleType': instance.scheduleType,
    };
