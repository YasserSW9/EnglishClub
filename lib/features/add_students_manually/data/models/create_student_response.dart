import 'package:json_annotation/json_annotation.dart';

part 'create_student_response.g.dart';

@JsonSerializable()
class CreateStudentResponse {
  String? message;
  Data? data;

  CreateStudentResponse({this.message, this.data});

  factory CreateStudentResponse.fromJson(Map<String, dynamic> json) =>
      _$CreateStudentResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CreateStudentResponseToJson(this);
}

@JsonSerializable()
class Data {
  Student? student;
  Account? account;

  Data({this.student, this.account});

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class Student {
  String? name;
  @JsonKey(name: "g_class_id")
  int? gClassId;
  @JsonKey(name: "borrow_limit")
  int? borrowLimit;
  int? id;
  int? score;
  @JsonKey(name: "golden_coins")
  int? goldenCoins;
  @JsonKey(name: "silver_coins")
  int? silverCoins;
  @JsonKey(name: "bronze_coins")
  int? bronzeCoins;

  Student({
    this.name,
    this.gClassId,
    this.borrowLimit,
    this.id,
    this.score,
    this.goldenCoins,
    this.silverCoins,
    this.bronzeCoins,
  });

  factory Student.fromJson(Map<String, dynamic> json) =>
      _$StudentFromJson(json);

  Map<String, dynamic> toJson() => _$StudentToJson(this);
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
