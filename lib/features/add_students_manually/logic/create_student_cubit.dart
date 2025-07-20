import 'package:bloc/bloc.dart';
import 'package:english_club/features/add_students_manually/data/models/create_student_request_body.dart';
import 'package:english_club/features/add_students_manually/data/repos/create_student_repo.dart';
import 'package:english_club/features/add_students_manually/logic/create_student_state.dart';
import 'package:flutter/material.dart';

class CreateStudentCubit extends Cubit<CreateStudentState> {
  final CreateStudentRepo _createStudentRepo;

  TextEditingController nameController = TextEditingController();
  TextEditingController gClassIdController = TextEditingController();
  TextEditingController scoreController = TextEditingController();
  TextEditingController goldenCoinsController = TextEditingController();
  TextEditingController silverCoinsController = TextEditingController();
  TextEditingController bronzeCoinsController = TextEditingController();
  TextEditingController borrowLimitController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  CreateStudentCubit(this._createStudentRepo)
    : super(const CreateStudentState.initial());

  void emitCreateStudentLoaded() async {
    emit(const CreateStudentState.loading());

    CreateStudentRequestBody createStudentRequestBody =
        CreateStudentRequestBody(
          name: nameController.text,
          gClassId: int.tryParse(gClassIdController.text),
          score: int.tryParse(scoreController.text),
          goldenCoins: int.tryParse(goldenCoinsController.text),
          silverCoins: int.tryParse(silverCoinsController.text),
          bronzeCoins: int.tryParse(bronzeCoinsController.text),
          borrowLimit: int.tryParse(borrowLimitController.text),
        );

    final response = await _createStudentRepo.createStudent(
      createStudentRequestBody,
    );

    response.when(
      success: (createStudentResponse) async {
        emit(CreateStudentState.success(createStudentResponse));
      },
      failure: (error) {
        emit(
          CreateStudentState.error(
            error: error.apiErrorModel.message ?? 'error',
          ),
        );
      },
    );
  }

  @override
  Future<void> close() {
    nameController.dispose();
    gClassIdController.dispose();
    scoreController.dispose();
    goldenCoinsController.dispose();
    silverCoinsController.dispose();
    bronzeCoinsController.dispose();
    borrowLimitController.dispose();
    return super.close();
  }
}
