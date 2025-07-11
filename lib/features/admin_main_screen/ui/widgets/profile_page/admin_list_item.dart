// lib/profile_page/widgets/admin_list_item.dart
import 'package:english_club/core/helpers/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// A reusable widget for displaying a single admin item in the list.
class AdminListItem extends StatelessWidget {
  final String adminName;
  final VoidCallback onDelete;

  const AdminListItem({
    super.key,
    required this.adminName,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white54,
      shadowColor: Colors.yellowAccent,
      margin: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 13.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              child: Icon(Icons.person_pin, color: Colors.white70, size: 25.sp),
              backgroundColor: Colors.indigo,
            ),
            horizontalSpacing(15),
            Text(adminName, style: TextStyle(fontSize: 17.sp)),
            const Spacer(),
            IconButton(
              onPressed: onDelete,
              icon: Icon(Icons.delete, size: 25.sp),
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}
