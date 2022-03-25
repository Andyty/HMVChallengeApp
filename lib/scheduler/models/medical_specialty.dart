import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:schedule_repository/schedule_repository.dart' hide MedicalSpecialty;
import 'package:schedule_repository/schedule_repository.dart' as schedule_repository;

part 'medical_specialty.g.dart';

@JsonSerializable()
class MedicalSpecialty extends Equatable{
  const MedicalSpecialty({
    required this.specialtyId,
    required this.specialtyName
  });

  factory MedicalSpecialty.fromJson(Map<String, dynamic> json) =>
      _$MedicalSpecialtyFromJson(json);

  factory MedicalSpecialty.fromRepository(schedule_repository.MedicalSpecialty medicalSpecialty) {
    return MedicalSpecialty(
      specialtyId: medicalSpecialty.specialtyId,
      specialtyName: medicalSpecialty.specialtyName,
    );
  }

  Map<String, dynamic> toJson() => _$MedicalSpecialtyToJson(this);

  final int specialtyId;
  final String specialtyName;

  @override
  List<Object> get props => [specialtyId, specialtyName];
}