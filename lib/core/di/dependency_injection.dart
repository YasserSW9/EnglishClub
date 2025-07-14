import 'package:english_club/core/networking/api_service.dart';
import 'package:english_club/core/networking/dio_factory.dart';
import 'package:english_club/features/admin_main_screen/data/repos/admin_repo.dart';
import 'package:english_club/features/admin_main_screen/data/repos/create_admin_repo.dart';
import 'package:english_club/features/admin_main_screen/data/repos/delete_admin_repo.dart';
import 'package:english_club/features/admin_main_screen/data/repos/notifications_repo.dart';
import 'package:english_club/features/admin_main_screen/logic/cubit/admin_cubit.dart';
import 'package:english_club/features/admin_main_screen/logic/cubit/create_admin_cubit.dart';
import 'package:english_club/features/admin_main_screen/logic/cubit/delete_admin_cubit.dart';
import 'package:english_club/features/admin_main_screen/logic/cubit/notifications_cubit.dart';
import 'package:english_club/features/login/data/repos/login_repo.dart';
import 'package:english_club/features/login/logic/cubit/login_cubit.dart';
import 'package:english_club/features/student_prizes/data/repos/prizes_repo.dart';
import 'package:english_club/features/student_prizes/logic/cubit/prizes_cubit.dart';
import 'package:english_club/features/todo_tasks/data/repos/collect_tasks_repo.dart';
import 'package:english_club/features/todo_tasks/data/repos/tasks_repo.dart';
import 'package:english_club/features/todo_tasks/logic/cubit/collect_tasks_cubit.dart';
import 'package:english_club/features/todo_tasks/logic/cubit/tasks_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  // Dio & ApiService
  Dio dio = DioFactory.getDio();
  getIt.registerLazySingleton(() => ApiService(dio));
  // login
  getIt.registerLazySingleton<LoginRepo>(() => LoginRepo(getIt()));
  getIt.registerLazySingleton<LoginCubit>(() => LoginCubit(getIt()));
  // admin notifications
  getIt.registerLazySingleton<NotificationsRepo>(
    () => NotificationsRepo(getIt()),
  );
  getIt.registerLazySingleton<NotificationsCubit>(
    () => NotificationsCubit(getIt()),
  );
  // admin view prizes
  getIt.registerLazySingleton<PrizesRepo>(() => PrizesRepo(getIt()));
  getIt.registerLazySingleton<PrizesCubit>(() => PrizesCubit(getIt()));
  // view all admins
  getIt.registerLazySingleton<AdminRepo>(() => AdminRepo(getIt()));
  getIt.registerLazySingleton<AdminCubit>(() => AdminCubit(getIt()));
  //Delete admin
  getIt.registerLazySingleton<DeleteAdminRepo>(() => DeleteAdminRepo(getIt()));
  getIt.registerLazySingleton<DeleteAdminCubit>(
    () => DeleteAdminCubit(getIt()),
  );
  // Create admin
  getIt.registerLazySingleton<CreateAdminRepo>(() => CreateAdminRepo(getIt()));
  getIt.registerLazySingleton<CreateAdminCubit>(
    () => CreateAdminCubit(getIt()),
  );
  // GET Tasks
  getIt.registerLazySingleton<TasksRepo>(() => TasksRepo(getIt()));
  getIt.registerLazySingleton<TasksCubit>(() => TasksCubit(getIt()));
  // Patch tasks
  getIt.registerLazySingleton<CollectTasksRepo>(
    () => CollectTasksRepo(getIt()),
  );
  getIt.registerLazySingleton<CollectTasksCubit>(
    () => CollectTasksCubit(getIt()),
  );
}
