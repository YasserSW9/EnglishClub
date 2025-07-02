import 'package:english_club/core/helpers/extensions.dart';
import 'package:english_club/core/helpers/spacing.dart';
import 'package:english_club/core/routing/routes.dart';
import 'package:english_club/core/themeing/font_weight_helper.dart';
import 'package:english_club/core/widgets/app_text_button.dart';
import 'package:english_club/core/widgets/app_text_form_field.dart';
import 'package:english_club/features/login/logic/cubit/login_cubit.dart';
import 'package:english_club/features/login/ui/widgets/login_bloc_listener.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  bool isObscureText = true;
  @override
  Widget build(BuildContext context) {
    final loginCubit = context.read<LoginCubit>();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              verticalSpacing(70),
              Center(
                child: Text(
                  "Login",
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 55.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              verticalSpacing(20),
              Center(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 75.w),
                  child: Text(
                    textAlign: TextAlign.center,
                    "You must Login to your account to continue",
                    style: TextStyle(color: Colors.black87, fontSize: 20.sp),
                  ),
                ),
              ),
              verticalSpacing(50),
              Container(
                child: Text("Email", style: TextStyle(fontSize: 15.sp)),
                margin: EdgeInsets.symmetric(horizontal: 30.w),
              ),
              Form(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 15.w),
                  child: AppTextFormField(
                    controller: loginCubit.emailController,

                    hintText: "Enter your e-mail",
                    backgroundColor: Colors.white,
                    contentPadding: EdgeInsets.all(20),
                  ),
                ),
              ),
              verticalSpacing(10.h),
              Container(
                child: Text("Password", style: TextStyle(fontSize: 15.sp)),
                margin: EdgeInsets.symmetric(horizontal: 30.w),
              ),
              Form(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 15.w),
                  child: AppTextFormField(
                    controller: loginCubit.passwordController,
                    isObscureText: isObscureText,
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          isObscureText = !isObscureText;
                        });
                      },
                      child: Icon(
                        isObscureText ? Icons.visibility_off : Icons.visibility,
                      ),
                    ),
                    hintText: "Enter your Password",
                    backgroundColor: Colors.white,
                    contentPadding: EdgeInsets.all(20),
                  ),
                ),
              ),
              verticalSpacing(50.h),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30.w),
                padding: EdgeInsets.all(10),
                alignment: Alignment.center,
                child: AppTextButton(
                  borderRadius: 500,
                  buttonWidth: 200.w,
                  buttonText: "Login",
                  textStyle: TextStyle(fontSize: 18.sp, color: Colors.white),
                  onPressed: () {
                    context.read<LoginCubit>().emitloginloaded();
                    // context.pushNamed(Routes.homeScreen);
                  },
                  backgroundColor: Colors.blue,
                ),
              ),
              verticalSpacing(35.h),
              Divider(color: Colors.black),
              Container(
                child: Center(
                  child: Text(
                    "If you Dont Have An Email",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeightHelper.regular,
                      fontSize: 16.sp,
                    ),
                  ),
                ),
              ),
              verticalSpacing(20),
              Container(
                alignment: Alignment.bottomCenter,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(20),
                ),
                margin: EdgeInsets.symmetric(horizontal: 115.w),
                child: Row(
                  children: [
                    Expanded(
                      child: Icon(Icons.message, color: Colors.white),
                      flex: 1,
                    ),
                    Expanded(
                      child: MaterialButton(
                        splashColor: Colors.blue,
                        onPressed: () {},
                        child: Text(
                          "Contact Us",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                      flex: 2,
                    ),
                  ],
                ),
              ),
              LoginBlocListener(),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
          ),
        ),
      ),
    );
  }
}
