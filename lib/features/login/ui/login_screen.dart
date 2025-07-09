import 'package:english_club/core/helpers/spacing.dart';
import 'package:flutter/material.dart';
import 'package:english_club/features/login/logic/cubit/login_cubit.dart';
import 'package:english_club/features/login/ui/widgets/login_bloc_listener.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:english_club/features/login/ui/widgets/whatsapp_launcher.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Import the new file

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<Loginscreen> {
  final _formKey = GlobalKey<FormState>();
  bool isObscureText = true;

  // Define the WhatsApp number here
  final String supportPhoneNumber =
      '963937637222'; // Replace with your desired WhatsApp number (without '+')

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF5D2E8E), // ل
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/auth.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // ا
          Positioned.fill(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 20.h),
                Text(
                  'Swipe up',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'To signin to the english world',
                  style: TextStyle(color: Colors.white70, fontSize: 18.sp),
                ),
                SizedBox(height: 50.h),

                verticalSpacing(110),
                Image.asset("assets/images/down.gif"),
              ],
            ),
          ),

          DraggableScrollableSheet(
            initialChildSize: 0.1, //)
            minChildSize: 0.1, // ا
            maxChildSize: 0.8, //
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                ),
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(height: 10.h),
                        Container(
                          width: 40.w,
                          height: 5.h,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        SizedBox(height: 20.h),
                        const Text(
                          'Sign In',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurple,
                          ),
                        ),
                        SizedBox(height: 30.h),
                        Form(
                          key: _formKey, // Assign the form key here
                          child: Column(
                            children: [
                              TextFormField(
                                controller: context
                                    .read<LoginCubit>()
                                    .emailController,
                                decoration: InputDecoration(
                                  labelText: 'username',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  prefixIcon: const Icon(Icons.person),
                                  errorBorder: OutlineInputBorder(
                                    // Define error border
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Colors.red,
                                      width: 2.w,
                                    ),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    // Define focused error border
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Colors.red,
                                      width: 2.w,
                                    ),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Username cannot be empty';
                                  }
                                  if (value.length < 4) {
                                    return 'Username must be at least 4 characters long';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 20.h),
                              TextFormField(
                                obscureText:
                                    isObscureText, // Use the state variable here
                                controller: context
                                    .read<LoginCubit>()
                                    .passwordController,
                                decoration: InputDecoration(
                                  labelText: 'password',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  prefixIcon: const Icon(Icons.lock),
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isObscureText = !isObscureText;
                                      });
                                    },
                                    child: Icon(
                                      isObscureText
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                    ),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    // Define error border
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Colors.red,
                                      width: 2.w,
                                    ),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    // Define focused error border
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Colors.red,
                                      width: 2.w,
                                    ),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Password cannot be empty';
                                  }
                                  if (value.length < 4) {
                                    return 'Password must be at least 4 characters long';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 30.h),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              // Validate the form before proceeding
                              if (_formKey.currentState!.validate()) {
                                context.read<LoginCubit>().emitloginloaded();
                                // قم بتنفيذ منطق تسجيل الدخول هنا
                                print('Sign In button pressed');
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(
                                0xFF5D2E8E,
                              ), // لون الزر
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text(
                              'Sign In',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Or',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton.icon(
                            onPressed: () {
                              // Call the static method from WhatsAppLauncher
                              WhatsAppLauncher.launchWhatsApp(
                                context: context,
                                phoneNumber: supportPhoneNumber,
                                message:
                                    'Hello, I need assistance with the English Club app.', // Optional pre-filled message
                              );
                            },
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              side: const BorderSide(color: Color(0xFF5D2E8E)),
                            ),
                            icon: const Icon(
                              Icons.mail_outline,
                              color: Color(0xFF5D2E8E),
                            ),
                            label: Text(
                              'Contact us',
                              style: TextStyle(
                                fontSize: 18.sp,
                                color: Color(0xFF5D2E8E),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20.h),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),

          LoginBlocListener(),
        ],
      ),
    );
  }
}
