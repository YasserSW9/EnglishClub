// lib/widgets/notifications_page_content.dart
import 'package:english_club/features/admin_main_screen/data/models/notifications_response.dart';
import 'package:english_club/features/admin_main_screen/logic/cubit/notifications_cubit.dart';
import 'package:english_club/features/admin_main_screen/logic/cubit/notifications_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  List<NotificationItem> allNotifications = []; // قائمة واحدة لجميع الإشعارات

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {}); // لتحديث الـ UI عند تغيير التبويب
    });

    // استدعاء جلب الإشعارات عند تهيئة الشاشة
    // تأكد أن NotificationsCubit متاح في الـ context
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<NotificationsCubit>().getNotifications();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // هذه الدالة ستقوم بتقسيم الإشعارات بناءً على 'public' و 'studentId'
  // بما أن الـ API يرجع قائمة واحدة في 'data', سنحتاج لفلترتها
  List<NotificationItem> _getGeneralNotifications() {
    // الإشعارات العامة: غالباً ما تكون 'public' true وليس لها studentId
    return allNotifications
        .where((n) => n.public == 1 && n.studentId == null)
        .toList();
  }

  List<NotificationItem> _getStudentNotifications() {
    // إشعارات الطلاب: غالباً ما يكون لها studentId
    return allNotifications.where((n) => n.studentId != null).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NotificationTabBar(tabController: _tabController),
        Expanded(
          child:
              BlocBuilder<
                NotificationsCubit,
                NotificationsState<NotificationsResponse>
              >(
                builder: (context, state) {
                  return state.when(
                    initial: () =>
                        const Center(child: Text('Loading notifications...')),
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    success: (response) {
                      // تحديث القائمة بالبيانات الفعلية من الـ API
                      // الوصول إلى قائمة الإشعارات الفعلية من response.data!.data
                      allNotifications = response.data?.data ?? [];

                      // تصفية الإشعارات بناءً على التبويبات
                      final List<NotificationItem> generalNotifications =
                          _getGeneralNotifications();
                      final List<NotificationItem> studentNotifications =
                          _getStudentNotifications();

                      return TabBarView(
                        controller: _tabController,
                        children: [
                          // General Notifications Tab
                          generalNotifications.isEmpty
                              ? const Center(
                                  child: Text('No general notifications.'),
                                )
                              : ListView.builder(
                                  padding: const EdgeInsets.all(10),
                                  itemCount: generalNotifications.length,
                                  itemBuilder: (context, index) {
                                    return NotificationListCard(
                                      notification: generalNotifications[index],
                                    );
                                  },
                                ),
                          // Student Notifications Tab
                          studentNotifications.isEmpty
                              ? const Center(
                                  child: Text('No student notifications.'),
                                )
                              : ListView.builder(
                                  padding: const EdgeInsets.all(10),
                                  itemCount: studentNotifications.length,
                                  itemBuilder: (context, index) {
                                    return NotificationListCard(
                                      notification: studentNotifications[index],
                                    );
                                  },
                                ),
                        ],
                      );
                    },
                    error: (errorMsg) => Center(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.error_outline,
                              color: Colors.red,
                              size: 50,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Error loading notifications: $errorMsg',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.red,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () {
                                context
                                    .read<NotificationsCubit>()
                                    .getNotifications();
                              },
                              child: const Text('Retry'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
        ),
      ],
    );
  }
}
