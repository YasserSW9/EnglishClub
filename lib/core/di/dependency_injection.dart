import 'package:english_club/core/networking/api_service.dart';
import 'package:english_club/core/networking/dio_factory.dart';
import 'package:english_club/features/add_students_manually/data/repos/create_student_repo.dart';
import 'package:english_club/features/add_students_manually/logic/create_student_cubit.dart';
import 'package:english_club/features/english_club/data/repos/create_section_repo.dart';
import 'package:english_club/features/english_club/logic/create_section_cubit.dart';
import 'package:english_club/features/manage_grades_and_classes/data/repos/create_grade_repo.dart';
import 'package:english_club/features/manage_grades_and_classes/data/repos/delete_grade_repo.dart';
import 'package:english_club/features/manage_grades_and_classes/data/repos/edit_grade_repo.dart';
import 'package:english_club/features/manage_grades_and_classes/data/repos/grades_repo.dart';
import 'package:english_club/features/manage_grades_and_classes/logic/cubit/create_grades_cubit.dart';
import 'package:english_club/features/manage_grades_and_classes/logic/cubit/delete_grade_cubit.dart';
import 'package:english_club/features/manage_grades_and_classes/logic/cubit/edit_grade_cubit.dart';
import 'package:english_club/features/manage_grades_and_classes/logic/cubit/grades_cubit.dart';
import 'package:english_club/features/profile_page/data/repos/admin_repo.dart';
import 'package:english_club/features/profile_page/data/repos/create_admin_repo.dart';
import 'package:english_club/features/profile_page/data/repos/delete_admin_repo.dart';
import 'package:english_club/features/admin_main_screen/data/repos/notifications_repo.dart';
import 'package:english_club/features/profile_page/logic/cubit/admin_cubit.dart';
import 'package:english_club/features/profile_page/logic/cubit/create_admin_cubit.dart';
import 'package:english_club/features/profile_page/logic/cubit/delete_admin_cubit.dart';
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
  getIt.registerFactory<LoginCubit>(() => LoginCubit(getIt()));
  // admin notifications
  getIt.registerLazySingleton<NotificationsRepo>(
    () => NotificationsRepo(getIt()),
  );
  getIt.registerFactory<NotificationsCubit>(() => NotificationsCubit(getIt()));
  // admin view prizes
  getIt.registerLazySingleton<PrizesRepo>(() => PrizesRepo(getIt()));
  getIt.registerFactory<PrizesCubit>(() => PrizesCubit(getIt()));
  // view all admins
  getIt.registerLazySingleton<AdminRepo>(() => AdminRepo(getIt()));
  getIt.registerFactory<AdminCubit>(() => AdminCubit(getIt()));
  //Delete admin
  getIt.registerLazySingleton<DeleteAdminRepo>(() => DeleteAdminRepo(getIt()));
  getIt.registerFactory<DeleteAdminCubit>(() => DeleteAdminCubit(getIt()));
  // Create admin
  getIt.registerLazySingleton<CreateAdminRepo>(() => CreateAdminRepo(getIt()));
  getIt.registerFactory<CreateAdminCubit>(() => CreateAdminCubit(getIt()));
  // GET Tasks
  getIt.registerLazySingleton<TasksRepo>(() => TasksRepo(getIt()));
  getIt.registerFactory<TasksCubit>(() => TasksCubit(getIt()));
  // Patch tasks
  getIt.registerLazySingleton<CollectTasksRepo>(
    () => CollectTasksRepo(getIt()),
  );
  getIt.registerFactory<CollectTasksCubit>(() => CollectTasksCubit(getIt()));
  // grades and classess
  getIt.registerLazySingleton<GradesRepo>(() => GradesRepo(getIt()));
  getIt.registerFactory<GradesCubit>(() => GradesCubit(getIt()));
  // create grades
  getIt.registerLazySingleton<CreateGradeRepo>(() => CreateGradeRepo(getIt()));
  getIt.registerFactory<CreateGradesCubit>(() => CreateGradesCubit(getIt()));
  // edit grades
  getIt.registerLazySingleton<EditGradeRepo>(() => EditGradeRepo(getIt()));
  getIt.registerFactory<EditGradeCubit>(() => EditGradeCubit(getIt()));
  // delete grade
  getIt.registerLazySingleton<DeleteGradeRepo>(() => DeleteGradeRepo(getIt()));
  getIt.registerFactory<DeleteGradeCubit>(() => DeleteGradeCubit(getIt()));
  // create student
  getIt.registerLazySingleton<CreateStudentRepo>(
    () => CreateStudentRepo(getIt()),
  );
  getIt.registerFactory<CreateStudentCubit>(() => CreateStudentCubit(getIt()));
  // create section
  getIt.registerLazySingleton<CreateSectionRepo>(
    () => CreateSectionRepo(getIt()),
  );
  getIt.registerFactory<CreateSectionCubit>(() => CreateSectionCubit(getIt()));
}
