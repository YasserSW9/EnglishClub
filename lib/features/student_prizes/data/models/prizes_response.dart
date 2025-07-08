import 'package:json_annotation/json_annotation.dart';
part 'prizes_response.g.dart';

@JsonSerializable()
class PrizesResponse {
  String? message;
  PrizesData? data;

  PrizesResponse({this.message, this.data});

  factory PrizesResponse.fromJson(Map<String, dynamic> json) =>
      _$PrizesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PrizesResponseToJson(this);
}

@JsonSerializable()
class PrizesData {
  @JsonKey(name: 'current_page')
  int? currentPage;
  List<PrizeItem>? data;
  @JsonKey(name: 'first_page_url')
  String? firstPageUrl;
  int? from;
  @JsonKey(name: 'next_page_url')
  String? nextPageUrl;
  String? path;
  @JsonKey(name: 'per_page')
  int? perPage;
  @JsonKey(name: 'prev_page_url')
  String? prevPageUrl;
  int? to;

  PrizesData({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
  });

  factory PrizesData.fromJson(Map<String, dynamic> json) =>
      _$PrizesDataFromJson(json);

  Map<String, dynamic> toJson() => _$PrizesDataToJson(this);
}

@JsonSerializable()
class PrizeItem {
  int? id;
  String? date;
  @JsonKey(name: 'collected_at')
  String? collectedAt;
  String? reason;
  int? collected;
  @JsonKey(name: 'test_id')
  int? testId;
  @JsonKey(name: 'student_id')
  int? studentId;
  @JsonKey(name: 'prize_id')
  int? prizeId;
  @JsonKey(name: 'created_at')
  DateTime? createdAt;
  @JsonKey(name: 'updated_at')
  DateTime? updatedAt;
  GiveItTo? giveItTo;
  Prize? prize;

  PrizeItem({
    this.id,
    this.date,
    this.collectedAt,
    this.reason,
    this.collected,
    this.testId,
    this.studentId,
    this.prizeId,
    this.createdAt,
    this.updatedAt,
    this.giveItTo,
    this.prize,
  });

  factory PrizeItem.fromJson(Map<String, dynamic> json) =>
      _$PrizeItemFromJson(json);

  Map<String, dynamic> toJson() => _$PrizeItemToJson(this);
}

@JsonSerializable()
class GiveItTo {
  int? id;
  String? name;
  int? score;
  @JsonKey(name: 'golden_coins')
  int? goldenCoins;
  @JsonKey(name: 'silver_coins')
  int? silverCoins;
  @JsonKey(name: 'bronze_coins')
  int? bronzeCoins;
  @JsonKey(name: 'profile_picture')
  String? profilePicture;
  String? inactive;
  @JsonKey(name: 'borrow_limit')
  int? borrowLimit;
  @JsonKey(name: 'g_class_id')
  int? gClassId;

  GiveItTo({
    this.id,
    this.name,
    this.score,
    this.goldenCoins,
    this.silverCoins,
    this.bronzeCoins,
    this.profilePicture,
    this.inactive,
    this.borrowLimit,
    this.gClassId,
  });

  factory GiveItTo.fromJson(Map<String, dynamic> json) =>
      _$GiveItToFromJson(json);

  Map<String, dynamic> toJson() => _$GiveItToToJson(this);
}

@JsonSerializable()
class Prize {
  int? id;
  @JsonKey(name: 'score_points')
  int? scorePoints;
  @JsonKey(name: 'golden_coin')
  int? goldenCoin;
  @JsonKey(name: 'silver_coin')
  int? silverCoin;
  @JsonKey(name: 'bronze_coin')
  int? bronzeCoin;

  Prize({
    this.id,
    this.scorePoints,
    this.goldenCoin,
    this.silverCoin,
    this.bronzeCoin,
  });

  factory Prize.fromJson(Map<String, dynamic> json) => _$PrizeFromJson(json);

  Map<String, dynamic> toJson() => _$PrizeToJson(this);
}
