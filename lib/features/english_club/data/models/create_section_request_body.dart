import 'package:json_annotation/json_annotation.dart';

part 'create_section_request_body.g.dart';

@JsonSerializable()
class CreateSectionRequestBody {
  final String name;

  CreateSectionRequestBody({required this.name});

  Map<String, dynamic> toJson() => _$CreateSectionRequestBodyToJson(this);
}
