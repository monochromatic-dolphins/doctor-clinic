import 'package:doctor_clinic/model/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'medical_interview.g.dart';

@JsonSerializable()
class MedicalInterview {
  final int? id;
  final User? patient;
  final User? doctor;
  final int? pregnancy;
  final int? glucose;
  final int? bloodPressure;
  final int? skinThickness;
  final int? insulin;
  final double? bmi;
  final double? diabetesPedigree;
  final int? age;

  MedicalInterview({
    this.id,
    this.patient,
    this.doctor,
    this.pregnancy,
    this.glucose,
    this.bloodPressure,
    this.skinThickness,
    this.insulin,
    this.bmi,
    this.diabetesPedigree,
    this.age,
  });

  MedicalInterview copyWith({
    int? id,
    User? patient,
    User? doctor,
    int? pregnancy,
    int? glucose,
    int? bloodPressure,
    int? skinThickness,
    int? insulin,
    double? bmi,
    double? diabetesPedigree,
    int? age,
  }) =>
      MedicalInterview(
        id: id ?? this.id,
        patient: patient ?? this.patient,
        doctor: doctor ?? this.doctor,
        pregnancy: pregnancy ?? this.pregnancy,
        glucose: glucose ?? this.glucose,
        bloodPressure: bloodPressure ?? this.bloodPressure,
        skinThickness: skinThickness ?? this.skinThickness,
        insulin: insulin ?? this.insulin,
        bmi: bmi ?? this.bmi,
        diabetesPedigree: diabetesPedigree ?? this.diabetesPedigree,
        age: age ?? this.age,
      );

  factory MedicalInterview.fromJson(Map<String, dynamic> json) => _$MedicalInterviewFromJson(json);

  Map<String, dynamic> toJson() => _$MedicalInterviewToJson(this);
}
