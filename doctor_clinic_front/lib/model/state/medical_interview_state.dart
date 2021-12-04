import 'package:doctor_clinic/model/medical_interview.dart';
import 'package:doctor_clinic/model/state/app_state.dart';
import 'package:doctor_clinic/model/user.dart';
import 'package:doctor_clinic/repository/api_client.dart';
import 'package:flutter/cupertino.dart';

class MedicalInterviewState extends ChangeNotifier {
  MedicalInterviewState({
    required AppState appState,
    required ApiClient apiClient,
  })  : _appState = appState,
        _apiClient = apiClient;

  final AppState _appState;
  final ApiClient _apiClient;

  List<MedicalInterview?> _medicalInterviews = [];

  List<MedicalInterview?> get medicalInterviews => _medicalInterviews;

  Future<void> fetchMedicalInterviews() async {
    _appState.startFetching();
    try {
      final patients = (await _apiClient.getPatients()).where((patient) => patient.role == Role.patient);
      print(patients);
      final interviews = patients.map((patient) => patient.medicalInterview?.copyWith(patient: patient)).toList();

      _medicalInterviews = interviews;
      _appState.stopFetching();
    } catch (e) {
      return null;
    }
  }

  Future<void> analyzeMedicalInterview(MedicalInterview interview) async =>
      await _apiClient.analyzeMedicalInterview(interview);
}
