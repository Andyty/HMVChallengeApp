part of 'medical_specialty_bloc.dart';

enum MedicalSpecialtyStatus { initial, success, error, loading }

extension MedicalSpecialtyStatusX on MedicalSpecialtyStatus {
  bool get isInitial => this == MedicalSpecialtyStatus.initial;
  bool get isSuccess => this == MedicalSpecialtyStatus.success;
  bool get isError => this == MedicalSpecialtyStatus.error;
  bool get isLoading => this == MedicalSpecialtyStatus.loading;
}

class MedicalSpecialtyState extends Equatable {
  const MedicalSpecialtyState({
    this.status = MedicalSpecialtyStatus.initial,
    this.specialties = const []
  });

  final MedicalSpecialtyStatus status;
  final List<MedicalSpecialty> specialties;

  @override
  List<Object> get props => [status, specialties];

  MedicalSpecialtyState copyWith({
    MedicalSpecialtyStatus? status,
    List<MedicalSpecialty>? specialties
  }) {
    return MedicalSpecialtyState(
      status: status ?? this.status,
      specialties: specialties ?? this.specialties
    );
  }
}
