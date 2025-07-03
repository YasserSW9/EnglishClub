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
  // Add a boolean flag to track if the SnackBar has been shown
  bool _snackBarShown = false;

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
  void initState() {
    super.initState();
    // Schedule the SnackBar to be shown after the first frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_snackBarShown) {
        _showWelcomeSnackBar();
      }
    });
  }

  void _showWelcomeSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text(
          'Welcome Back! You are logged in.', // رسالة
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.green, //
        duration: const Duration(seconds: 2), //
        behavior: SnackBarBehavior.floating, //
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10), //
        ),
        margin: const EdgeInsets.all(50), //
      ),
    );
    // Set the flag to true after showing the SnackBar
    _snackBarShown = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: _bottomNavPages[_currentBottomNavIndex],
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
