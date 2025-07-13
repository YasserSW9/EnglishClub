import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:english_club/features/todo_tasks/data/models/tasks_response.dart'; // Import your models

class TaskCard extends StatelessWidget {
  final Object task;
  final bool isWaitingList;
  final ValueChanged<bool?>? onChanged;

  const TaskCard({
    Key? key,
    required this.task,
    required this.isWaitingList,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String requiredAction = ''; // Changed from 'message' to 'requiredAction'
    String issuedAt = '';
    String? doneAt;
    String? doneBy;
    bool isDone = false;

    if (isWaitingList) {
      final waitingTask = task as Waiting;
      requiredAction =
          waitingTask.requiredAction ?? 'N/A'; // Use requiredAction
      issuedAt = waitingTask.issuedAt ?? 'N/A';
      isDone = waitingTask.done == 1; // Assuming 1 for done, 0 for waiting
    } else {
      final doneTask = task as DoneData;
      requiredAction = doneTask.requiredAction ?? 'N/A'; // Use requiredAction
      issuedAt = doneTask.issuedAt ?? 'N/A';
      doneAt = doneTask.doneAt ?? 'N/A';
      doneBy =
          doneTask.doneByAdmin?.name ?? 'N/A'; // Access name from doneByAdmin
      isDone = doneTask.done == 1; // Assuming 1 for done, 0 for waiting
    }

    return Card(
      margin: EdgeInsets.symmetric(vertical: 9.h),
      color: isDone
          ? const Color.fromARGB(255, 219, 236, 220)
          : const Color.fromARGB(255, 245, 230, 230),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    // Display the requiredAction
                    requiredAction,
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    'Issued at : $issuedAt',
                    style: TextStyle(fontSize: 12.0, color: Colors.grey[700]),
                  ),
                  if (isDone) ...[
                    const SizedBox(height: 4.0),
                    Text(
                      'Done at : ${doneAt ?? 'N/A'}',
                      style: TextStyle(fontSize: 12.0, color: Colors.grey[700]),
                    ),
                    Text(
                      'Done by : ${doneBy ?? 'N/A'}',
                      style: TextStyle(fontSize: 12.0, color: Colors.grey[700]),
                    ),
                  ],
                ],
              ),
            ),
            Checkbox(
              value: isDone,
              onChanged: onChanged,
              activeColor: const Color(0xFF66BB6A),
            ),
          ],
        ),
      ),
    );
  }
}
