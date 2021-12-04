
import 'package:doctor_clinic/model/state/diagnosis_state.dart';
import 'package:doctor_clinic/model/state/medical_interview_state.dart';
import 'package:doctor_clinic/model/state/user_state.dart';
import 'package:doctor_clinic/repository/api_client.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class AppState extends ChangeNotifier {
  AppState() {
    userState = UserState(appState: this, apiClient: _apiClient);
    medicalInterviewState = MedicalInterviewState(appState: this, apiClient: _apiClient);
    diagnosisState = DiagnosisState(appState: this, apiClient: _apiClient);
  }

  // ApiClient _apiClient = ApiClient(Dio(), baseUrl: 'http://192.168.0.173:8080');
  ApiClient _apiClient = ApiClient(Dio(), baseUrl: 'http://localhost:8080');

  late final UserState userState;
  late final MedicalInterviewState medicalInterviewState;
  late final DiagnosisState diagnosisState;

  bool _isFetching = false;

  bool get isFetching => _isFetching;

  void startFetching() {
    _isFetching = true;
    print('started fetching');
    notifyListeners();
  }

  void stopFetching() {
    _isFetching = false;
    print('stopped fetching');
    notifyListeners();
  }
}
