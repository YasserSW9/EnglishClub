import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class GradesShimmerLoading extends StatelessWidget {
  const GradesShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 5, // Placeholder for 5 shimmer items
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(bottom: 40),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(width: 80, height: 24, color: Colors.white),
                      Container(width: 24, height: 24, color: Colors.white),
                      Container(width: 24, height: 24, color: Colors.white),
                    ],
                  ),
                  const SizedBox(height: 10),
                  // Placeholder for sections
                  for (int i = 0; i < 2; i++)
                    Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(top: 8),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 14,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Container(
                        width: double.infinity,
                        height: 20,
                        color: Colors.white,
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
