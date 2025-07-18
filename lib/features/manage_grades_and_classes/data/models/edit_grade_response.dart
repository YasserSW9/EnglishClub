import 'package:json_annotation/json_annotation.dart';

part 'edit_grade_response.g.dart';

@JsonSerializable()
class EditGradeResponse {
  String? message;
  Data? data;

  EditGradeResponse({this.message, this.data});

  factory EditGradeResponse.fromJson(Map<String, dynamic> json) =>
      _$EditGradeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$EditGradeResponseToJson(this);
}

@JsonSerializable()
class Data {
  int? id;
  String? name;

  Data({this.id, this.name});

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
