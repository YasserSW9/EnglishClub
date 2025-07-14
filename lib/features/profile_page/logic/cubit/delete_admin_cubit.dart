import 'package:bloc/bloc.dart';
import 'package:english_club/features/profile_page/data/model/delete_response.dart';
import 'package:english_club/features/profile_page/data/repos/delete_admin_repo.dart';
import 'package:english_club/features/profile_page/logic/cubit/delete_admin_state.dart'; // Ensure correct path for DeleteResponse

class DeleteAdminCubit extends Cubit<DeleteAdminState> {
  final DeleteAdminRepo deleteAdminRepo; // Inject the DeleteAdminRepo

  DeleteAdminCubit(this.deleteAdminRepo) : super(DeleteAdminState.initial());

  Future<void> emitDeleteAdminLoaded(String adminId) async {
    emit(DeleteAdminState.loading());

    final response = await deleteAdminRepo.deleteAdmin(adminId);

    response.when(
      success: (deleteResponse) {
        emit(DeleteAdminState.success(deleteResponse));
      },
      failure: (error) {
        emit(
          DeleteAdminState.error(
            error: error.apiErrorModel.message ?? 'Unknown error occurred.',
          ),
        );
      },
    );
  }
}
