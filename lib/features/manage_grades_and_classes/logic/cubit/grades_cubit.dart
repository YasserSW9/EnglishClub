import 'package:bloc/bloc.dart';
import 'package:english_club/core/networking/api_result.dart';
import 'package:english_club/features/manage_grades_and_classes/data/models/grades_response.dart';
import 'package:english_club/features/manage_grades_and_classes/data/repos/grades_repo.dart';
import 'package:english_club/features/manage_grades_and_classes/logic/cubit/grades_state.dart';

class GradesCubit extends Cubit<GradesState> {
  final GradesRepo gradesRepo;

  GradesCubit(this.gradesRepo) : super(const GradesState.initial());

  Future<void> emitGetGrades() async {
    emit(const GradesState.loading());
    final ApiResult<GradesResponse> response = await gradesRepo.getGrades();

    response.when(
      success: (gradesResponse) {
        emit(GradesState.success(gradesResponse));
      },
      failure: (error) {
        emit(
          GradesState.error(
            error: error.apiErrorModel.message ?? 'Unknown error',
          ),
        );
      },
    );
  }
}
