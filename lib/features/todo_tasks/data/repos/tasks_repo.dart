import 'package:english_club/core/networking/api_error_handler.dart';
import 'package:english_club/core/networking/api_result.dart';
import 'package:english_club/core/networking/api_service.dart';
import 'package:english_club/features/todo_tasks/data/models/tasks_response.dart';

class TasksRepo {
  final ApiService _apiService;

  TasksRepo(this._apiService);

  // أضف pageNumber و pageSize
  Future<ApiResult<TasksResponse>> getTasks({
    required int pageNumber,
    int pageSize = 10, // عدد العناصر في كل صفحة، يمكنك تعديله حسب API الخاص بك
  }) async {
    try {
      final response = await _apiService.getTasks(
        pageNumber,
        pageSize, // أو limit، حسب تسمية الـ API
      );
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
