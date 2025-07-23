import 'package:bloc/bloc.dart';
import 'package:english_club/features/english_club/data/models/create_section_request_body.dart';
import 'package:english_club/features/english_club/data/repos/create_section_repo.dart';
import 'package:english_club/features/english_club/logic/create_section_state.dart';
import 'package:flutter/material.dart';

class CreateSectionCubit extends Cubit<CreateSectionState> {
  final CreateSectionRepo _createSectionRepo;
  final TextEditingController sectionNameController = TextEditingController();

  CreateSectionCubit(this._createSectionRepo)
    : super(const CreateSectionState.initial());

  void emitCreateSection() async {
    emit(const CreateSectionState.loading());
    CreateSectionRequestBody createSectionRequestBody =
        CreateSectionRequestBody(name: sectionNameController.text);
    final response = await _createSectionRepo.createSection(
      createSectionRequestBody,
    );
    response.when(
      success: (createSectionResponse) {
        emit(CreateSectionState.success(createSectionResponse));
      },
      failure: (error) {
        emit(
          CreateSectionState.error(
            error: error.apiErrorModel.message ?? 'Unknown error',
          ),
        );
      },
    );
  }
}
