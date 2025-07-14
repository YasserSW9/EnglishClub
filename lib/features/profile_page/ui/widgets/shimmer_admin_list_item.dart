// lib/features/admin_main_screen/ui/widgets/profile_page/shimmer_admin_list_item.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerAdminListItem extends StatelessWidget {
  const ShimmerAdminListItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white54,
      shadowColor: Colors.yellowAccent,
      margin: EdgeInsets.symmetric(horizontal: 25.0.w, vertical: 13.0.h),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Padding(
          padding: EdgeInsets.all(16.0.w),
          child: Row(
            children: [
              CircleAvatar(
                radius: 20.sp, // حجم دائرة الصورة الرمزية
                backgroundColor: Colors.white, // لون خلفية عنصر الشيمر
              ),
              SizedBox(width: 15.w),
              Container(
                width: 120.w, // عرض مكان اسم المسؤول
                height: 16.h, // ارتفاع مكان اسم المسؤول
                color: Colors.white, // لون عنصر الشيمر
              ),
              const Spacer(),
              Container(
                width: 24.sp, // حجم مكان أيقونة الحذف
                height: 24.sp,
                color: Colors.white, // لون عنصر الشيمر
              ),
            ],
          ),
        ),
      ),
    );
  }
}
