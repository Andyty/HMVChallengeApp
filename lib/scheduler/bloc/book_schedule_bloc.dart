import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hmv_challenge_app/scheduler/models/models.dart';
import 'package:meta/meta.dart';
import 'package:schedule_repository/schedule_repository.dart';

part 'book_schedule_event.dart';
part 'book_schedule_state.dart';

class BookScheduleBloc extends Bloc<BookScheduleEvent, BookScheduleState> {
  BookScheduleBloc({
    required this.scheduleRepository
  }) : super(BookScheduleState()) {
    on<BookNewSchedule>(_onBookSchedule);
  }

  final ScheduleRepository scheduleRepository;

  Future<void> _onBookSchedule(BookNewSchedule event, Emitter<BookScheduleState> emit) async {
    try {
      emit(state.copyWith(status: BookScheduleStatus.loading));

      final bookSchedule = await scheduleRepository.bookSchedule(event.pacientId, event.scheduleId, event.scheduleType);

      if (bookSchedule == null) {
        emit(state.copyWith(status: BookScheduleStatus.error));
      } else {
        emit(state.copyWith(
          status: BookScheduleStatus.success,
          bookSchedule: BookSchedule(
            isBooked: bookSchedule.isBooked,
            medicId: bookSchedule.medicId,
            scheduleDate: bookSchedule.scheduleDate,
            createdIn: bookSchedule.createdIn,
            scheduleType: bookSchedule.scheduleType
          )
        ));
      }
    } catch (error) {
      emit(state.copyWith(status: BookScheduleStatus.error));
    }
  }
}
