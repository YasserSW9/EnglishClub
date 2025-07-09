// lib/features/student_prizes/data/repos/prizes_repo.dart
import 'package:english_club/core/networking/api_error_handler.dart';
import 'package:english_club/core/networking/api_error_model.dart';
import 'package:english_club/core/networking/api_service.dart';
import 'package:english_club/features/student_prizes/data/models/prizes_response.dart';
import 'package:english_club/core/networking/api_result.dart';
import 'package:dio/dio.dart'; // تأكد من استيراد Dio لمعالجة DioException

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

  Future<ApiResult<void>> collectPrize({
    required int studentId,
    required int prizeItemId,
  }) async {
    try {
      final response = await _apiService.collectPrize(studentId, prizeItemId);

      return const ApiResult.success(null); // لا توجد بيانات للعودة، فقط نجاح
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
