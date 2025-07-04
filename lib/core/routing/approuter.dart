import 'package:english_club/core/di/dependency_injection.dart';
import 'package:english_club/core/routing/routes.dart';
import 'package:english_club/features/admin_main_screen/admin_main_screen.dart';
import 'package:english_club/features/english_club/english_club.dart';
import 'package:english_club/features/login/logic/cubit/login_cubit.dart'
    show LoginCubit;
import 'package:english_club/features/login/ui/login_Screen.dart';
import 'package:english_club/features/login/ui/login_screen.dart'
    hide Loginscreen;
import 'package:english_club/features/onbording/onboarding.dart';
import 'package:english_club/features/student_prizes/student_prizes.dart';
import 'package:english_club/features/add_students/add_students.dart';
import 'package:english_club/features/todo_tasks/todo_tasks.dart';
import 'package:english_club/main.dart';
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
      case Routes.adminMainScreen:
        return MaterialPageRoute(builder: (_) => AdminMainScreen());
      case Routes.studentPrizes:
        return MaterialPageRoute(builder: (_) => StudentPrizes());
      case Routes.todoTaks:
        return MaterialPageRoute(builder: (_) => TodoTasks());
      case Routes.addStudents:
        return MaterialPageRoute(builder: (_) => AddStudents());
      case Routes.englishclub:
        return MaterialPageRoute(builder: (_) => Englishclub());
      default:
        return null;
    }
  }
}
