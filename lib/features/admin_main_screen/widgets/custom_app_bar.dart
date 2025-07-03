// lib/widgets/custom_app_bar.dart
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF673AB7),
      elevation: 0,
      title: const Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.white24,
            child: Icon(Icons.person, color: Colors.white),
          ),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Admin',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'admin',
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
            ],
          ),
        ],
      ),
      actions: [
        PopupMenuButton<String>(
          icon: const Icon(Icons.menu, color: Colors.white),
          onSelected: (String result) {
            print('Selected: $result'); // For demonstration
          },
          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
            const PopupMenuItem<String>(
              value: 'students_prizes',
              child: ListTile(
                leading: Icon(Icons.star),
                title: Text('Students Prizes'),
              ),
            ),
            const PopupMenuItem<String>(
              value: 'todo_tasks',
              child: ListTile(
                leading: Icon(Icons.checklist),
                title: Text('Todo Tasks'),
              ),
            ),
            const PopupMenuItem<String>(
              value: 'english_club',
              child: ListTile(
                leading: Icon(Icons.school),
                title: Text('English Club'),
              ),
            ),
            const PopupMenuItem<String>(
              value: 'add_students',
              child: ListTile(
                leading: Icon(Icons.person_add),
                title: Text('Add Students'),
              ),
            ),
            const PopupMenuDivider(),
            const PopupMenuItem<String>(
              value: 'logout',
              child: ListTile(
                leading: Icon(Icons.logout, color: Colors.red),
                title: Text('Logout', style: TextStyle(color: Colors.red)),
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
