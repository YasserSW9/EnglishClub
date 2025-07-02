import 'package:flutter/material.dart';

import 'package:english_club/features/login/logic/cubit/login_cubit.dart';
import 'package:english_club/features/login/ui/widgets/login_bloc_listener.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<Loginscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF5D2E8E), // لون الخلفية الأرجواني
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/auth.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // الخلفية مع نص "LEARN"
          Positioned.fill(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // يمكنك استبدال هذا بنص "LEARN" أو صورة إذا أردت
                // للحصول على تأثير يشبه تصميمك، يمكن استخدام Text أو Image
                const SizedBox(height: 20),
                const Text(
                  'Swipe up',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  'To signin to the english world',
                  style: TextStyle(color: Colors.white70, fontSize: 18),
                ),
                const SizedBox(height: 50), // مسافة لتحديد مكان السهم
                Icon(Icons.keyboard_arrow_down, color: Colors.white, size: 50),
                Icon(Icons.keyboard_arrow_down, color: Colors.white, size: 50),
                Icon(Icons.keyboard_arrow_down, color: Colors.white, size: 50),
              ],
            ),
          ),

          // واجهة تسجيل الدخو
          DraggableScrollableSheet(
            initialChildSize: 0.1, // الحجم الأولي عند الفتح (10% من الشاشة)
            minChildSize:
                0.1, // الحد الأدنى لحجم السحب (لا يمكن إخفاؤه بالكامل)
            maxChildSize: 0.8, // الحد الأقصى لحجم السحب (80% من الشاشة)
            builder: (BuildContext context, ScrollController scrollController) {
              bool isObscureText = true;
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
                        const SizedBox(height: 10),
                        // مقبض السحب
                        Container(
                          width: 40,
                          height: 5,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Sign In',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurple,
                          ),
                        ),
                        const SizedBox(height: 30),
                        Form(
                          child: TextFormField(
                            controller: context
                                .read<LoginCubit>()
                                .emailController,
                            decoration: InputDecoration(
                              labelText: 'username',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              prefixIcon: const Icon(Icons.person),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Form(
                          child: TextFormField(
                            obscureText: true,
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
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              context.read<LoginCubit>().emitloginloaded();

                              // قم بتنفيذ منطق تسجيل الدخول هنا
                              print('Sign In button pressed');
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
                              // قم بتنفيذ منطق "Contact us" هنا
                              print('Contact us button pressed');
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
                            label: const Text(
                              'Contact us',
                              style: TextStyle(
                                fontSize: 18,
                                color: Color(0xFF5D2E8E),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
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
