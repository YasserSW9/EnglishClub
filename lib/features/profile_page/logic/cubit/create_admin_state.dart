import 'package:english_club/features/profile_page/data/model/create_admin_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_admin_state.freezed.dart';

@freezed
class CreateAdminState with _$CreateAdminState {
  const factory CreateAdminState.initial() = _Initial;

  const factory CreateAdminState.loading() = Loading;

  const factory CreateAdminState.success(CreateAdminResponse data) = Success;

  const factory CreateAdminState.error({required String error}) = Error;
}
