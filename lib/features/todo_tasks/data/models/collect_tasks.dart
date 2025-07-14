import 'package:json_annotation/json_annotation.dart';

part 'collect_tasks.g.dart';

@JsonSerializable()
class CollectTasks {
  String? message;

  CollectTasks({this.message});

  factory CollectTasks.fromJson(Map<String, dynamic> json) =>
      _$CollectTasksFromJson(json);

  Map<String, dynamic> toJson() => _$CollectTasksToJson(this);
}
