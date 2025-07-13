import 'package:json_annotation/json_annotation.dart';

part 'tasks_response.g.dart';

@JsonSerializable()
class TasksResponse {
  String? message;
  Data? data;

  TasksResponse({this.message, this.data});

  factory TasksResponse.fromJson(Map<String, dynamic> json) =>
      _$TasksResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TasksResponseToJson(this);
}

@JsonSerializable()
class Data {
  Done? done;
  List<Waiting>? waiting;

  Data({this.done, this.waiting});

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class Done {
  @JsonKey(name: 'current_page')
  int? currentPage;
  List<DoneData>? data; // Renamed to avoid conflict with top-level Data
  @JsonKey(name: 'first_page_url')
  String? firstPageUrl;
  int? from;
  @JsonKey(name: 'last_page')
  int? lastPage;
  @JsonKey(name: 'last_page_url')
  String? lastPageUrl;
  List<Links>? links;
  @JsonKey(name: 'next_page_url')
  String? nextPageUrl;
  String? path;
  @JsonKey(name: 'per_page')
  int? perPage;
  @JsonKey(name: 'prev_page_url')
  String? prevPageUrl;
  int? to;
  int? total;

  Done({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  factory Done.fromJson(Map<String, dynamic> json) => _$DoneFromJson(json);

  Map<String, dynamic> toJson() => _$DoneToJson(this);
}

@JsonSerializable()
class DoneData {
  // Renamed to avoid conflict with top-level Data
  int? id;
  String? message;
  @JsonKey(name: 'required_action')
  String? requiredAction;
  int? done;
  @JsonKey(name: 'issued_at')
  String? issuedAt;
  @JsonKey(name: 'done_at')
  String? doneAt;
  @JsonKey(name: 'admin_id')
  int? adminId;
  @JsonKey(name: 'story_id')
  int? storyId;
  @JsonKey(name: 'student_id')
  int? studentId;
  @JsonKey(name: 'done_by_admin')
  DoneByAdmin? doneByAdmin;
  @JsonKey(name: 'unreturned_story')
  UnreturnedStory? unreturnedStory;
  Student? student;

  DoneData({
    this.id,
    this.message,
    this.requiredAction,
    this.done,
    this.issuedAt,
    this.doneAt,
    this.adminId,
    this.storyId,
    this.studentId,
    this.doneByAdmin,
    this.unreturnedStory,
    this.student,
  });

  factory DoneData.fromJson(Map<String, dynamic> json) =>
      _$DoneDataFromJson(json);

  Map<String, dynamic> toJson() => _$DoneDataToJson(this);
}

@JsonSerializable()
class DoneByAdmin {
  int? id;
  String? name;
  @JsonKey(name: 'super')
  int? superField; // Renamed 'super' to 'superField' as 'super' is a reserved keyword

  DoneByAdmin({this.id, this.name, this.superField});

  factory DoneByAdmin.fromJson(Map<String, dynamic> json) =>
      _$DoneByAdminFromJson(json);

  Map<String, dynamic> toJson() => _$DoneByAdminToJson(this);
}

@JsonSerializable()
class UnreturnedStory {
  int? id;
  @JsonKey(name: 'qrCode')
  String? qrCode;
  String? title;
  String? blurb; // Changed from Null? to String?
  @JsonKey(name: 'allowed_borrow_days')
  int? allowedBorrowDays;
  int? quantity;
  @JsonKey(name: 'cover_url')
  String? coverUrl;
  @JsonKey(name: 'sub_level_id')
  int? subLevelId;
  @JsonKey(name: 'test_id')
  int? testId;

  UnreturnedStory({
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

  factory UnreturnedStory.fromJson(Map<String, dynamic> json) =>
      _$UnreturnedStoryFromJson(json);

  Map<String, dynamic> toJson() => _$UnreturnedStoryToJson(this);
}

@JsonSerializable()
class Student {
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

  Student({
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

  factory Student.fromJson(Map<String, dynamic> json) =>
      _$StudentFromJson(json);

  Map<String, dynamic> toJson() => _$StudentToJson(this);
}

@JsonSerializable()
class Links {
  String? url;
  String? label;
  bool? active;

  Links({this.url, this.label, this.active});

  factory Links.fromJson(Map<String, dynamic> json) => _$LinksFromJson(json);

  Map<String, dynamic> toJson() => _$LinksToJson(this);
}

@JsonSerializable()
class Waiting {
  int? id;
  String? message;
  @JsonKey(name: 'required_action')
  String? requiredAction;
  int? done;
  @JsonKey(name: 'issued_at')
  String? issuedAt;
  @JsonKey(name: 'done_at')
  String? doneAt; // Changed from Null? to String?
  @JsonKey(name: 'admin_id')
  int? adminId; // Changed from Null? to int?
  @JsonKey(name: 'story_id')
  int? storyId;
  @JsonKey(name: 'student_id')
  int? studentId;
  @JsonKey(name: 'unreturned_story')
  UnreturnedStory? unreturnedStory;
  Student? student;

  Waiting({
    this.id,
    this.message,
    this.requiredAction,
    this.done,
    this.issuedAt,
    this.doneAt,
    this.adminId,
    this.storyId,
    this.studentId,
    this.unreturnedStory,
    this.student,
  });

  factory Waiting.fromJson(Map<String, dynamic> json) =>
      _$WaitingFromJson(json);

  Map<String, dynamic> toJson() => _$WaitingToJson(this);
}
