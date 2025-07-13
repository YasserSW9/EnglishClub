import 'package:english_club/features/todo_tasks/ui/widgets/task_card.dart';
import 'package:flutter/material.dart';
import 'package:english_club/features/todo_tasks/data/models/tasks_response.dart'; // Import your models

class WaitingTaskList extends StatelessWidget {
  final List<Waiting> tasks; // Changed type to List<Waiting>
  final Function(Waiting, int) onMarkAsDone;

  const WaitingTaskList({
    Key? key,
    required this.tasks,
    required this.onMarkAsDone,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        return TaskCard(
          task: task,
          isWaitingList: true,
          onChanged: (bool? newValue) {
            if (newValue == true) {
              onMarkAsDone(task, index);
            }
          },
        );
      },
    );
  }
}
