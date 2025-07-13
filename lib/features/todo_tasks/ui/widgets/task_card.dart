import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:english_club/features/todo_tasks/data/models/tasks_response.dart'; // استيراد الموديلات

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
    String requiredAction = '';
    String issuedAt = '';
    String? doneAt;
    String? doneBy;
    String storyTitle = 'N/A';
    String studentName = 'N/A';
    bool isDone = false;

    if (isWaitingList) {
      final waitingTask = task as Waiting;
      requiredAction = waitingTask.requiredAction ?? 'N/A';
      issuedAt = waitingTask.issuedAt ?? 'N/A';
      isDone = waitingTask.done == 1;

      storyTitle = waitingTask.unreturnedStory?.title ?? 'N/A';
      studentName = waitingTask.student?.name ?? 'N/A';
    } else {
      final doneTask = task as DoneData;
      requiredAction = doneTask.requiredAction ?? 'N/A';
      issuedAt = doneTask.issuedAt ?? 'N/A';
      doneAt = doneTask.doneAt ?? 'N/A';
      doneBy = doneTask.doneByAdmin?.name ?? 'N/A';
      isDone = doneTask.done == 1;

      storyTitle = doneTask.unreturnedStory?.title ?? 'N/A';
      studentName = doneTask.student?.name ?? 'N/A';
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
                    'Please return \'${storyTitle}\' story from student \'${studentName}\'.',
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
