import 'package:english_club/core/helpers/extensions.dart';
import 'package:english_club/features/todo_tasks/ui/widgets/done_task_list.dart';
import 'package:english_club/features/todo_tasks/ui/widgets/waiting_task_list.dart';
import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // Import flutter_bloc
import 'package:english_club/features/todo_tasks/logic/cubit/tasks_cubit.dart'; // Import your cubit
import 'package:english_club/features/todo_tasks/logic/cubit/tasks_state.dart'; // Import your state
import 'package:english_club/features/todo_tasks/data/models/tasks_response.dart'; // Import your models

class TodoTasks extends StatefulWidget {
  const TodoTasks({super.key});

  @override
  _TodoTasksState createState() => _TodoTasksState();
}

class _TodoTasksState extends State<TodoTasks>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    context.read<TasksCubit>().emitGetTasks();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

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
        context.read<TasksCubit>().emitGetTasks();
        _tabController.animateTo(1); // Move to done tab
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
      body: BlocBuilder<TasksCubit, TasksState>(
        builder: (context, state) {
          return state.when(
            initial: () => const Center(child: Text('Initialize tasks...')),
            loading: () => const Center(child: CircularProgressIndicator()),
            success: (doneTasks, waitingTasks) {
              return TabBarView(
                controller: _tabController,
                children: [
                  WaitingTaskList(
                    tasks: waitingTasks,
                    onMarkAsDone: _markTaskAsDone,
                  ),
                  DoneTaskList(tasks: doneTasks),
                ],
              );
            },
            error: (error) => Center(child: Text('Error: $error')),
          );
        },
      ),
    );
  }
}
