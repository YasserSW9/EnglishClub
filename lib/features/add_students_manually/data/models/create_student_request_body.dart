import 'package:json_annotation/json_annotation.dart';

part 'create_student_request_body.g.dart';

@JsonSerializable()
class CreateStudentRequestBody {
  String? name;

  @JsonKey(name: 'g_class_id')
  int? gClassId;
  int? score;

  @JsonKey(name: 'golden_coins')
  int? goldenCoins;

  @JsonKey(name: 'silver_coins')
  int? silverCoins;

  @JsonKey(name: 'bronze_coins')
  int? bronzeCoins;

  @JsonKey(name: 'borrow_limit')
  int? borrowLimit;

  List<Map<String, dynamic>>? progresses;

  CreateStudentRequestBody({
    this.name,
    this.gClassId,
    this.score,
    this.goldenCoins,
    this.silverCoins,
    this.bronzeCoins,
    this.borrowLimit,
    this.progresses,
  });

  factory CreateStudentRequestBody.fromJson(Map<String, dynamic> json) =>
      _$CreateStudentRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$CreateStudentRequestBodyToJson(this);
}
