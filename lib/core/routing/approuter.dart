import 'package:english_club/core/di/dependency_injection.dart';
import 'package:english_club/core/routing/routes.dart';
import 'package:english_club/features/home/home_screen.dart';
import 'package:english_club/features/login/logic/cubit/login_cubit.dart'
    show LoginCubit;
import 'package:english_club/features/login/ui/login_Screen.dart';
import 'package:english_club/features/login/ui/login_screen.dart'
    hide Loginscreen;
import 'package:english_club/features/onbording/onboarding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    //this arguments to be passed in any screen like this ( arguments as ClassName )
    // ignore: unused_local_variable
    final arguments = settings.arguments;

    switch (settings.name) {
      case Routes.onboarding:
        return MaterialPageRoute(builder: (_) => Onboarding());
      case Routes.loginScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<LoginCubit>(),
            child: Loginscreen(),
          ),
        );
      case Routes.homeScreen:
        return MaterialPageRoute(builder: (_) => HomeScreen());

      default:
        return null;
    }
  }
}
