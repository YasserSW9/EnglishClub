import 'package:dio/dio.dart';
import 'package:english_club/core/networking/api_contants.dart';
import 'package:english_club/features/admin_main_screen/data/models/notifications_response.dart';
import 'package:english_club/features/login/data/models/login_request_body.dart';
import 'package:english_club/features/login/data/models/login_response.dart';
import 'package:english_club/features/student_prizes/data/models/prizes_response.dart';

import 'package:retrofit/retrofit.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: ApiConstants.apiBaseUrl)
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  // AUTH
  @POST(ApiConstants.login)
  Future<LoginResponse> login(@Body() LoginRequestBody loginRequestBody);

  // admin notifications
  @GET(ApiConstants.adminNotifications)
  Future<NotificationsResponse> getNotifications(@Query('page') int page);
  // admin view prizes
  @GET(ApiConstants.adminViewPrizes)
  Future<PrizesResponse> getPrizes();
}
