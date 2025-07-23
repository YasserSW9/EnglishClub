import 'package:json_annotation/json_annotation.dart';

part 'create_admin_request_body.g.dart';

@JsonSerializable()
class CreateAdminRequestBody {
  final String name;

  CreateAdminRequestBody({required this.name});

  Map<String, dynamic> toJson() => _$CreateAdminRequestBodyToJson(this);
}
