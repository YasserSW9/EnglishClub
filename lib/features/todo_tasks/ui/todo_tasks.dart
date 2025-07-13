import 'package:english_club/core/helpers/extensions.dart';
import 'package:english_club/features/todo_tasks/ui/widgets/done_task_list.dart';
import 'package:english_club/features/todo_tasks/ui/widgets/waiting_task_list.dart';
import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class TodoTasks extends StatefulWidget {
  @override
  _TodoTasksState createState() => _TodoTasksState();
}

class _TodoTasksState extends State<TodoTasks>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  List<Map<String, dynamic>> waitingTasks = [
    {
      'story': 'Wheels',
      'student': 'Yahiaa Khalaf',
      'issued': '2025-03-05 00:00:04',
      'isDone': false,
    },
    {
      'story': 'Eyes',
      'student': 'Yahiaa Khalaf',
      'issued': '2025-03-05 00:00:04',
      'isDone': false,
    },
    {
      'story': 'Sinbad',
      'student': 'Wissam Trkmany',
      'issued': '2025-03-05 00:00:04',
      'isDone': false,
    },
    {
      'story': 'Wheels',
      'student': 'Malaz Al-shora',
      'issued': '2025-03-05 00:00:04',
      'isDone': false,
    },
    {
      'story': 'At the beach',
      'student': 'Malaz Al-shora',
      'issued': '2025-03-05 00:00:04',
      'isDone': false,
    },
    {
      'story': 'the mystery of manor hall',
      'student': 'Obada Feroun',
      'issued': '2025-03-05 00:00:04',
      'isDone': false,
    },
    {
      'story': 'the mystery of manor hall',
      'student': 'Hamdi Al-',
      'issued': '2025-03-05 00:00:04',
      'isDone': false,
    },
  ];

  List<Map<String, dynamic>> doneTasks = [
    {
      'story': 'Eyes',
      'student': 'Oways Al-jaghagy',
      'issued': '2025-06-26 19:13:20',
      'doneAt': '2025-06-26 11:13:20',
      'doneBy': 'fares',
      'isDone': true,
    },
    {
      'story': 'Young animals',
      'student': 'Anwar mohamad',
      'issued': '2025-05-07 16:06:46',
      'doneAt': '2025-05-07 08:06:46',
      'doneBy': 'fares',
      'isDone': true,
    },
    {
      'story': 'The giant\'s causeway',
      'student': 'Hamza Al-Halabe',
      'issued': '2025-04-30 17:15:45',
      'doneAt': '2025-04-30 09:15:45',
      'doneBy': 'fares',
      'isDone': true,
    },
    {
      'story': 'The future of a village',
      'student': 'Nour Aldden Zeelnoon',
      'issued': '2025-04-30 15:53:56',
      'doneAt': '2025-04-30 07:53:56',
      'doneBy': 'fares',
      'isDone': true,
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _markTaskAsDone(Map<String, dynamic> task, int index) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.question,
      animType: AnimType.rightSlide,
      title: 'Confirm Task Completion',
      desc:
          'Are you sure you want to mark this task as done?\n\n'
          'Story: ${task['story']}\nStudent: ${task['student']}',
      btnCancelText: 'Cancel',
      btnOkText: 'Confirm',
      btnCancelOnPress: () {
        // No action on cancel
      },
      btnOkOnPress: () {
        setState(() {
          task['isDone'] = true;
          task['doneAt'] = DateTime.now().toString().substring(0, 19);
          task['doneBy'] = 'Current User';

          waitingTasks.removeAt(index);
          doneTasks.insert(0, task);

          _tabController.animateTo(1);
        });
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
          unselectedLabelColor: Colors.black54,
          labelStyle: const TextStyle(fontWeight: FontWeight.bold),
          tabs: const [
            Tab(text: 'Waiting'),
            Tab(text: 'Done'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          WaitingTaskList(tasks: waitingTasks, onMarkAsDone: _markTaskAsDone),
          DoneTaskList(tasks: doneTasks),
        ],
      ),
    );
  }
}
