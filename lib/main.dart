import 'package:english_club/core/di/dependency_injection.dart';
import 'package:english_club/core/routing/approuter.dart';
import 'package:english_club/core/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupGetIt();

  runApp(EnglishClub(appRouter: AppRouter()));
}

class EnglishClub extends StatelessWidget {
  final AppRouter appRouter;
  EnglishClub({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: Routes.onboarding,

          onGenerateRoute: appRouter.generateRoute,
        );
      },
    );
  }
}
