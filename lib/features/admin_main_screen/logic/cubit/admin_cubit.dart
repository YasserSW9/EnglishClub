// lib/features/admin/logic/cubit/admin_cubit.dart
import 'package:bloc/bloc.dart';
import 'package:english_club/core/networking/api_result.dart';
import 'package:english_club/features/admin_main_screen/data/repos/admin_repo.dart';
import 'package:english_club/features/admin_main_screen/logic/cubit/admin_state.dart';
// تأكد من استيراد AdminResponse

class AdminCubit extends Cubit<AdminState> {
  final AdminRepo adminRepo;

  AdminCubit(this.adminRepo) : super(const AdminState.initial());

  void emitGetAdminData() async {
    emit(const AdminState.loading());
    final response = await adminRepo.getAdminData();
    response.when(
      success: (admins) {
        emit(AdminState.success(admins));
      },
      failure: (error) {
        emit(
          AdminState.error(
            error: error.apiErrorModel.message ?? 'Unknown error',
          ),
        );
      },
    );
  }
}
