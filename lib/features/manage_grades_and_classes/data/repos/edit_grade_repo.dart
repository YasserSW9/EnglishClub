import 'package:english_club/core/networking/api_error_handler.dart';
import 'package:english_club/core/networking/api_result.dart';
import 'package:english_club/core/networking/api_service.dart';
import 'package:english_club/features/manage_grades_and_classes/data/models/edit_grade_request_body.dart';
import 'package:english_club/features/manage_grades_and_classes/data/models/edit_grade_response.dart';

class EditGradeRepo {
  final ApiService _apiService;

  EditGradeRepo(this._apiService);

  Future<ApiResult<EditGradeResponse>> editGrade(
    int editGradeId,
    EditGradeRequestBody editGradeRequestBody,
  ) async {
    try {
      final response = await _apiService.editGrade(
        editGradeId,
        editGradeRequestBody,
      );
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
