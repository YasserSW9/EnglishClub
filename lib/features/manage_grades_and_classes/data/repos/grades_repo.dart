import 'package:english_club/core/networking/api_error_handler.dart';
import 'package:english_club/core/networking/api_result.dart';
import 'package:english_club/core/networking/api_service.dart';
import 'package:english_club/features/manage_grades_and_classes/data/models/grades_response.dart';

class GradesRepo {
  final ApiService _apiService;

  GradesRepo(this._apiService);

  Future<ApiResult<GradesResponse>> getGrades() async {
    try {
      final response = await _apiService.getGrades();
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
