import 'package:english_club/core/networking/api_error_handler.dart';
import 'package:english_club/core/networking/api_result.dart';
import 'package:english_club/core/networking/api_service.dart';
import 'package:english_club/features/add_students_manually/data/models/create_student_request_body.dart';
import 'package:english_club/features/add_students_manually/data/models/create_student_response.dart';

class CreateStudentRepo {
  final ApiService _apiService;

  CreateStudentRepo(this._apiService);

  Future<ApiResult<CreateStudentResponse>> createStudent(
    CreateStudentRequestBody createStudentRequestBody,
  ) async {
    try {
      final response = await _apiService.createStudent(
        createStudentRequestBody,
      );
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
