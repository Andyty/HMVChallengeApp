import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hmv_challenge_app/scheduler/models/models.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:schedule_repository/schedule_repository.dart' hide Schedule;

part 'pacient_schedule_event.dart';
part 'pacient_schedule_state.dart';

class PacientScheduleBloc extends Bloc<PacientScheduleEvent, PacientScheduleState> {
  PacientScheduleBloc({
    required this.scheduleRepository
  }) : super(PacientScheduleState()) {
    on<GetPacientSchedules>(_onGetPacientSchedule);
  }

  final ScheduleRepository scheduleRepository;

  Future<void> _onGetPacientSchedule(GetPacientSchedules event, Emitter<PacientScheduleState> emit) async {
    try {
      emit(state.copyWith(status: PacientScheduleStatus.loading));

      final pacientSchedules = await scheduleRepository.getPacientSchedules(event.idPacient);

      final DateFormat dateFormat = DateFormat("yyyyMMdd");

      Map<String, List<Schedule>> map = Map<String, List<Schedule>>();

      List<DateTime> dateList = [];

      for (var item in pacientSchedules) {
        var key = dateFormat.format(item.scheduleDate);
        map.update(key, (value) {
          value.add(
            Schedule(
              scheduleId: item.scheduleId,
              scheduleDate: item.scheduleDate,
              medicId: item.medicId,
              medicName: item.medicName
            )
          );
          return value;
        }, ifAbsent: () {
          dateList.add(item.scheduleDate);
          return [
            Schedule(
              scheduleId: item.scheduleId,
              scheduleDate: item.scheduleDate,
              medicId: item.medicId,
              medicName: item.medicName
            )];
          }
        );
      }

      dateList.sort((a,b) {
        return a.compareTo(b);
      });
      emit(state.copyWith(
        status: PacientScheduleStatus.success,
        schedulesMap: map,
        scheduleDates: dateList
      ));
    } catch (error, stacktrace){
      emit(state.copyWith(status: PacientScheduleStatus.error));
    }
  }
}
