import 'package:json_annotation/json_annotation.dart';

part 'notifications_response.g.dart'; //

@JsonSerializable()
class NotificationsResponse {
  String? message;
  NotificationsData? data;

  NotificationsResponse({this.message, this.data});

  factory NotificationsResponse.fromJson(Map<String, dynamic> json) =>
      _$NotificationsResponseFromJson(json);
}

@JsonSerializable()
class NotificationsData {
  @JsonKey(name: "current_page")
  int? currentPage;
  List<NotificationItem>? data;
  @JsonKey(name: "first_page_url")
  String? firstPageUrl;
  int? from;
  @JsonKey(name: "next_page_url")
  String? nextPageUrl;
  String? path;
  @JsonKey(name: "per_page")
  int? perPage;
  @JsonKey(name: "prev_page_url")
  String? prevPageUrl;
  int? to;

  NotificationsData({
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

  factory NotificationsData.fromJson(Map<String, dynamic> json) =>
      _$NotificationsDataFromJson(json);
}

@JsonSerializable()
class NotificationItem {
  int? id;
  String? title;
  String? message;
  int? read;
  int? public;
  @JsonKey(name: "student_id")
  int? studentId;
  @JsonKey(name: "notifiable_id")
  int? notifiableId;
  @JsonKey(name: "notifiable_type")
  String? notifiableType;
  @JsonKey(name: "created_at")
  String? createdAt;

  NotificationItem({
    this.id,
    this.title,
    this.message,
    this.read,
    this.public,
    this.studentId,
    this.notifiableId,
    this.notifiableType,
    this.createdAt,
  });

  factory NotificationItem.fromJson(Map<String, dynamic> json) =>
      _$NotificationItemFromJson(json);
}
