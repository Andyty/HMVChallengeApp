import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'medic.g.dart';

@JsonSerializable()
class Medic extends Equatable{
  const Medic({
    required this.medicId,
    required this.medicName
  });

  factory Medic.fromJson(Map<String, dynamic> json) =>
      _$MedicFromJson(json);

  Map<String, dynamic> toJson() => _$MedicToJson(this);

  final int medicId;
  final String medicName;

  @override
  List<Object> get props => [medicId, medicName];
}