// This file was partially accessible
import 'package:bloc/bloc.dart';
import 'package:english_club/features/todo_tasks/data/models/collect_tasks.dart';
import 'package:english_club/features/todo_tasks/data/repos/collect_tasks_repo.dart';
import 'package:english_club/features/todo_tasks/logic/cubit/collect_tasks_state.dart';

class CollectTasksCubit extends Cubit<CollectTasksState<CollectTasks>> {
  final CollectTasksRepo collectTasksRepo;

  CollectTasksCubit(this.collectTasksRepo)
    : super(const CollectTasksState.initial());

  Future<void> emitMarkTaskAsDoneState(int taskId) async {
    emit(const CollectTasksState.loading());

    final response = await collectTasksRepo.markTaskAsDone(taskId);

    response.when(
      success: (collectTasksResponse) {
        emit(CollectTasksState.success(collectTasksResponse));
      },
      failure: (error) {
        // Handle failure. 'error' contains the API error details.
        emit(
          CollectTasksState.error(
            error: error.apiErrorModel.message ?? 'Unknown error occurred.',
          ),
        );
      },
    );
  }
}
