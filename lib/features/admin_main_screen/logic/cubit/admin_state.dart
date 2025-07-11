import 'package:freezed_annotation/freezed_annotation.dart';

part 'admin_state.freezed.dart';

@freezed
class AdminState<T> with _$AdminState<T> {
  const factory AdminState.initial() = _Initial;

  const factory AdminState.loading() = Loading;
  const factory AdminState.success(T data) = Success<T>;
  const factory AdminState.error({required String error}) = Error;
}
