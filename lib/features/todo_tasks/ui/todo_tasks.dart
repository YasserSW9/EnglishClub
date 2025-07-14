// lib/features/todo_tasks/ui/todo_tasks.dart
import 'package:english_club/core/helpers/extensions.dart';
import 'package:english_club/features/todo_tasks/data/models/collect_tasks.dart';
import 'package:english_club/features/todo_tasks/logic/cubit/collect_tasks_cubit.dart';
import 'package:english_club/features/todo_tasks/logic/cubit/collect_tasks_state.dart';
import 'package:english_club/features/todo_tasks/ui/widgets/done_task_list.dart';
import 'package:english_club/features/todo_tasks/ui/widgets/shimmer_loading.dart';
import 'package:english_club/features/todo_tasks/ui/widgets/waiting_task_list.dart';
import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:english_club/features/todo_tasks/logic/cubit/tasks_cubit.dart';
import 'package:english_club/features/todo_tasks/logic/cubit/tasks_state.dart';
import 'package:english_club/features/todo_tasks/data/models/tasks_response.dart';

class TodoTasks extends StatefulWidget {
  const TodoTasks({super.key});

  @override
  _TodoTasksState createState() => _TodoTasksState();
}

class _TodoTasksState extends State<TodoTasks>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final ScrollController _waitingScrollController = ScrollController();
  final ScrollController _doneScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    // Fetch initial tasks when the page initializes
    context.read<TasksCubit>().emitGetTasks();

    _waitingScrollController.addListener(() {
      if (_waitingScrollController.position.pixels ==
          _waitingScrollController.position.maxScrollExtent) {
        context.read<TasksCubit>().emitLoadMoreTasks();
      }
    });

    _doneScrollController.addListener(() {
      if (_doneScrollController.position.pixels ==
          _doneScrollController.position.maxScrollExtent) {
        context.read<TasksCubit>().emitLoadMoreTasks();
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _waitingScrollController.dispose();
    _doneScrollController.dispose();
    super.dispose();
  }

  // Function called when the checkbox in WaitingTaskList is tapped
  void _markTaskAsDone(Waiting task, int index) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.question,
      animType: AnimType.rightSlide,
      title: 'Confirm Task Completion\n',
      desc: 'Are you sure you want to mark this task as done?\n',
      btnCancelText: 'Cancel',
      btnOkText: 'Confirm',
      btnCancelOnPress: () {},
      btnOkOnPress: () {
        // Invoke the CollectTasksCubit here
        if (task.id != null) {
          context.read<CollectTasksCubit>().emitMarkTaskAsDoneState(task.id!);
        } else {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.error,
            animType: AnimType.rightSlide,
            title: 'Error',
            desc: 'Task ID is missing. Cannot mark as done.',
            btnOkOnPress: () {},
          ).show();
        }
      },
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'System Tasks',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF673AB7),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            context.pop();
          },
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.grey,
          labelStyle: const TextStyle(fontWeight: FontWeight.bold),
          tabs: const [
            Tab(text: 'Waiting'),
            Tab(text: 'Done'),
          ],
        ),
      ),
      // Use MultiBlocListener to listen to both TasksCubit and CollectTasksCubit
      body: MultiBlocListener(
        listeners: [
          // BlocListener for CollectTasksCubit to handle task completion response
          BlocListener<CollectTasksCubit, CollectTasksState<CollectTasks>>(
            listener: (context, state) {
              state.whenOrNull(
                loading: () {
                  // Optional: You can show a small loading indicator here
                  // context.showLoadingDialog(); // Example: if you have a helper function
                },
                success: (response) {
                  // context.pop(); // Close any loading indicator
                  // Show success message
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.success,
                    animType: AnimType.rightSlide,
                    title: 'Success',
                    desc:
                        response.message ?? 'Task marked as done successfully!',
                    btnOkOnPress: () {
                      // After success: Refresh the main task list
                      context.read<TasksCubit>().emitGetTasks();
                      // Navigate to the "Done" tab
                      _tabController.animateTo(1);
                    },
                  ).show();
                },
                error: (error) {
                  // context.pop(); // Close any loading indicator
                  // Show error message
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.error,
                    animType: AnimType.rightSlide,
                    title: 'Error',
                    desc: error,
                    btnOkOnPress: () {},
                  ).show();
                },
              );
            },
          ),
        ],
        child: BlocBuilder<TasksCubit, TasksState>(
          builder: (context, state) {
            final tasksCubit = context.read<TasksCubit>();

            final bool isLoadingMore = state is LoadingMore;
            final bool hasMoreData = tasksCubit.hasMoreData;

            return state.when(
              initial: () => const Center(child: Text('Initializing Tasks...')),
              loading: () {
                return ShimmerLoading(
                  child: TabBarView(
                    controller: _tabController,
                    children: List.generate(
                      2,
                      (tabIndex) => ListView.builder(
                        padding: const EdgeInsets.all(8.0),
                        itemCount: 5,
                        itemBuilder: (context, index) =>
                            const TaskCardShimmer(),
                      ),
                    ),
                  ),
                );
              },
              success: (doneTasks, waitingTasks) {
                return TabBarView(
                  controller: _tabController,
                  children: [
                    WaitingTaskList(
                      tasks: waitingTasks,
                      onMarkAsDone:
                          _markTaskAsDone, // Pass the function to the Checkbox
                      scrollController: _waitingScrollController,
                      hasMoreData: hasMoreData,
                      isLoadingMore: isLoadingMore,
                    ),
                    DoneTaskList(
                      tasks: doneTasks,
                      scrollController: _doneScrollController,
                      hasMoreData: hasMoreData,
                      isLoadingMore: isLoadingMore,
                    ),
                  ],
                );
              },
              loadingMore: () {
                List<DoneData> doneTasks = [];
                List<Waiting> waitingTasks = [];

                tasksCubit.state.maybeWhen(
                  success: (_doneTasks, _waitingTasks) {
                    doneTasks = _doneTasks;
                    waitingTasks = _waitingTasks;
                  },
                  orElse: () {},
                );

                return TabBarView(
                  controller: _tabController,
                  children: [
                    WaitingTaskList(
                      tasks: waitingTasks,
                      onMarkAsDone: _markTaskAsDone, // Pass the function
                      scrollController: _waitingScrollController,
                      hasMoreData: hasMoreData,
                      isLoadingMore: isLoadingMore,
                    ),
                    DoneTaskList(
                      tasks: doneTasks,
                      scrollController: _doneScrollController,
                      hasMoreData: hasMoreData,
                      isLoadingMore: isLoadingMore,
                    ),
                  ],
                );
              },
              error: (error) =>
                  Center(child: Text('An error occurred: $error')),
            );
          },
        ),
      ),
    );
  }
}
