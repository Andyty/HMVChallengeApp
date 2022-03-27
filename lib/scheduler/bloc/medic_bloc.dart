import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hmv_challenge_app/scheduler/models/models.dart';
import 'package:meta/meta.dart';
import 'package:schedule_repository/schedule_repository.dart' hide Medic;

part 'medic_event.dart';
part 'medic_state.dart';

class MedicBloc extends Bloc<MedicEvent, MedicState> {
  MedicBloc({
    required this.scheduleRepository
  }) : super(MedicState()) {
    on<GetMedicList>(_onGetMedicsList);
  }

  final ScheduleRepository scheduleRepository;

  Future<void> _onGetMedicsList(GetMedicList event, Emitter<MedicState> emit) async {
    try{
      emit(state.copyWith(status: MedicStatus.loading));

      final medicsList = await scheduleRepository.getMedics(event.idSpecialty);

      emit(state.copyWith(
          status: MedicStatus.success,
          medics: medicsList.map((e) => Medic(medicId: e.medicId, medicName: e.medicName)).toList()
      ));
    } catch (error, stacktrace){
      emit(state.copyWith(status: MedicStatus.error));
    }
  }
}
