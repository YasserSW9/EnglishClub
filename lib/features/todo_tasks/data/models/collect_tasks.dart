import 'package:json_annotation/json_annotation.dart';

// This allows the generated code to access the private fields in this file.
part 'collect_tasks.g.dart';

@JsonSerializable()
class CollectTasks {
  String? message;

  CollectTasks({this.message});

  // Factory constructor for creating a new CollectTasks instance from a map.
  // This uses the generated code to deserialize the JSON.
  factory CollectTasks.fromJson(Map<String, dynamic> json) =>
      _$CollectTasksFromJson(json);

  // Method to convert a CollectTasks instance to a map.
  // This uses the generated code to serialize the object to JSON.
  Map<String, dynamic> toJson() => _$CollectTasksToJson(this);
}
