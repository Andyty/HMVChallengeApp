part of 'medic_bloc.dart';

@immutable
abstract class MedicEvent extends Equatable{
  const MedicEvent();

  @override
  List<Object> get props => [];
}

class GetMedicList extends MedicEvent {
  const GetMedicList(this.idSpecialty);

  final int idSpecialty;

  @override
  List<Object> get props => [idSpecialty];
}
