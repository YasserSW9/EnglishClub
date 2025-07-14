// lib/features/admin_main_screen/data/repos/admin_repo.dart
import 'package:english_club/core/networking/api_error_handler.dart';
import 'package:english_club/core/networking/api_result.dart';
import 'package:english_club/core/networking/api_service.dart';
import 'package:english_club/features/profile_page/data/model/admin_response.dart';

class AdminRepo {
  final ApiService _apiService;

  AdminRepo(this._apiService);

  // تغيير نوع الإرجاع ليصبح قائمة من AdminResponse
  Future<ApiResult<List<AdminResponse>>> getAdminData() async {
    try {
      final response = await _apiService.getAdminData();
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
