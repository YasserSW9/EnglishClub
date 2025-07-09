import 'package:english_club/core/networking/api_error_handler.dart';
import 'package:english_club/core/networking/api_result.dart';
import 'package:english_club/core/networking/api_service.dart';
import 'package:english_club/features/student_prizes/data/models/prizes_response.dart';

class PrizesRepo {
  final ApiService _apiService;

  PrizesRepo(this._apiService);

  Future<ApiResult<PrizesResponse>> getPrizes({
    int page = 1, // إضافة معلمة رقم الصفحة الافتراضية 1
    int?
    collectedStatus, // إضافة معلمة حالة التحصيل (0 لغير المجمعة، 1 للمجمعة، null للجميع)
  }) async {
    try {
      // تمرير المعلمات إلى خدمة API
      final response = await _apiService.getPrizes(page, collectedStatus);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
