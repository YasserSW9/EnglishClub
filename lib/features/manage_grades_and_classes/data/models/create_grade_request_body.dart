import 'package:json_annotation/json_annotation.dart';
part 'create_grade_request_body.g.dart';

@JsonSerializable()
class CreateGradeRequestBody {
  final String name;

  CreateGradeRequestBody({required this.name});

  Map<String, dynamic> toJson() => _$CreateGradeRequestBodyToJson(this);
}
