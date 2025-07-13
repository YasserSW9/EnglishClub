import 'package:english_club/core/networking/api_error_handler.dart';
import 'package:english_club/core/networking/api_result.dart';
import 'package:english_club/core/networking/api_service.dart';
import 'package:english_club/features/todo_tasks/data/models/tasks_response.dart'; // تأكد من المسار الصحيح للموديل

class TasksRepo {
  final ApiService _apiService;

  TasksRepo(this._apiService);

  Future<ApiResult<TasksResponse>> getTasks() async {
    try {
      final response = await _apiService.getTasks();
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
