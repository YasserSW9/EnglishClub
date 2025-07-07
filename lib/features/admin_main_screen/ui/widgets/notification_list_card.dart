// lib/widgets/notification_list_card.dart
import 'package:english_club/features/admin_main_screen/data/models/notifications_response.dart';
import 'package:flutter/material.dart';

class NotificationListCard extends StatelessWidget {
  final NotificationItem notification;

  const NotificationListCard({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10.0, top: 5.0),
              child: CircleAvatar(
                backgroundColor: Colors.yellow.shade700.withOpacity(0.2),
                child: Icon(Icons.notifications, color: Colors.yellow.shade700),
                radius: 20,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    notification.title ?? 'No Title',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),

                  const SizedBox(height: 4),
                  Text(
                    'Date: ${notification.createdAt != null ? DateTime.parse(notification.createdAt!).toLocal().toString().split(' ')[0] : 'N/A'}',
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
