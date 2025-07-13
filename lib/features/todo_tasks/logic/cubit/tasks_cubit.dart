import 'package:bloc/bloc.dart';
import 'package:english_club/features/todo_tasks/data/repos/tasks_repo.dart';
import 'package:english_club/features/todo_tasks/data/models/tasks_response.dart'; // Ensure this import is correct
import 'package:english_club/features/todo_tasks/logic/cubit/tasks_state.dart'; // Ensure this import is correct

class TasksCubit extends Cubit<TasksState> {
  final TasksRepo _tasksRepo;

  TasksCubit(this._tasksRepo) : super(const TasksState.initial());

  void emitGetTasks() async {
    emit(const TasksState.loading());
    final response = await _tasksRepo.getTasks();
    response.when(
      success: (tasksResponse) {
        List<DoneData> doneTasks = [];
        List<Waiting> waitingTasks = [];

        if (tasksResponse.data?.done?.data != null) {
          doneTasks = tasksResponse.data!.done!.data!;
        }

        if (tasksResponse.data?.waiting != null) {
          waitingTasks = tasksResponse.data!.waiting!;
        }

        emit(
          TasksState.success(doneTasks: doneTasks, waitingTasks: waitingTasks),
        );
      },
      failure: (error) {
        emit(
          TasksState.error(
            error: error.apiErrorModel.message ?? 'Unknown error',
          ),
        );
      },
    );
  }
}
