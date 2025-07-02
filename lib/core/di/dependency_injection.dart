import 'package:english_club/core/networking/api_service.dart';
import 'package:english_club/core/networking/dio_factory.dart';
import 'package:english_club/features/login/data/repos/login_repo.dart';
import 'package:english_club/features/login/logic/cubit/login_cubit.dart';
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
}
