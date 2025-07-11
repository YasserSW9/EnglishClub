import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:english_club/core/di/dependency_injection.dart';
import 'package:english_club/core/helpers/cache_manage_memory.dart';
import 'package:english_club/core/routing/approuter.dart';
import 'package:english_club/core/routing/routes.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupGetIt();
  await CashNetwork.cashInitialization();

  final String? token = CashNetwork.getCashData(key: 'user_token');

  String initialRoute;
  if (token != null && token.isNotEmpty) {
    initialRoute = Routes.adminMainScreen;
  } else {
    initialRoute = Routes.onboarding;
  }

  runApp(EnglishClub(appRouter: AppRouter(), initialRoute: initialRoute));
}

class EnglishClub extends StatelessWidget {
  final AppRouter appRouter;
  final String initialRoute;

  EnglishClub({super.key, required this.appRouter, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: initialRoute,
          onGenerateRoute: appRouter.generateRoute,
        );
      },
    );
  }
}
