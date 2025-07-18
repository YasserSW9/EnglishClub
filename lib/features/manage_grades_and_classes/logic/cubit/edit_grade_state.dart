import 'package:freezed_annotation/freezed_annotation.dart';

part 'edit_grade_state.freezed.dart';

@freezed
class EditGradeState<T> with _$EditGradeState<T> {
  const factory EditGradeState.initial() = _Initial;

  const factory EditGradeState.loading() = Loading;
  const factory EditGradeState.success(T data) = Success<T>;
  const factory EditGradeState.error({required String error}) = Error;
}
