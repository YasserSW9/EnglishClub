import 'package:bloc/bloc.dart';
import 'package:english_club/features/profile_page/data/model/create_admin_request_body.dart';
import 'package:english_club/features/profile_page/data/repos/create_admin_repo.dart';
import 'package:english_club/features/profile_page/logic/cubit/create_admin_state.dart';
import 'package:flutter/material.dart'; // Required for TextEditingController and GlobalKey

class CreateAdminCubit extends Cubit<CreateAdminState> {
  final CreateAdminRepo createAdminRepo;

  TextEditingController nameController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  CreateAdminCubit(this.createAdminRepo)
    : super(const CreateAdminState.initial());

  void emitCreateAdminLoaded() async {
    emit(const CreateAdminState.loading());

    CreateAdminRequestBody createAdminRequestBody = CreateAdminRequestBody(
      name: nameController.text,
    );

    final response = await createAdminRepo.createAdmin(createAdminRequestBody);

    response.when(
      success: (createAdminResponse) {
        emit(CreateAdminState.success(createAdminResponse));
      },
      failure: (error) {
        emit(
          CreateAdminState.error(
            error: error.apiErrorModel.message ?? 'Unknown error occurred',
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
