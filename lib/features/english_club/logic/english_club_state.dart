import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:english_club/features/english_club/data/models/english_club_response.dart';

part 'english_club_state.freezed.dart';

@freezed
abstract class EnglishClubState with _$EnglishClubState {
  const factory EnglishClubState.initial() = _Initial;
  const factory EnglishClubState.loading() = Loading;

  const factory EnglishClubState.success({
    required List<ClubData> oxfordDominoesBookworms,
    required List<ClubData> oxfordReadDiscover,
    required List<ClubData> nationalGeographic,
    required List<ClubData> listeningSkill,
    required List<ClubData> otherSections,
  }) = Success;

  const factory EnglishClubState.error({required String error}) = Error;
}
