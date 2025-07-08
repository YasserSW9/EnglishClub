import 'package:bloc/bloc.dart';
import 'package:english_club/features/student_prizes/data/models/prizes_response.dart';
import 'package:english_club/features/student_prizes/data/repos/prizes_repo.dart';
import 'package:english_club/features/student_prizes/logic/cubit/prizes_state.dart';

class PrizesCubit extends Cubit<PrizesState<PrizesResponse>> {
  final PrizesRepo prizesRepo;

  PrizesCubit(this.prizesRepo) : super(const PrizesState.initial());

  void emitGetPrizes() async {
    emit(const PrizesState.loading());

    final response = await prizesRepo.getPrizes();

    response.when(
      success: (prizesResponse) {
        emit(PrizesState.success(prizesResponse));
      },
      failure: (error) {
        emit(PrizesState.error(error: error.apiErrorModel.message ?? ''));
      },
    );
  }
}
