import 'package:freezed_annotation/freezed_annotation.dart';

part 'grades_state.freezed.dart';

@freezed
class GradesState<T> with _$GradesState<T> {
  const factory GradesState.initial() = _Initial;

  const factory GradesState.loading() = Loading;
  const factory GradesState.success(T data) = Success<T>;
  const factory GradesState.error({required String error}) = Error;
}
