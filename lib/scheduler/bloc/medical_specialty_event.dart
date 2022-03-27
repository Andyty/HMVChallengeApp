part of 'medical_specialty_bloc.dart';

@immutable
abstract class MedicalSpecialtyEvent extends Equatable{
  const MedicalSpecialtyEvent();

  @override
  List<Object> get props => [];
}

class GetMedicalSpecialties extends MedicalSpecialtyEvent {}
