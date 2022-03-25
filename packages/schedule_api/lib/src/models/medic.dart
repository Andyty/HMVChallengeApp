import 'package:json_annotation/json_annotation.dart';

part 'medic.g.dart';

@JsonSerializable()
class Medic {
  const Medic({
    required this.idMedico,
    required this.nomeMedico
  });

  factory Medic.fromJson(Map<String, dynamic> json) =>
      _$MedicFromJson(json);

  final int idMedico;
  final String nomeMedico;
}