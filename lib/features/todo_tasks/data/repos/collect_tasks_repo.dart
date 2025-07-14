import 'package:english_club/core/networking/api_error_handler.dart';
import 'package:english_club/core/networking/api_result.dart';
import 'package:english_club/core/networking/api_service.dart';
import 'package:english_club/features/todo_tasks/data/models/collect_tasks.dart';

class CollectTasksRepo {
  final ApiService _apiService;

  CollectTasksRepo(this._apiService);

  Future<ApiResult<CollectTasks>> markTaskAsDone(int taskId) async {
    try {
      final response = await _apiService.getCollectTasks(taskId);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
