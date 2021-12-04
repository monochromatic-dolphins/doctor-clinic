import 'package:doctor_clinic/model/api/login_request.dart';
import 'package:doctor_clinic/model/api/register_request.dart';
import 'package:doctor_clinic/model/medical_interview.dart';
import 'package:doctor_clinic/model/user.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'api_client.g.dart';

@RestApi()
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  // Users

  @POST(Apis.register)
  Future<User> registerUser(@Body() RegisterRequest request);

  @POST(Apis.login)
  Future<User> login(@Body() LoginRequest request);

  @GET(Apis.users)
  Future<List<User>> getUsers();

  @POST(Apis.users)
  Future<User> updateUser(@Body() User user);

  @GET(Apis.users)
  Future<List<User>> getPatients();

  // Medical interviews

  @POST(Apis.medicalInterviews)
  Future<void> analyzeMedicalInterview(@Body() MedicalInterview interview);

}

class Apis {
  static const users = '/users';
  static const register = '/register';
  static const login = '/login';
  static const medicalInterviews = '/medical-interviews';
}