import 'package:english_club/core/networking/api_error_handler.dart';
import 'package:english_club/core/networking/api_result.dart';
import 'package:english_club/core/networking/api_service.dart';
import 'package:english_club/features/manage_grades_and_classes/data/models/create_grade_request_body.dart';
import 'package:english_club/features/manage_grades_and_classes/data/models/create_grade_response.dart'; // تأكد من الاستيراد الصحيح

class CreateGradeRepo {
  final ApiService _apiService;

  CreateGradeRepo(this._apiService);

  Future<ApiResult<CreateGradeResponse>> createGrades(
    CreateGradeRequestBody createGradesRequestBody,
  ) async {
    try {
      final response = await _apiService.createGrades(createGradesRequestBody);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
