import 'package:json_annotation/json_annotation.dart';

part 'diagnosis.g.dart';

@JsonSerializable()
class Diagnosis {
  final int id;
  final int? result;

  Diagnosis({
    required this.id,
    this.result,
  });

  factory Diagnosis.fromJson(Map<String, dynamic> json) => _$DiagnosisFromJson(json);

  Map<String, dynamic> toJson() => _$DiagnosisToJson(this);
}
