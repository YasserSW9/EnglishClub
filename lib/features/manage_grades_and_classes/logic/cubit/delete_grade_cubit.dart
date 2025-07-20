import 'package:bloc/bloc.dart';
import 'package:english_club/features/manage_grades_and_classes/data/repos/delete_grade_repo.dart';
import 'package:english_club/features/manage_grades_and_classes/logic/cubit/delete_grade_state.dart';

class DeleteGradeCubit extends Cubit<DeleteGradeState> {
  final DeleteGradeRepo deleteGradeRepo;

  DeleteGradeCubit(this.deleteGradeRepo) : super(DeleteGradeState.initial());

  void emitDeleteGrade({required String gradeId}) async {
    emit(DeleteGradeState.loading());

    final response = await deleteGradeRepo.deleteGrade(gradeId);

    response.when(
      success: (deleteGradeResponse) {
        emit(DeleteGradeState.success(deleteGradeResponse));
      },
      failure: (error) {
        emit(
          DeleteGradeState.error(
            error: error.apiErrorModel.message ?? 'Unknown error',
          ),
        );
      },
    );
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
