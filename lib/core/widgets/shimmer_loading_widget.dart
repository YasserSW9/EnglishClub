// lib/widgets/shimmer_loading_widget.dart
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoadingWidget extends StatelessWidget {
  final int itemCount;

  const ShimmerLoadingWidget({super.key, this.itemCount = 5});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: 16.0,
                  color: Colors.white,
                ),
                const SizedBox(height: 8.0),
                Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  height: 12.0,
                  color: Colors.white,
                ),
                const SizedBox(height: 8.0),
                Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: 12.0,
                  color: Colors.white,
                ),
                const SizedBox(height: 16.0),
              ],
            ),
          ),
        );
      },
    );
  }
}
