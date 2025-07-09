// lib/widgets/notification_tab_bar.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationTabBar extends StatelessWidget {
  final TabController tabController;

  const NotificationTabBar({super.key, required this.tabController});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF673AB7),
      child: TabBar(
        controller: tabController,
        indicator: const BoxDecoration(), //
        labelPadding: EdgeInsets.zero,
        tabs: [
          Tab(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 15),
              decoration: BoxDecoration(
                color: tabController.index == 0
                    ? const Color(0xFF8152D7)
                    : Colors.transparent,
                borderRadius: tabController.index == 0
                    ? const BorderRadius.only(
                        topRight: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      )
                    : BorderRadius.zero,
              ),
              child: const Center(
                child: Text(
                  "General notifications",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Tab(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 15),
              decoration: BoxDecoration(
                color: tabController.index == 1
                    ? const Color(0xFF8152D7)
                    : Colors.transparent,
                borderRadius: tabController.index == 1
                    ? const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                      )
                    : BorderRadius.zero,
              ),
              child: const Center(
                child: Text(
                  "Students notifications",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
