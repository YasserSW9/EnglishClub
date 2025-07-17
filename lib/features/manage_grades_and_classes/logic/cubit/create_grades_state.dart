import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_grades_state.freezed.dart';

@freezed
class CreateGradesState<T> with _$CreateGradesState<T> {
  const factory CreateGradesState.initial() = _Initial;

  const factory CreateGradesState.loading() = Loading;
  const factory CreateGradesState.success(T data) = Success<T>;
  const factory CreateGradesState.error({required String error}) = Error;
}
