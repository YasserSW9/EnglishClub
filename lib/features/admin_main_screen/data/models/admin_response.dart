import 'package:json_annotation/json_annotation.dart';

part 'admin_response.g.dart';

@JsonSerializable()
class AdminResponse {
  int? id;
  String? name;
  @JsonKey(
    name: 'super',
  ) // Use @JsonKey to map 'super' to a valid Dart identifier
  int? superField; // Renamed to avoid conflict with Dart's 'super' keyword

  AdminResponse({this.id, this.name, this.superField});

  factory AdminResponse.fromJson(Map<String, dynamic> json) =>
      _$AdminResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AdminResponseToJson(this);
}
