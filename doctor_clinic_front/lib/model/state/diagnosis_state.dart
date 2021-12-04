import 'package:doctor_clinic/model/diagnosis.dart';
import 'package:doctor_clinic/model/state/app_state.dart';
import 'package:doctor_clinic/repository/api_client.dart';
import 'package:flutter/cupertino.dart';

class DiagnosisState extends ChangeNotifier {
  DiagnosisState({
    required AppState appState,
    required ApiClient apiClient,
  })  : _appState = appState,
        _apiClient = apiClient;

  final AppState _appState;
  final ApiClient _apiClient;

  Diagnosis diagnosis = Diagnosis(id: 1, result: 1);
}