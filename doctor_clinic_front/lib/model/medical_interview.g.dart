// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medical_interview.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MedicalInterview _$MedicalInterviewFromJson(Map<String, dynamic> json) {
  return MedicalInterview(
    id: json['id'] as int?,
    patient: json['patient'] == null
        ? null
        : User.fromJson(json['patient'] as Map<String, dynamic>),
    doctor: json['doctor'] == null
        ? null
        : User.fromJson(json['doctor'] as Map<String, dynamic>),
    pregnancy: json['pregnancy'] as int?,
    glucose: json['glucose'] as int?,
    bloodPressure: json['bloodPressure'] as int?,
    skinThickness: json['skinThickness'] as int?,
    insulin: json['insulin'] as int?,
    bmi: (json['bmi'] as num?)?.toDouble(),
    diabetesPedigree: (json['diabetesPedigree'] as num?)?.toDouble(),
    age: json['age'] as int?,
  );
}

Map<String, dynamic> _$MedicalInterviewToJson(MedicalInterview instance) =>
    <String, dynamic>{
      'id': instance.id,
      'patient': instance.patient,
      'doctor': instance.doctor,
      'pregnancy': instance.pregnancy,
      'glucose': instance.glucose,
      'bloodPressure': instance.bloodPressure,
      'skinThickness': instance.skinThickness,
      'insulin': instance.insulin,
      'bmi': instance.bmi,
      'diabetesPedigree': instance.diabetesPedigree,
      'age': instance.age,
    };
