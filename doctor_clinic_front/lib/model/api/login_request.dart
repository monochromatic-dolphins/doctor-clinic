import 'package:json_annotation/json_annotation.dart';

part 'login_request.g.dart';

@JsonSerializable()
class LoginRequest {
  final String login;
  final String password;

  LoginRequest({
    required this.login,
    required this.password,
  });

  factory LoginRequest.fromJson(Map<String, dynamic> json) {
    print('$json');
    return _$LoginRequestFromJson(json);
  }

  Map<String, dynamic> toJson() => _$LoginRequestToJson(this);
}