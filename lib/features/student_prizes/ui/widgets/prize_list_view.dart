// lib/features/prizes/ui/widgets/prize_list_view.dart
import 'package:english_club/features/student_prizes/data/models/prizes_response.dart';
import 'package:english_club/features/student_prizes/ui/widgets/single_prize_tile.dart';
import 'package:english_club/features/student_prizes/ui/widgets/shimmer_loading_widgets.dart'; // تأكد من استيراد الشيمر
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrizeListView extends StatelessWidget {
  final List<PrizeItem> prizes;
  final TabController tabController;
  // تم إزالة final Function() onPrizeCollected;
  final ScrollController scrollController;
  final bool isLoadingMore;
  final bool hasMoreData;

  const PrizeListView({
    super.key,
    required this.prizes,
    required this.tabController,
    // تم إزالة required this.onPrizeCollected,
    required this.scrollController,
    required this.isLoadingMore,
    required this.hasMoreData,
  });

  @override
  Widget build(BuildContext context) {
    if (prizes.isEmpty && !isLoadingMore) {
      return Center(
        child: Text(
          'No prizes found in this category.',
          style: TextStyle(fontSize: 16.sp, color: Colors.black),
        ),
      );
    }

    final int itemCount = prizes.length + (_hasFooter ? 1 : 0);

    return ListView.builder(
      controller: scrollController,
      itemCount: itemCount,
      padding: EdgeInsets.symmetric(vertical: 8.h),
      itemBuilder: (context, i) {
        if (_hasFooter && i == prizes.length) {
          if (isLoadingMore) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 20.h),
              child: Column(
                children: List.generate(
                  1,
                  (index) => ShimmerLoadingWidgets.buildShimmerListItem(),
                ),
              ),
            );
          } else if (!hasMoreData) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 20.h),
              child: Center(
                child: Text(
                  'No more prizes to load.',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: const Color.fromARGB(255, 41, 41, 41),
                  ),
                ),
              ),
            );
          }
        }

        // Render the regular prize tile
        final prizeItem = prizes[i];
        return SinglePrizeTile(
          prizeItem: prizeItem,
          index: i,
          tabController: tabController,
          // تم إزالة onPrizeCollected: onPrizeCollected,
        );
      },
    );
  }

  // Helper getter to determine if a footer (loading or end-of-list) should be shown
  bool get _hasFooter => isLoadingMore || !hasMoreData;
}
