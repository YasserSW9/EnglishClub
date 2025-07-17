import 'package:json_annotation/json_annotation.dart';

part 'create_grade_response.g.dart';

@JsonSerializable()
class CreateGradeResponse {
  String? message;

  CreateGradeResponse({this.message});

  factory CreateGradeResponse.fromJson(Map<String, dynamic> json) =>
      _$CreateGradeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CreateGradeResponseToJson(this);
}
