import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart'; // تأكد من استيراد حزمة shimmer
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShimmerLoading extends StatelessWidget {
  final Widget child; // الـ widget الذي سيتم تطبيق الـ shimmer عليه

  const ShimmerLoading({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!, // لون القاعدة للـ shimmer
      highlightColor: Colors.grey[100]!, // لون التمييز للـ shimmer
      child: child,
    );
  }
}

// يمكنك أيضًا إنشاء تصميم Shimmer خاص ببطاقة المهمة
class TaskCardShimmer extends StatelessWidget {
  const TaskCardShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 9.h),
      elevation: 1.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    height: 16.0,
                    color: Colors.white, // هذا اللون سيتلألأ
                  ),
                  const SizedBox(height: 8.0),
                  Container(width: 150.0, height: 12.0, color: Colors.white),
                  const SizedBox(height: 8.0),
                  Container(width: 100.0, height: 12.0, color: Colors.white),
                ],
              ),
            ),
            Container(width: 24.0, height: 24.0, color: Colors.white),
          ],
        ),
      ),
    );
  }
}
