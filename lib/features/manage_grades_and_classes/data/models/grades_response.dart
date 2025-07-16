import 'package:json_annotation/json_annotation.dart';
part 'grades_response.g.dart';

@JsonSerializable()
class GradesResponse {
  String? message;
  List<Data>? data;

  GradesResponse({this.message, this.data});

  factory GradesResponse.fromJson(Map<String, dynamic> json) =>
      _$GradesResponseFromJson(json);
  Map<String, dynamic> toJson() => _$GradesResponseToJson(this);
}

@JsonSerializable()
class Data {
  int? id;
  String? name;
  List<Classes>? classes;

  Data({this.id, this.name, this.classes});

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class Classes {
  int? id;
  String? name;
  @JsonKey(name: 'grade_id')
  int? gradeId;

  Classes({this.id, this.name, this.gradeId});

  factory Classes.fromJson(Map<String, dynamic> json) =>
      _$ClassesFromJson(json);
  Map<String, dynamic> toJson() => _$ClassesToJson(this);
}
