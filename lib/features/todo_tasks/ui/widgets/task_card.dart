import 'package:flutter/material.dart';

class TaskCard extends StatelessWidget {
  final Map<String, dynamic> task;
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
    return Card(
      margin: const EdgeInsets.only(bottom: 8.0),
      color: task['isDone']
          ? const Color.fromARGB(255, 219, 236, 220)
          : Colors.white,
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
                    'Please return \'${task['story']}\' story from student \'${task['student']}\'.',
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    'Issued at : ${task['issued']}',
                    style: TextStyle(fontSize: 12.0, color: Colors.grey[700]),
                  ),
                  if (task['isDone']) ...[
                    const SizedBox(height: 4.0),
                    Text(
                      'Done at : ${task['doneAt']}',
                      style: TextStyle(fontSize: 12.0, color: Colors.grey[700]),
                    ),
                    Text(
                      'Done by : ${task['doneBy']}',
                      style: TextStyle(fontSize: 12.0, color: Colors.grey[700]),
                    ),
                  ],
                ],
              ),
            ),
            Checkbox(
              value: task['isDone'],
              onChanged: onChanged,
              activeColor: const Color(0xFF66BB6A),
            ),
          ],
        ),
      ),
    );
  }
}
