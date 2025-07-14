import 'package:freezed_annotation/freezed_annotation.dart';

part 'collect_tasks_state.freezed.dart'; // This file will be generated

@freezed
class CollectTasksState<T> with _$CollectTasksState<T> {
  // Initial state, before any operations
  const factory CollectTasksState.initial() = _Initial;

  // Loading state, while an operation is in progress
  const factory CollectTasksState.loading() = Loading;

  // Success state, when an operation completes successfully, carrying the data
  const factory CollectTasksState.success(T data) = Success<T>;

  // Error state, when an operation fails, carrying an error message
  const factory CollectTasksState.error({required String error}) = Error;
}
