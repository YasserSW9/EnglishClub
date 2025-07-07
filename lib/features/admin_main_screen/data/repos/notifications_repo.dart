import 'package:english_club/core/networking/api_error_handler.dart';
import 'package:english_club/core/networking/api_result.dart';
import 'package:english_club/core/networking/api_service.dart';
import 'package:english_club/features/admin_main_screen/data/models/notifications_response.dart';

class NotificationsRepo {
  final ApiService _apiService;

  NotificationsRepo(this._apiService);

  // تم تعديل هذه الدالة لتأخذ معلمة 'page' كمعلمة مسماة اختيارية
  Future<ApiResult<NotificationsResponse>> getNotifications({
    int page = 1,
  }) async {
    try {
      // هنا نقوم بتمرير معلمة 'page' إلى دالة getNotifications في ApiService
      final response = await _apiService.getNotifications(page);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
