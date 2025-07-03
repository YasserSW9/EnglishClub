// lib/widgets/notifications_page_content.dart
import 'package:flutter/material.dart';
import 'notification_tab_bar.dart';
import 'notification_list_card.dart';

class NotificationsPageContent extends StatefulWidget {
  const NotificationsPageContent({super.key});

  @override
  State<NotificationsPageContent> createState() =>
      _NotificationsPageContentState();
}

class _NotificationsPageContentState extends State<NotificationsPageContent>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<String> generalNotifications = const [
    "Student 'taleb_aljaja_dg3' scored 27% on 'Ali Baba' with a 'Fail' evaluation. Additional support ma... (2025-07-02 10:06 AM)",
    "Admin message: System update scheduled for tonight. Expect minor downtime. (2025-06-30 08:00 PM)",
    "New course 'Advanced Python' has been added to the catalog. (2025-06-28 09:30 AM)",
  ];

  final List<String> studentNotifications = const [
    "Student 'Ziad Ahmad' has completed all sublevels in OXFORD DOMINOES & BOOKWORMS Sec... (2025-06-25 02:18 PM)",
    "Student 'Abdullah Al-Nueimi' has completed all sublevels in OXFORD READ & DISCOVER 1-6 Section/ L... (2025-06-18 10:10 AM)",
    "Student 'Abdullah Al-Nueimi' has completed all sublevels in NATIONAL GEOGRAPHIC Sectio... (2025-06-11 10:05 AM)",
    "Student 'Hamza Qutria' has completed all sublevels in OXFORD READ & DISCOVER 1-6 Section/ L... (2025-05-18 12:25 PM)",
    "Student 'Fahad Al-Dossari' has submitted his final project for review. (2025-05-15 04:00 PM)",
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {}); // لتحديث الـ UI عند تغيير التاب
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NotificationTabBar(
          tabController: _tabController,
        ), // استخدام الـ TabBar المنفصل
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              // General Notifications List
              ListView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: generalNotifications.length,
                itemBuilder: (context, index) {
                  return NotificationListCard(
                    notificationText: generalNotifications[index],
                  );
                },
              ),
              // Student Notifications List
              ListView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: studentNotifications.length,
                itemBuilder: (context, index) {
                  return NotificationListCard(
                    notificationText: studentNotifications[index],
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
