import 'package:bloc/bloc.dart';

import 'package:english_club/features/english_club/data/repos/english_club_repo.dart';
import 'package:english_club/features/english_club/data/models/english_club_response.dart';
import 'package:english_club/features/english_club/logic/english_club_state.dart';

class EnglishClubCubit extends Cubit<EnglishClubState> {
  final EnglishClubRepo englishClubRepo;

  EnglishClubCubit(this.englishClubRepo)
    : super(const EnglishClubState.initial());

  void emitGetEnglishClubSections() async {
    emit(const EnglishClubState.loading());
    final response = await englishClubRepo.getSections();

    response.when(
      success: (englishClubResponse) {
        final List<ClubData> allData = englishClubResponse.data ?? [];

        final List<ClubData> oxfordDominoesBookworms = [];
        final List<ClubData> oxfordReadDiscover = [];
        final List<ClubData> nationalGeographic = [];
        final List<ClubData> listeningSkill = [];
        final List<ClubData> otherSections = [];

        for (var item in allData) {
          switch (item.sectionName) {
            case "OXFORD DOMINOES & BOOKWORMS":
              oxfordDominoesBookworms.add(item);
              break;
            case "OXFORD READ & DISCOVER 1-6":
              oxfordReadDiscover.add(item);
              break;
            case "NATIONAL GEOGRAPHIC":
              nationalGeographic.add(item);
              break;
            case "LISTENING SKILL":
              listeningSkill.add(item);
              break;
            default:
              otherSections.add(item);
              break;
          }
        }

        emit(
          EnglishClubState.success(
            oxfordDominoesBookworms: oxfordDominoesBookworms,
            oxfordReadDiscover: oxfordReadDiscover,
            nationalGeographic: nationalGeographic,
            listeningSkill: listeningSkill,
            otherSections: otherSections,
          ),
        );
      },
      failure: (error) {
        emit(
          EnglishClubState.error(
            error: error.apiErrorModel.message ?? 'Unknown error',
          ),
        );
      },
    );
  }
}
