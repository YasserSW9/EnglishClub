import 'package:json_annotation/json_annotation.dart';
part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse {
  String? message;
  @JsonKey(name: "userData")
  Data? data;

  LoginResponse({this.message, this.data});
  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);
}

@JsonSerializable()
class Data {
  String? token;
  String? type;

  Data({this.token, this.type});
  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
}
