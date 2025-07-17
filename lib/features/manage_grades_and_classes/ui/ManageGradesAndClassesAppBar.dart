import 'package:flutter/material.dart';
import 'package:english_club/core/helpers/extensions.dart'; // لتسهيل استخدام context.pop()

// ✅ ويدجت بسيطة لـ AppBar
class ManageGradesAndClassesAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const ManageGradesAndClassesAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.deepPurple,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_outlined, color: Colors.white),
        onPressed: () => context.pop(),
      ),
      title: const Text(
        'Manage Grades & Classes',
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight); // لتحديد حجم AppBar
}
