import 'package:json_annotation/json_annotation.dart';

part 'create_admin_response.g.dart';

@JsonSerializable()
class CreateAdminResponse {
  String? message;
  Data? data;

  CreateAdminResponse({this.message, this.data});

  factory CreateAdminResponse.fromJson(Map<String, dynamic> json) =>
      _$CreateAdminResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CreateAdminResponseToJson(this);
}

@JsonSerializable()
class Data {
  Account? account;

  Data({this.account});

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class Account {
  String? username;
  String? password;

  Account({this.username, this.password});

  factory Account.fromJson(Map<String, dynamic> json) =>
      _$AccountFromJson(json);

  Map<String, dynamic> toJson() => _$AccountToJson(this);
}
