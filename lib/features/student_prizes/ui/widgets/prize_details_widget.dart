// lib/features/prizes/ui/widgets/prize_details_widget.dart
import 'package:english_club/features/student_prizes/data/models/prizes_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrizeDetailsWidget extends StatelessWidget {
  final PrizeItem prizeItem;

  const PrizeDetailsWidget({super.key, required this.prizeItem});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 5.h),
          child: Text("Reason", style: TextStyle(fontSize: 25.sp)),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8.h),
          child: Text(
            prizeItem.reason ?? "No reason provided",
            style: TextStyle(fontSize: 13.sp),
          ),
        ),
        if (prizeItem.date != null && prizeItem.date!.isNotEmpty)
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            child: Text(
              "Date: ${prizeItem.date}",
              style: TextStyle(fontSize: 13.sp, color: Colors.grey[600]),
            ),
          ),
        SizedBox(height: 10.h),
        _buildIconTextRow(
          'assets/images/studentScore.png',
          "Score: ${prizeItem.giveItTo?.score ?? 0}",
          width: 30.w,
          height: 30.h,
        ),
        SizedBox(height: 20.h),
        _buildIconTextRow(
          'assets/images/golden.png',
          "Golden cards: ${prizeItem.giveItTo?.goldenCoins ?? 0}",
          width: 30.w,
          height: 24.h,
        ),
        SizedBox(height: 20.h),
        _buildIconTextRow(
          'assets/images/silver.png',
          "Silver cards: ${prizeItem.giveItTo?.silverCoins ?? 0}",
          width: 30.w,
          height: 30.h,
        ),
        SizedBox(height: 20.h),
        _buildIconTextRow(
          'assets/images/bronze.png',
          "Bronze cards: ${prizeItem.giveItTo?.bronzeCoins ?? 0}",
          width: 30.w,
          height: 30.h,
        ),
      ],
    );
  }

  Widget _buildIconTextRow(
    String imagePath,
    String text, {
    double? width,
    double? height,
  }) {
    return Row(
      children: [
        Image.asset(imagePath, width: width, height: height),
        SizedBox(width: 8.w),
        Text(text, style: TextStyle(fontSize: 15.sp)),
      ],
    );
  }
}
