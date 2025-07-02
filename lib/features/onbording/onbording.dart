import 'package:english_club/features/onbording/widgets/image_and_text.dart';
import 'package:flutter/material.dart';

class Onboarding extends StatelessWidget {
  const Onboarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(),
        child: SafeArea(child: ImageAndText()),
      ),
    );
  }
}
