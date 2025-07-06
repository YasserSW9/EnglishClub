// lib/widgets/notifications_page_content.dart
import 'package:english_club/features/admin_main_screen/data/models/notifications_response.dart';
import 'package:english_club/features/admin_main_screen/logic/cubit/notifications_cubit.dart';
import 'package:english_club/features/admin_main_screen/logic/cubit/notifications_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

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
  List<NotificationItem> allNotifications = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<NotificationsCubit>().getNotifications();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<NotificationItem> _getGeneralNotifications() {
    return allNotifications
        .where((n) => n.public == 1 && n.studentId == null)
        .toList();
  }

  List<NotificationItem> _getStudentNotifications() {
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
                      allNotifications = response.data?.data ?? [];

                      final List<NotificationItem> generalNotifications =
                          _getGeneralNotifications();
                      final List<NotificationItem> studentNotifications =
                          _getStudentNotifications();

                      return TabBarView(
                        controller: _tabController,
                        children: [
                          generalNotifications.isEmpty
                              ? const Center(
                                  child: Text('No general notifications.'),
                                )
                              : ListView.builder(
                                  padding: const EdgeInsets.all(10),
                                  itemCount: generalNotifications.length,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        final notification =
                                            generalNotifications[index];
                                        AwesomeDialog(
                                          context: context,
                                          dialogType: DialogType.info,
                                          animType: AnimType.bottomSlide,
                                          borderSide: const BorderSide(
                                            color: Colors.blue,
                                            width: 2,
                                          ),
                                          buttonsBorderRadius:
                                              const BorderRadius.all(
                                                Radius.circular(12),
                                              ),
                                          headerAnimationLoop: false,
                                          title:
                                              notification.title ?? 'No Title',
                                          body: Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 16,
                                              vertical: 10,
                                            ),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: const [
                                                    Icon(
                                                      Icons.notifications,
                                                      color: Colors.blue,
                                                    ),
                                                    SizedBox(width: 8),
                                                    Text(
                                                      'Notification Details',
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 16),
                                                const Text(
                                                  "Message:",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(
                                                  notification.message ??
                                                      "No message",
                                                ),
                                                const SizedBox(height: 12),
                                                const Text(
                                                  "Date:",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(
                                                  notification.createdAt != null
                                                      ? DateTime.parse(
                                                              notification
                                                                  .createdAt!,
                                                            )
                                                            .toLocal()
                                                            .toString()
                                                            .split(' ')[0]
                                                      : 'N/A',
                                                  style: const TextStyle(
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          btnOkOnPress: () {},
                                          btnOkText: 'Close',
                                          btnOkIcon: Icons.check_circle,
                                          btnOkColor: Color(0xFF673AB7),
                                        ).show();
                                      },
                                      child: NotificationListCard(
                                        notification:
                                            studentNotifications[index],
                                      ),
                                    );
                                  },
                                ),
                          studentNotifications.isEmpty
                              ? const Center(
                                  child: Text('No student notifications.'),
                                )
                              : ListView.builder(
                                  padding: const EdgeInsets.all(10),
                                  itemCount: studentNotifications.length,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        final notification =
                                            studentNotifications[index];
                                        AwesomeDialog(
                                          context: context,
                                          dialogType: DialogType.info,
                                          animType: AnimType.bottomSlide,
                                          borderSide: const BorderSide(
                                            color: Color(0xFF673AB7),
                                            width: 2,
                                          ),
                                          buttonsBorderRadius:
                                              const BorderRadius.all(
                                                Radius.circular(12),
                                              ),
                                          headerAnimationLoop: false,
                                          title:
                                              notification.title ?? 'No Title',
                                          body: Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 16,
                                              vertical: 10,
                                            ),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: const [
                                                    Icon(
                                                      Icons.notifications,
                                                      color: Colors.purple,
                                                    ),
                                                    SizedBox(width: 8),
                                                    Text(
                                                      'Notification Details',
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 16),
                                                const Text(
                                                  "Message:",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(
                                                  notification.message ??
                                                      "No message",
                                                ),
                                                const SizedBox(height: 12),
                                                const Text(
                                                  "Date:",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(
                                                  notification.createdAt != null
                                                      ? DateTime.parse(
                                                              notification
                                                                  .createdAt!,
                                                            )
                                                            .toLocal()
                                                            .toString()
                                                            .split(' ')[0]
                                                      : 'N/A',
                                                  style: const TextStyle(
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          btnOkOnPress: () {},
                                          btnOkText: 'Close',
                                          btnOkIcon: Icons.check_circle,
                                          btnOkColor: Color(0xFF673AB7),
                                        ).show();
                                      },
                                      child: NotificationListCard(
                                        notification:
                                            studentNotifications[index],
                                      ),
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
