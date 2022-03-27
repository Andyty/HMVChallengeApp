part of 'medic_bloc.dart';

enum MedicStatus { initial, success, error, loading }

extension MedicStatusX on MedicStatus {
  bool get isInitial => this == MedicStatus.initial;
  bool get isSuccess => this == MedicStatus.success;
  bool get isError => this == MedicStatus.error;
  bool get isLoading => this == MedicStatus.loading;
}

class MedicState extends Equatable {
  const MedicState({
    this.status = MedicStatus.initial,
    this.medics = const [],
  });

  final MedicStatus status;
  final List<Medic> medics;

  @override
  List<Object> get props => [status, medics];

  MedicState copyWith({
    MedicStatus? status,
    List<Medic>? medics,
  }) {
    return MedicState(
      status: status ?? this.status,
      medics: medics ?? this.medics,
    );
  }
}
