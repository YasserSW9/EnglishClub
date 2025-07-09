import 'package:english_club/core/helpers/extensions.dart';
import 'package:english_club/core/routing/routes.dart';
import 'package:english_club/core/themeing/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Onboarding extends StatelessWidget {
  const Onboarding({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 59, 32, 105),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 3,
                child: Image.asset(
                  'assets/images/Animation - 1751310555673.gif',
                ),
              ),
              SizedBox(height: 40.h),
              Text(
                'Own it, Read it, Prove it',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20.h),
              Text(
                'Your Reading Journey reimagined! Learn efficiently with tailored lessons, interactive quizzes, and progress tracking. Start your journey today and build a better future with strong English skills! "Read, Learn, Advance - then repeat success!"',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16.sp,
                  height: 1.5,
                ),
              ),
              SizedBox(height: 60.h),
              SizedBox(
                width: double.infinity,
                height: 50.h,
                child: ElevatedButton(
                  onPressed: () {
                    context.pushReplacementNamed(Routes.loginScreen);
                    print('Let\'s get started pressed!');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 232, 236, 243),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    textStyle: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  child: const Text('Let\'s get started'),
                ),
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}
