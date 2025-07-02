import 'package:english_club/core/helpers/extensions.dart';
import 'package:english_club/core/helpers/spacing.dart';
import 'package:english_club/core/routing/routes.dart';
import 'package:english_club/core/themeing/font_weight_helper.dart';
import 'package:english_club/core/widgets/app_text_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ImageAndText extends StatelessWidget {
  const ImageAndText({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 200.h,
          width: 200.w,
          child: Image.asset(
            "assets/images/Animation - 1751310555673.gif",
            fit: BoxFit.contain,
          ),

          margin: EdgeInsets.symmetric(horizontal: 50.w, vertical: 10.h),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
        ),

        Container(
          margin: EdgeInsets.symmetric(vertical: 12.h),
          child: Text(
            "Own it, Read it, Prove it",
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 30.sp,
              fontWeight: FontWeightHelper.extraBold,
              color: Colors.black54,
            ),
          ),
        ),
        verticalSpacing(30),
        Container(
          margin: EdgeInsets.all(12.w),
          alignment: Alignment.center,
          child: Text(
            'Your Reading Journey,Reimagined! '
            ' Learn efficiently with tailored lessons,interactive quizzes,and progress tracking.'
            ' Start your journey today and build a better future with strong English skills! '
            '"Read, Learn, Advance - then repeat success!"',

            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeightHelper.medium,
              color: Colors.black45,
            ),
            textAlign: TextAlign.center,
            textDirection: TextDirection.ltr,
          ),
        ),
        verticalSpacing(150.h),
        AppTextButton(
          borderRadius: 500,
          buttonText: "Get Started",
          textStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeightHelper.extraBold,
            fontSize: 15.sp,
          ),
          onPressed: () {
            // TODO pushReplacementNamed
            context.pushNamed(Routes.loginScreen);
          },
          backgroundColor: Colors.blue,
          buttonWidth: 200.w,
        ),
      ],
    );
  }
}
