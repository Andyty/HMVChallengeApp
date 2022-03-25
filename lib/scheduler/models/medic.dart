import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:schedule_repository/schedule_repository.dart' hide Medic;
import 'package:schedule_repository/schedule_repository.dart' as schedule_repository;

part 'medic.g.dart';

@JsonSerializable()
class Medic extends Equatable {
  const Medic({
    required this.medicId,
    required this.medicName
  });

  factory Medic.fromJson(Map<String, dynamic> json) =>
      _$MedicFromJson(json);


  factory Medic.fromRepository(schedule_repository.Medic medic) {
    return Medic(
        medicId: medic.medicId,
        medicName: medic.medicName,
    );
  }

  Map<String, dynamic> toJson() => _$MedicToJson(this);

  static final empty = Medic(
    medicId: 0,
    medicName: ''
  );

  final int medicId;
  final String medicName;

  @override
  List<Object?> get props => [medicId, medicName];
}