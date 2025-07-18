import 'package:bloc/bloc.dart';
import 'package:english_club/features/manage_grades_and_classes/data/models/edit_grade_request_body.dart';
import 'package:english_club/features/manage_grades_and_classes/data/repos/edit_grade_repo.dart';
import 'package:english_club/features/manage_grades_and_classes/logic/cubit/edit_grade_state.dart';
import 'package:flutter/material.dart';

class EditGradeCubit extends Cubit<EditGradeState> {
  final EditGradeRepo editGradeRepo;

  TextEditingController nameController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  EditGradeCubit(this.editGradeRepo) : super(EditGradeState.initial());

  void emitEditGradeLoaded({required int gradeId}) async {
    emit(EditGradeState.loading());

    EditGradeRequestBody editGradeRequestBody = EditGradeRequestBody(
      name: nameController.text,
    );

    final response = await editGradeRepo.editGrade(
      gradeId,
      editGradeRequestBody,
    );

    response.when(
      success: (editGradeResponse) {
        emit(EditGradeState.success(editGradeResponse));
      },
      failure: (error) {
        emit(
          EditGradeState.error(
            error: error.apiErrorModel.message ?? 'Unknown error',
          ),
        );
      },
    );
  }

  @override
  Future<void> close() {
    nameController.dispose();
    return super.close();
  }
}
