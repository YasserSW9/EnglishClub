// lib/features/admins/data/repos/delete_admin_repo.dart

import 'package:english_club/core/networking/api_error_handler.dart';
import 'package:english_club/core/networking/api_result.dart';
import 'package:english_club/core/networking/api_service.dart';
import 'package:english_club/features/admin_main_screen/data/models/delete_response.dart';

class DeleteAdminRepo {
  final ApiService _ApiService;

  DeleteAdminRepo(this._ApiService);

  Future<ApiResult<DeleteResponse>> deleteAdmin(String adminId) async {
    try {
      final response = await _ApiService.deleteAdmin(adminId);

      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
