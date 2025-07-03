// lib/admin_main_screen.dart
import 'package:flutter/material.dart';
import 'widgets/custom_app_bar.dart';
import 'widgets/custom_bottom_navigation_bar.dart';
import 'widgets/notifications_page_content.dart';

class AdminMainScreen extends StatefulWidget {
  const AdminMainScreen({super.key});

  @override
  State<AdminMainScreen> createState() => _AdminMainScreenState();
}

class _AdminMainScreenState extends State<AdminMainScreen> {
  int _currentBottomNavIndex = 0;

  final List<Widget> _bottomNavPages = const [
    NotificationsPageContent(),
    Center(
      child: Text(
        'Search Page Content',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    ),
    Center(
      child: Text(
        'Profile Page Content',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Builder(
        builder: (BuildContext innerContext) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(innerContext).showSnackBar(
              SnackBar(
                content: const Text(
                  'Welcome Back! You are logged in.', // رسالة الترحيب
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                backgroundColor: Colors.green, // لون الخلفية أخضر
                duration: const Duration(seconds: 2), // مدة ظهور الرسالة
                behavior: SnackBarBehavior.floating, // لجعلها تظهر كـ floating
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // حواف دائرية
                ),
                margin: const EdgeInsets.all(50), // هامش من الحواف
              ),
            );
          });
          // ارجع المحتوى الفعلي للصفحة
          return _bottomNavPages[_currentBottomNavIndex];
        },
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentBottomNavIndex,
        onTap: (index) {
          setState(() {
            _currentBottomNavIndex = index;
          });
        },
      ),
    );
  }
}
