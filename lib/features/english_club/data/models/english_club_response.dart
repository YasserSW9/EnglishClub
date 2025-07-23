import 'package:json_annotation/json_annotation.dart';

part 'english_club_response.g.dart';

@JsonSerializable()
class EnglishClubResponse {
  String? message;
  List<ClubData>? data;

  EnglishClubResponse({this.message, this.data});

  factory EnglishClubResponse.fromJson(Map<String, dynamic> json) =>
      _$EnglishClubResponseFromJson(json);

  Map<String, dynamic> toJson() => _$EnglishClubResponseToJson(this);
}

@JsonSerializable()
class ClubData {
  @JsonKey(name: "section_id")
  int? sectionId;
  @JsonKey(name: "section_name")
  String? sectionName;
  @JsonKey(name: "availableVocabularyTests")
  dynamic? availableVocabularyTests; // Can be null or other type
  List<ClubSubData>? data;

  ClubData({
    this.sectionId,
    this.sectionName,
    this.availableVocabularyTests,
    this.data,
  });

  factory ClubData.fromJson(Map<String, dynamic> json) =>
      _$ClubDataFromJson(json);

  Map<String, dynamic> toJson() => _$ClubDataToJson(this);
}

@JsonSerializable()
class ClubSubData {
  String? name;
  @JsonKey(name: "level_id")
  int? levelId;
  @JsonKey(name: "sub_level_id")
  int? subLevelId;
  @JsonKey(name: "indexLevel")
  int? indexLevel;
  @JsonKey(name: "indexSubLevel")
  int? indexSubLevel;
  @JsonKey(name: "stories_count")
  int? storiesCount;
  @JsonKey(name: "section_id")
  int? sectionId;
  dynamic? status; // Can be null or other type
  dynamic? progress; // Can be null or other type
  List<Stories>? stories;

  ClubSubData({
    this.name,
    this.levelId,
    this.subLevelId,
    this.indexLevel,
    this.indexSubLevel,
    this.storiesCount,
    this.sectionId,
    this.status,
    this.progress,
    this.stories,
  });

  factory ClubSubData.fromJson(Map<String, dynamic> json) =>
      _$ClubSubDataFromJson(json);

  Map<String, dynamic> toJson() => _$ClubSubDataToJson(this);
}

@JsonSerializable()
class Stories {
  int? id;
  @JsonKey(name: "qrCode")
  String? qrCode;
  String? title;
  dynamic? blurb; // Can be null or other type
  @JsonKey(name: "allowed_borrow_days")
  int? allowedBorrowDays;
  int? quantity;
  @JsonKey(name: "cover_url")
  String? coverUrl;
  @JsonKey(name: "sub_level_id")
  int? subLevelId;
  @JsonKey(name: "test_id")
  int? testId;

  Stories({
    this.id,
    this.qrCode,
    this.title,
    this.blurb,
    this.allowedBorrowDays,
    this.quantity,
    this.coverUrl,
    this.subLevelId,
    this.testId,
  });

  factory Stories.fromJson(Map<String, dynamic> json) =>
      _$StoriesFromJson(json);

  Map<String, dynamic> toJson() => _$StoriesToJson(this);
}
