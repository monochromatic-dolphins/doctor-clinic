import 'package:doctor_clinic/model/diagnosis.dart';
import 'package:doctor_clinic/model/medical_interview.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

class Role {
  static const String doctor = 'DOCTOR';
  static const String patient = 'PATIENT';
}

@JsonSerializable()
class User {
  final int id;
  final String login;
  final String name;
  final String surname;
  final String role;
  final MedicalInterview? medicalInterview;
  final Diagnosis? diagnosis;

  User({
    required this.id,
    required this.login,
    required this.name,
    required this.surname,
    required this.role,
    this.medicalInterview,
    this.diagnosis,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}