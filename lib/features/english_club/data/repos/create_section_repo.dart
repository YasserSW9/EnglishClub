import 'package:english_club/core/networking/api_error_handler.dart';
import 'package:english_club/core/networking/api_result.dart';
import 'package:english_club/core/networking/api_service.dart';
import 'package:english_club/features/english_club/data/models/create_section_request_body.dart';
import 'package:english_club/features/english_club/data/models/create_section_response.dart';

class CreateSectionRepo {
  final ApiService _apiService;

  CreateSectionRepo(this._apiService);

  Future<ApiResult<CreateSectionResponse>> createSection(
    CreateSectionRequestBody createSectionRequestBody,
  ) async {
    try {
      final response = await _apiService.createSection(
        createSectionRequestBody,
      );
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
