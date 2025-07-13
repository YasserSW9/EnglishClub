import 'package:english_club/features/todo_tasks/ui/widgets/task_card.dart';
import 'package:flutter/material.dart';

class DoneTaskList extends StatelessWidget {
  final List<Map<String, dynamic>> tasks;

  const DoneTaskList({Key? key, required this.tasks}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        return TaskCard(
          task: task,
          isWaitingList: false,
          onChanged: null, // Done tasks are not interactive
        );
      },
    );
  }
}
