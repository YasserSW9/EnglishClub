import 'package:json_annotation/json_annotation.dart';

part 'edit_grade_request_body.g.dart';

@JsonSerializable()
class EditGradeRequestBody {
  String name;

  EditGradeRequestBody({required this.name});

  factory EditGradeRequestBody.fromJson(Map<String, dynamic> json) =>
      _$EditGradeRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$EditGradeRequestBodyToJson(this);
}
