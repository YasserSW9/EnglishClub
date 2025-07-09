// lib/features/prizes/ui/student_prizes.dart
import 'package:english_club/features/student_prizes/ui/widgets/shimmer_loading_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:english_club/features/student_prizes/data/models/prizes_response.dart';
import 'package:english_club/features/student_prizes/logic/cubit/prizes_cubit.dart';
import 'package:english_club/features/student_prizes/logic/cubit/prizes_state.dart';
import 'package:english_club/features/student_prizes/ui/widgets/prize_list_view.dart'; // Import the new widget

class StudentPrizes extends StatefulWidget {
  const StudentPrizes({super.key});

  @override
  State<StudentPrizes> createState() => _StudentPrizesState();
}

class _StudentPrizesState extends State<StudentPrizes>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchPrizes();
    });
  }

  void _fetchPrizes() {
    context.read<PrizesCubit>().emitGetPrizes();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Students Prizes",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple,
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          indicatorColor: Colors.white,
          tabs: const [
            Tab(text: "Uncollected"),
            Tab(text: "Collected"),
          ],
        ),
      ),
      body: BlocBuilder<PrizesCubit, PrizesState<PrizesResponse>>(
        builder: (context, state) {
          return state.when(
            initial: () => ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) =>
                  ShimmerLoadingWidgets.buildShimmerListItem(),
            ),
            loading: () => ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) =>
                  ShimmerLoadingWidgets.buildShimmerListItem(),
            ),
            success: (prizesResponse) {
              final List<PrizeItem> allPrizes = prizesResponse.data?.data ?? [];

              debugPrint('Total Prizes: ${allPrizes.length}');

              final uncollectedPrizes = allPrizes
                  .where((item) => item.collected == 0)
                  .toList();
              final collectedPrizes = allPrizes
                  .where((item) => item.collected == 1)
                  .toList();

              debugPrint(
                'Uncollected Prizes Count: ${uncollectedPrizes.length}',
              );
              debugPrint('Collected Prizes Count: ${collectedPrizes.length}');

              return TabBarView(
                controller: _tabController,
                children: [
                  PrizeListView(
                    prizes: uncollectedPrizes,
                    tabController: _tabController,
                    onPrizeCollected: _fetchPrizes, // Pass the callback
                  ),
                  PrizeListView(
                    prizes: collectedPrizes,
                    tabController: _tabController,
                    onPrizeCollected: _fetchPrizes, // Pass the callback
                  ),
                ],
              );
            },
            error: (errorMsg) => Center(
              child: Padding(
                padding: EdgeInsets.all(20.w),
                child: Text(
                  'Error loading prizes: $errorMsg',
                  style: TextStyle(color: Colors.red, fontSize: 18.sp),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
