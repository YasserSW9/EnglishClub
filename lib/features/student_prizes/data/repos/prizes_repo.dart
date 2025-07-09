import 'package:english_club/core/networking/api_error_handler.dart';

import 'package:english_club/core/networking/api_error_model.dart';
import 'package:english_club/core/networking/api_service.dart';
import 'package:english_club/features/student_prizes/data/models/prizes_response.dart';
import 'package:english_club/core/networking/api_result.dart'; // Assuming you have this

class PrizesRepo {
  final ApiService _apiService;

  PrizesRepo(this._apiService);

  Future<ApiResult<PrizesResponse>> getPrizes({
    required int page,
    int? collected,
  }) async {
    try {
      final response = await _apiService.getPrizes(page, collected);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}

// And in your ApiService (e.g., api_service.dart)
// Make sure your API service can accept the 'collected' parameter.
// Example:
// @GET("prizes")
// Future<PrizesResponse> getPrizes(@Query("page") int page, @Query("collected") int? collected);
