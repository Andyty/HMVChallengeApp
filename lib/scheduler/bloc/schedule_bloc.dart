import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hmv_challenge_app/scheduler/models/models.dart';
import 'package:meta/meta.dart';
import 'package:schedule_repository/schedule_repository.dart' hide Schedule, PostSchedule;

part 'schedule_event.dart';
part 'schedule_state.dart';

class ScheduleBloc extends Bloc<ScheduleEvent, ScheduleState> {
  ScheduleBloc({
    required this.scheduleRepository
  }) : super(ScheduleState()) {
    on<ScheduleGetFreeSchedules>(_onGetFreeSchedule);
  }

  final ScheduleRepository scheduleRepository;

  Future<void> _onGetFreeSchedule(ScheduleGetFreeSchedules event, Emitter<ScheduleState> emit) async {
    try {
      emit(state.copyWith(status: ScheduleStatus.loading));

      final freeSchedules = await scheduleRepository.getFreeSchedules(event.dtStart, event.dtEnd, event.idSpecialty, event.idMedic);

      emit(state.copyWith(
        status: ScheduleStatus.success,
        schedules: freeSchedules.map((e) => Schedule(scheduleId: e.scheduleId, scheduleDate: e.scheduleDate, medicId: e.medicId, medicName: e.medicName)).toList()
      ));
    } catch (error, stacktrace){
      emit(state.copyWith(status: ScheduleStatus.error));
    }
  }


}
