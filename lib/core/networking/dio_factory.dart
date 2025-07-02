import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioFactory {
  /// private constructor as I don't want to allow creating an instance of this class
  DioFactory._();

  static Dio? dio;

  static Dio getDio() {
    Duration timeOut = const Duration(seconds: 30);

    if (dio == null) {
      dio = Dio();
      dio!
        ..options.connectTimeout = timeOut
        ..options.receiveTimeout = timeOut;
      addDioHeaders();
      addDioInterceptor();
      return dio!;
    } else {
      return dio!;
    }
  }

  static void setTokenIntoHeaderAfterLogin(String token) {
    dio?.options.headers = {'Authorization': 'Bearer $token'};
  }

  static void addDioHeaders() async {
    dio?.options.headers = {
      'Accept': 'application/json',
      'Authorization':
          'Bearer ${"dxNkAi0OQ6yCSU5AQ0kq5R:APA91bEuF4nRHhnUhkWkBCgmrMKOyRj9i0i3Dj81HbyXu09GcPqjYTayErrFNdiqBXKRhbGqOHKsRsZ8pCnkEli0wuGPA3EQykNOgGkW5iC97lxGKfZvYXC5Oa"}',
    };
  }

  static void addDioInterceptor() {
    dio?.interceptors.add(
      PrettyDioLogger(
        requestBody: true,
        requestHeader: true,
        responseHeader: true,
      ),
    );
  }
}
