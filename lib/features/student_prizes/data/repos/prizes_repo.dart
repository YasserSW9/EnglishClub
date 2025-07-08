import 'package:english_club/core/networking/api_error_handler.dart';
import 'package:english_club/core/networking/api_result.dart';
import 'package:english_club/core/networking/api_service.dart';
import 'package:english_club/features/student_prizes/data/models/prizes_response.dart';

class PrizesRepo {
  final ApiService _apiService;

  PrizesRepo(this._apiService);

  Future<ApiResult<PrizesResponse>> getPrizes() async {
    try {
      final response = await _apiService.getPrizes();
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
