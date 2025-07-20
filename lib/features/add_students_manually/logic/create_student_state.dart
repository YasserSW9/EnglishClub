import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_student_state.freezed.dart';

@freezed
class CreateStudentState<T> with _$CreateStudentState<T> {
  const factory CreateStudentState.initial() = _Initial;

  const factory CreateStudentState.loading() = Loading;
  const factory CreateStudentState.success(T data) = Success<T>;
  const factory CreateStudentState.error({required String error}) = Error;
}
