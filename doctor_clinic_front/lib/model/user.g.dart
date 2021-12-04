// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    id: json['id'] as int,
    login: json['login'] as String,
    name: json['name'] as String,
    surname: json['surname'] as String,
    role: json['role'] as String,
    medicalInterview: json['medicalInterview'] == null
        ? null
        : MedicalInterview.fromJson(
            json['medicalInterview'] as Map<String, dynamic>),
    diagnosis: json['diagnosis'] == null
        ? null
        : Diagnosis.fromJson(json['diagnosis'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'login': instance.login,
      'name': instance.name,
      'surname': instance.surname,
      'role': instance.role,
      'medicalInterview': instance.medicalInterview,
      'diagnosis': instance.diagnosis,
    };
