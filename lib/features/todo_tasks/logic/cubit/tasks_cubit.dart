import 'package:bloc/bloc.dart';
import 'package:english_club/features/todo_tasks/data/repos/tasks_repo.dart';
import 'package:english_club/features/todo_tasks/data/models/tasks_response.dart';
import 'package:english_club/features/todo_tasks/logic/cubit/tasks_state.dart';

class TasksCubit extends Cubit<TasksState> {
  final TasksRepo _tasksRepo;

  TasksCubit(this._tasksRepo) : super(const TasksState.initial());

  int _currentPage = 1;
  bool _hasMoreData = true;
  List<Waiting> _allWaitingTasks = [];
  List<DoneData> _allDoneTasks = [];

  bool get hasMoreData => _hasMoreData;

  void emitGetTasks() async {
    _currentPage = 1;
    _hasMoreData = true;
    _allWaitingTasks = [];
    _allDoneTasks = [];

    emit(const TasksState.loading());
    await _fetchTasks();
  }

  void emitLoadMoreTasks() async {
    if (!_hasMoreData || state is LoadingMore) {
      return;
    }

    emit(const TasksState.loadingMore());
    _currentPage++;
    await _fetchTasks();
  }

  Future<void> _fetchTasks() async {
    final response = await _tasksRepo.getTasks(pageNumber: _currentPage);
    response.when(
      success: (tasksResponse) {
        final List<DoneData> newDoneTasks =
            tasksResponse.data?.done?.data ?? [];
        final List<Waiting> newWaitingTasks = tasksResponse.data?.waiting ?? [];

        _allDoneTasks.addAll(newDoneTasks);
        _allWaitingTasks.addAll(newWaitingTasks);

        _hasMoreData =
            (tasksResponse.data?.done?.nextPageUrl != null ||
            newWaitingTasks.isNotEmpty);

        emit(
          TasksState.success(
            doneTasks: _allDoneTasks,
            waitingTasks: _allWaitingTasks,
          ),
        );
      },
      failure: (error) {
        emit(
          TasksState.error(
            error: error.apiErrorModel.message ?? 'Unknown error',
          ),
        );
        if (_currentPage > 1) {
          _currentPage--; // Decrement page on error if it was a load more
        }
      },
    );
  }

  // New method to update tasks locally after one is marked as done
  void markTaskAsDoneLocally(Waiting taskToMove) {
    // Remove from waiting tasks
    _allWaitingTasks.removeWhere((task) => task.id == taskToMove.id);

    // Create a DoneData object from the Waiting task and add to done tasks
    // You might need to adjust this conversion based on your `DoneData` structure
    final doneDataTask = DoneData(
      id: taskToMove.id,
      message: taskToMove.message,
      requiredAction: taskToMove.requiredAction,
      done: 1, // Mark as done
      issuedAt: taskToMove.issuedAt,
      doneAt: DateTime.now().toIso8601String(), // Set current time
      adminId: taskToMove.adminId,
      storyId: taskToMove.storyId,
      studentId: taskToMove.studentId,
      // Add other fields from Waiting to DoneData as needed
    );
    _allDoneTasks.insert(0, doneDataTask); // Add to the beginning of done list

    emit(
      TasksState.success(
        doneTasks: List.from(
          _allDoneTasks,
        ), // Create new list instances to ensure state change
        waitingTasks: List.from(_allWaitingTasks),
      ),
    );
  }
}
