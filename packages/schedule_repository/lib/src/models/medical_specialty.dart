import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'medical_specialty.g.dart';

@JsonSerializable()
class MedicalSpecialty extends Equatable{
  const MedicalSpecialty({
    required this.specialtyId,
    required this.specialtyName
  });

  factory MedicalSpecialty.fromJson(Map<String, dynamic> json) =>
      _$MedicalSpecialtyFromJson(json);

  Map<String, dynamic> toJson() => _$MedicalSpecialtyToJson(this);

  final int specialtyId;
  final String specialtyName;

  @override
  List<Object> get props => [specialtyId, specialtyName];
}