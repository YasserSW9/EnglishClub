// lib/core/widgets/shimmer_loading_widgets.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoadingWidgets {
  static Widget buildShimmerListItem() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
        child: Row(
          children: [
            CircleAvatar(backgroundColor: Colors.white, radius: 24.w),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    height: 10.h,
                    color: Colors.white,
                  ),
                  SizedBox(height: 8.h),
                  Container(width: 100.w, height: 8.h, color: Colors.white),
                ],
              ),
            ),
            SizedBox(width: 16.w),
            Container(width: 24.w, height: 24.h, color: Colors.white),
          ],
        ),
      ),
    );
  }

  // Shimmer loading placeholder for an avatar (circular image)
  static Widget buildShimmerAvatar() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: const CircleAvatar(
        backgroundColor: Colors.white, // Shimmer will animate on this color
        child: Icon(Icons.person, color: Colors.grey), // Placeholder icon
      ),
    );
  }
}
