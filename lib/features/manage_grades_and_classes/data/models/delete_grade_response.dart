import 'package:json_annotation/json_annotation.dart';

part 'delete_grade_response.g.dart';

@JsonSerializable()
class DeleteGradeResponse {
  String? message;

  DeleteGradeResponse({this.message});

  factory DeleteGradeResponse.fromJson(Map<String, dynamic> json) =>
      _$DeleteGradeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DeleteGradeResponseToJson(this);
}
