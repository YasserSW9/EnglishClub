import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_section_state.freezed.dart';

@freezed
class CreateSectionState<T> with _$CreateSectionState<T> {
  const factory CreateSectionState.initial() = _Initial;

  const factory CreateSectionState.loading() = Loading;
  const factory CreateSectionState.success(T data) = Success<T>;
  const factory CreateSectionState.error({required String error}) = Error;
}
