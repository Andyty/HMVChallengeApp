import 'package:json_annotation/json_annotation.dart';

part 'medical_specialty.g.dart';

@JsonSerializable()
class MedicalSpecialty {
  const MedicalSpecialty({
    required this.idEspecialidade,
    required this.nomeEspecialidade
  });

  factory MedicalSpecialty.fromJson(Map<String, dynamic> json) =>
      _$MedicalSpecialtyFromJson(json);

  final int idEspecialidade;
  final String nomeEspecialidade;
}