import 'package:english_club/core/networking/api_error_handler.dart';
import 'package:english_club/core/networking/api_result.dart';
import 'package:english_club/core/networking/api_service.dart';
import 'package:english_club/features/manage_grades_and_classes/data/models/delete_grade_response.dart'; // تأكد من استيراد كلاس الاستجابة الصحيح

class DeleteGradeRepo {
  final ApiService _apiService;

  DeleteGradeRepo(this._apiService);

  Future<ApiResult<DeleteGradeResponse>> deleteGrade(
    String deleteGradeId,
  ) async {
    try {
      final response = await _apiService.deleteGrade(deleteGradeId);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
