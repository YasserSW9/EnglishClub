import 'package:english_club/features/todo_tasks/ui/widgets/task_card.dart';
import 'package:flutter/material.dart';

class WaitingTaskList extends StatelessWidget {
  final List<Map<String, dynamic>> tasks;
  final Function(Map<String, dynamic>, int) onMarkAsDone;

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
