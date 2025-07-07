import 'package:english_club/features/admin_main_screen/data/models/notifications_response.dart';
import 'package:english_club/features/admin_main_screen/logic/cubit/notifications_cubit.dart';
import 'package:english_club/features/admin_main_screen/logic/cubit/notifications_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

import 'notification_tab_bar.dart';
import 'notification_list_card.dart';
import 'shimmer_loading_widget.dart';

class NotificationsPageContent extends StatefulWidget {
  const NotificationsPageContent({super.key});

  @override
  State<NotificationsPageContent> createState() =>
      _NotificationsPageContentState();
}

class _NotificationsPageContentState extends State<NotificationsPageContent>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  // ScrollController is now managed by the Cubit, so no need for a local one here.

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      // Rebuild the widget when the tab changes to update the UI if needed
      // (e.g., to show different "No notifications" messages if specific to tabs).
      // This setState is usually needed if other parts of the UI depend on the selected tab index.
      setState(() {});
    });

    // Initialize the Cubit's scroll controller to start listening for scroll events.
    context.read<NotificationsCubit>().initScrollController();

    // Trigger the initial data fetch after the first frame is rendered.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<NotificationsCubit>().getNotifications(isRefresh: true);
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    // Dispose the Cubit's scroll controller when the widget is removed from the tree.
    context.read<NotificationsCubit>().disposeScrollController();
    super.dispose();
  }

  // These filtering methods are purely presentational and can stay here.
  // They transform the comprehensive list from the Cubit into tab-specific lists.
  List<NotificationItem> _getStudentNotifications(
    List<NotificationItem> allNotifications,
  ) {
    return allNotifications.where((n) => n.studentId != null).toList();
  }

  List<NotificationItem> _getGeneralNotifications(
    List<NotificationItem> allNotifications,
  ) {
    return allNotifications
        .where((n) => n.studentId == null || (n.public ?? 1) == 1)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // TabBar remains in the UI as it's a visual component
        NotificationTabBar(tabController: _tabController),
        Expanded(
          child:
              BlocConsumer<
                NotificationsCubit,
                NotificationsState<NotificationsResponse>
              >(
                listener: (context, state) {
                  // This listener is where you'd typically handle side effects
                  // like showing Snackbars or navigation based on state changes.
                  // Since the original listener was empty, it remains empty here.
                },
                builder: (context, state) {
                  return state.when(
                    // Handle initial and loading states with shimmer
                    initial: () => const ShimmerLoadingWidget(),
                    loading: () => const ShimmerLoadingWidget(),
                    // On successful data retrieval, build the TabBarView
                    success: (response) {
                      final notificationsCubit = context
                          .read<NotificationsCubit>();
                      final allNotifications =
                          notificationsCubit.allNotifications;
                      // We only need isLoadingMore for the UI, hasMoreData is handled in Cubit
                      final isLoadingMore = notificationsCubit.isLoadingMore;
                      final scrollController =
                          notificationsCubit.scrollController;

                      final List<NotificationItem> generalNotifications =
                          _getGeneralNotifications(allNotifications);
                      final List<NotificationItem> studentNotifications =
                          _getStudentNotifications(allNotifications);

                      return TabBarView(
                        controller: _tabController,
                        children: [
                          // Build list for General Notifications
                          _buildNotificationList(
                            generalNotifications,
                            scrollController: scrollController,
                            isGeneral: true,
                            isLoadingMore: isLoadingMore,
                          ),
                          // Build list for Student Notifications
                          _buildNotificationList(
                            studentNotifications,
                            scrollController: scrollController,
                            isGeneral: false,
                            isLoadingMore: isLoadingMore,
                          ),
                        ],
                      );
                    },
                    // Handle error state display
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
                                    .getNotifications(isRefresh: true);
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

  // Consolidated method for building notification lists
  Widget _buildNotificationList(
    List<NotificationItem> notifications, {
    required ScrollController scrollController,
    required bool isGeneral,
    required bool isLoadingMore,
  }) {
    // Show "No notifications" message only if the list is empty AND no more data is being loaded
    if (notifications.isEmpty && !isLoadingMore) {
      return Center(
        child: Text(
          isGeneral
              ? 'No general notifications yet.'
              : 'No student notifications yet.',
        ),
      );
    }

    return ListView.builder(
      controller: scrollController, // Directly use the Cubit's controller
      padding: const EdgeInsets.all(10),
      // Add extra items for shimmer effect when loading more
      itemCount: notifications.length + (isLoadingMore ? 3 : 0),
      itemBuilder: (context, index) {
        if (index >= notifications.length) {
          // Display shimmer for loading more items
          return const ShimmerLoadingWidget(itemCount: 1, itemHeight: 80.0);
        }

        final notification = notifications[index];
        return InkWell(
          onTap: () {
            _showNotificationDetailsDialog(context, notification, isGeneral);
          },
          child: NotificationListCard(notification: notification),
        );
      },
    );
  }

  // Dialog remains here as it's a UI-specific interaction
  void _showNotificationDetailsDialog(
    BuildContext context,
    NotificationItem notification,
    bool isGeneral,
  ) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.info,
      animType: AnimType.bottomSlide,
      borderSide: BorderSide(
        color: isGeneral ? Colors.blue : const Color(0xFF673AB7),
        width: 2,
      ),
      buttonsBorderRadius: const BorderRadius.all(Radius.circular(12)),
      headerAnimationLoop: false,
      title: notification.title ?? 'No Title',
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.notifications,
                  color: isGeneral ? Colors.blue : Colors.purple,
                ),
                const SizedBox(width: 8),
                const Text(
                  'Notification Details',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              "Message:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(notification.message ?? "No message"),
            const SizedBox(height: 12),
            const Text("Date:", style: TextStyle(fontWeight: FontWeight.bold)),
            Text(
              notification.createdAt != null
                  ? DateTime.parse(
                      notification.createdAt!,
                    ).toLocal().toString().split(' ')[0]
                  : 'N/A',
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
      btnOkOnPress: () {},
      btnOkText: 'Close',
      btnOkIcon: Icons.check_circle,
      btnOkColor: const Color(0xFF673AB7),
    ).show();
  }
}
