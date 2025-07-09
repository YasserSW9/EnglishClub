// lib/features/prizes/ui/widgets/prize_list_view.dart
import 'package:english_club/features/student_prizes/data/models/prizes_response.dart';
import 'package:english_club/features/student_prizes/ui/widgets/single_prize_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrizeListView extends StatelessWidget {
  final List<PrizeItem> prizes;
  final TabController tabController;
  final Function() onPrizeCollected;

  const PrizeListView({
    super.key,
    required this.prizes,
    required this.tabController,
    required this.onPrizeCollected,
  });

  @override
  Widget build(BuildContext context) {
    if (prizes.isEmpty) {
      return Center(
        child: Text(
          'No prizes found in this category.',
          style: TextStyle(fontSize: 16.sp, color: Colors.black),
        ),
      );
    }
    return ListView.builder(
      itemCount: prizes.length,
      padding: EdgeInsets.symmetric(vertical: 8.h),
      itemBuilder: (context, i) {
        final prizeItem = prizes[i];
        return SinglePrizeTile(
          prizeItem: prizeItem,
          index: i,
          tabController: tabController,
          onPrizeCollected: onPrizeCollected,
        );
      },
    );
  }
}
