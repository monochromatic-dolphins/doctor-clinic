import 'package:doctor_clinic/model/api/login_request.dart';
import 'package:doctor_clinic/model/api/register_request.dart';
import 'package:doctor_clinic/model/state/app_state.dart';
import 'package:doctor_clinic/model/user.dart';
import 'package:doctor_clinic/repository/api_client.dart';
import 'package:flutter/cupertino.dart';

class UserState extends ChangeNotifier {
  UserState({
    required AppState appState,
    required ApiClient apiClient,
  })  : _appState = appState,
        _apiClient = apiClient;

  final AppState _appState;
  final ApiClient _apiClient;

  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;

  User? _user;

  User? get user => _user;

  List<User> get patients => _patients;

  List<User> _patients = [];

  Future<User?> logIn(String login, String password) async {
    _appState.startFetching();
    User response;
    try {
      response = await _apiClient.login(LoginRequest(login: login, password: password));
    } catch (e) {
      return null;
    }

    _isLoggedIn = true;
    _user = response;
    _appState.stopFetching();
    return _user;
  }

  Future<User?> register(String login, String password, String name, String surname) async {
    _appState.startFetching();
    User response;
    try {
      response = await _apiClient
          .registerUser(RegisterRequest(login: login, password: password, name: name, surname: surname));
    } catch (e) {
      return null;
    }
    _isLoggedIn = true;
    _user = response;
    _appState.stopFetching();
    return _user;
  }

  Future<void> fetchPatients() async {
    _appState.startFetching();

    final patients = await _apiClient.getPatients();
    _patients = patients;

    _appState.stopFetching();
  }

  void logOut() {
    _isLoggedIn = false;
    notifyListeners();
  }
}
