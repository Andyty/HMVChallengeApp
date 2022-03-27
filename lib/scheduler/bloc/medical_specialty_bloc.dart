import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hmv_challenge_app/scheduler/models/models.dart';
import 'package:meta/meta.dart';
import 'package:schedule_repository/schedule_repository.dart' hide MedicalSpecialty;

part 'medical_specialty_event.dart';
part 'medical_specialty_state.dart';

class MedicalSpecialtyBloc extends Bloc<MedicalSpecialtyEvent, MedicalSpecialtyState> {
  MedicalSpecialtyBloc({
    required this.scheduleRepository
  }) : super(MedicalSpecialtyState()) {
    on<GetMedicalSpecialties>(_onGetMedicalSpecialties);
  }

  final ScheduleRepository scheduleRepository;

  Future<void> _onGetMedicalSpecialties(GetMedicalSpecialties event, Emitter<MedicalSpecialtyState> emit) async {
    try{
      emit(state.copyWith(status: MedicalSpecialtyStatus.loading));

      final medicalSpecialties = await scheduleRepository.getMedicalSpecialties();

      emit(state.copyWith(
        status: MedicalSpecialtyStatus.success,
        specialties: medicalSpecialties.map((e) => MedicalSpecialty(specialtyId: e.specialtyId, specialtyName: e.specialtyName)).toList()
      ));
    } catch (error, stacktrace){
      emit(state.copyWith(status: MedicalSpecialtyStatus.error));
    }
  }
}