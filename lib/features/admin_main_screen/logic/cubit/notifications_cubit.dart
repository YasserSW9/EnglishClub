import 'package:bloc/bloc.dart';
import 'package:english_club/core/networking/api_result.dart';
import 'package:english_club/features/admin_main_screen/data/models/notifications_response.dart';
import 'package:english_club/features/admin_main_screen/data/repos/notifications_repo.dart';
import 'package:english_club/features/admin_main_screen/logic/cubit/notifications_state.dart';
import 'package:flutter/material.dart'; // Import for ScrollController

class NotificationsCubit
    extends Cubit<NotificationsState<NotificationsResponse>> {
  final NotificationsRepo notificationsRepo;

  NotificationsCubit(this.notificationsRepo)
    : super(const NotificationsState.initial());

  int _currentPage = 1;
  final List<NotificationItem> _allNotifications = [];
  bool _hasMoreData = true;
  bool _isLoadingMore = false;

  final ScrollController scrollController = ScrollController();

  List<NotificationItem> get allNotifications => _allNotifications;
  bool get hasMoreData => _hasMoreData;
  bool get isLoadingMore => _isLoadingMore;

  void initScrollController() {
    scrollController.addListener(_onScroll);
  }

  void disposeScrollController() {
    scrollController.dispose();
  }

  void _onScroll() {
    if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent &&
        _hasMoreData &&
        !_isLoadingMore) {
      loadMoreNotifications();
    }
  }

  Future<void> getNotifications({bool isRefresh = false}) async {
    if (isRefresh) {
      _currentPage = 1;
      _allNotifications.clear();
      _hasMoreData = true;
    }

    if (!_hasMoreData && !isRefresh) {
      emit(
        NotificationsState.success(
          NotificationsResponse(
            data: NotificationsData(data: _allNotifications),
          ),
        ),
      );
      return;
    }

    if (_allNotifications.isEmpty || isRefresh) {
      emit(const NotificationsState.loading());
    }

    final result = await notificationsRepo.getNotifications(page: _currentPage);

    result.when(
      success: (notificationsResponse) {
        if (notificationsResponse.data?.data != null) {
          _allNotifications.addAll(notificationsResponse.data!.data!);
          if (notificationsResponse.data!.nextPageUrl == null) {
            _hasMoreData = false;
          } else {
            _currentPage++;
          }
        } else {
          _hasMoreData = false;
        }
        emit(
          NotificationsState.success(
            NotificationsResponse(
              data: NotificationsData(data: _allNotifications),
            ),
          ),
        );
      },
      failure: (error) {
        emit(
          NotificationsState.error(
            error: error.apiErrorModel.message ?? 'Unknown error',
          ),
        );
      },
    );
  }

  Future<void> loadMoreNotifications() async {
    if (!_hasMoreData || _isLoadingMore) return;

    _isLoadingMore = true;
    emit(
      NotificationsState.success(
        NotificationsResponse(data: NotificationsData(data: _allNotifications)),
      ),
    );

    final result = await notificationsRepo.getNotifications(page: _currentPage);

    result.when(
      success: (notificationsResponse) {
        if (notificationsResponse.data?.data != null) {
          _allNotifications.addAll(notificationsResponse.data!.data!);
          if (notificationsResponse.data!.nextPageUrl == null) {
            _hasMoreData = false;
          } else {
            _currentPage++;
          }
        } else {
          _hasMoreData = false;
        }
        _isLoadingMore = false;
        emit(
          NotificationsState.success(
            NotificationsResponse(
              data: NotificationsData(data: _allNotifications),
            ),
          ),
        );
      },
      failure: (error) {
        _isLoadingMore = false;
        emit(
          NotificationsState.error(
            error:
                error.apiErrorModel.message ??
                'Failed to load more notifications',
          ),
        );
      },
    );
  }
}
