import 'package:json_annotation/json_annotation.dart';

part 'create_section_response.g.dart';

@JsonSerializable()
class CreateSectionResponse {
  String? message;
  Data? data;

  CreateSectionResponse({this.message, this.data});

  factory CreateSectionResponse.fromJson(Map<String, dynamic> json) =>
      _$CreateSectionResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CreateSectionResponseToJson(this);
}

@JsonSerializable()
class Data {
  String? name;
  int? id;

  Data({this.name, this.id});

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
