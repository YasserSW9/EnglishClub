import 'package:freezed_annotation/freezed_annotation.dart';

part 'delete_grade_state.freezed.dart';

@freezed
class DeleteGradeState<T> with _$DeleteGradeState<T> {
  const factory DeleteGradeState.initial() = _Initial;

  const factory DeleteGradeState.loading() = Loading;
  const factory DeleteGradeState.success(T data) = Success<T>;
  const factory DeleteGradeState.error({required String error}) = Error;
}
