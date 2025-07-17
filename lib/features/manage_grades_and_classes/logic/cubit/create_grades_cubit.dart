import 'package:bloc/bloc.dart';
import 'package:english_club/features/manage_grades_and_classes/data/models/create_grade_request_body.dart';
import 'package:english_club/features/manage_grades_and_classes/data/repos/create_grade_repo.dart';
import 'package:english_club/features/manage_grades_and_classes/logic/cubit/create_grades_state.dart';
import 'package:flutter/material.dart';

class CreateGradesCubit extends Cubit<CreateGradesState> {
  final CreateGradeRepo createGradeRepo;
  TextEditingController gradeNameController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  CreateGradesCubit(this.createGradeRepo)
    : super(const CreateGradesState.initial());

  void emitCreateGradeLoaded() async {
    emit(const CreateGradesState.loading());

    CreateGradeRequestBody createGradesRequestBody = CreateGradeRequestBody(
      name: gradeNameController.text,
    );

    final response = await createGradeRepo.createGrades(
      createGradesRequestBody,
    );

    response.when(
      success: (createGradeResponse) {
        emit(CreateGradesState.success(createGradeResponse));
      },
      failure: (error) {
        emit(
          CreateGradesState.error(
            error: error.apiErrorModel.message ?? 'Unknown Error',
          ),
        );
      },
    );
  }

  @override
  Future<void> close() {
    gradeNameController.dispose();
    return super.close();
  }
}
