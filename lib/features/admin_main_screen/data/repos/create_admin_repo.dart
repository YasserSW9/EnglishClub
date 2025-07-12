import 'package:english_club/core/networking/api_error_handler.dart';
import 'package:english_club/core/networking/api_result.dart';
import 'package:english_club/core/networking/api_service.dart';
import 'package:english_club/features/admin_main_screen/data/models/create_admin_request_body.dart';
import 'package:english_club/features/admin_main_screen/data/models/create_admin_response.dart';

class CreateAdminRepo {
  final ApiService _apiService;

  CreateAdminRepo(this._apiService);

  Future<ApiResult<CreateAdminResponse>> createAdmin(
    CreateAdminRequestBody createAdminRequestBody,
  ) async {
    try {
      final response = await _apiService.createAdmin(createAdminRequestBody);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
