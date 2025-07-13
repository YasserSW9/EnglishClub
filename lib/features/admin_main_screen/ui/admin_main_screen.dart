// lib/admin_main_screen.dart
import 'package:english_club/features/admin_main_screen/ui/widgets/profile_page/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  bool _snackBarShown = false;

  final List<Widget> _bottomNavPages = [
    NotificationsPageContent(),
    Center(
      child: Text(
        'Search Page Content',
        style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
      ),
    ),
    ProfilePage(),
  ];

  @override
  void initState() {
    super.initState();
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
          'Welcome Back! You are logged in.', //
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
