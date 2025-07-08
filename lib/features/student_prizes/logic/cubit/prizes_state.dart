import 'package:freezed_annotation/freezed_annotation.dart';

part 'prizes_state.freezed.dart';

@freezed
class PrizesState<T> with _$PrizesState<T> {
  const factory PrizesState.initial() = _Initial;

  const factory PrizesState.loading() = Loading;
  const factory PrizesState.success(T data) = Success<T>;
  const factory PrizesState.error({required String error}) = Error;
}
