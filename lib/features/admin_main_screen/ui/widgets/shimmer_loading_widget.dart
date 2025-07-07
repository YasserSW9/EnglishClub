import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoadingWidget extends StatelessWidget {
  final int itemCount;
  final double itemHeight;
  final EdgeInsetsGeometry padding;

  const ShimmerLoadingWidget({
    super.key,
    this.itemCount = 11, // قيمة افتراضية لعدد العناصر
    this.itemHeight = 80.0, // قيمة افتراضية لارتفاع العنصر
    this.padding = const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListView.builder(
        shrinkWrap: true, // مهم للسماح لـ ListView بالانكماش وتناسب المساحة
        physics:
            const NeverScrollableScrollPhysics(), // لمنع التمرير أثناء الشيمر
        itemCount: itemCount,
        itemBuilder: (context, index) {
          return Padding(
            padding: padding, // استخدام البادينج القابل للتخصيص
            child: Container(
              height: itemHeight,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          );
        },
      ),
    );
  }
}
