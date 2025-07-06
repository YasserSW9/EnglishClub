import 'package:bloc/bloc.dart';
import 'package:english_club/features/admin_main_screen/data/models/notifications_response.dart';
import 'package:english_club/features/admin_main_screen/data/repos/notifications_repo.dart';
import 'package:english_club/features/admin_main_screen/logic/cubit/notifications_state.dart';

class NotificationsCubit
    extends Cubit<NotificationsState<NotificationsResponse>> {
  final NotificationsRepo notificationsRepo;

  NotificationsCubit(this.notificationsRepo)
    : super(const NotificationsState.initial());

  Future<void> getNotifications() async {
    emit(const NotificationsState.loading());
    final result = await notificationsRepo.getNotifications();

    result.when(
      success: (notificationsResponse) {
        emit(NotificationsState.success(notificationsResponse));
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
}
