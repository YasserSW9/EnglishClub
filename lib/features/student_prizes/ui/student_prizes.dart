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
  // Hold a reference to the Cubit
  late PrizesCubit _prizesCubit; // New: Reference to the Cubit

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    _prizesCubit = context.read<PrizesCubit>(); // Initialize Cubit reference

    // Initialize the Cubit's scroll controller
    _prizesCubit.initScrollController();

    // Fetch prizes after the first frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _prizesCubit.getPrizes(); // Call getPrizes on the Cubit
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _prizesCubit
        .disposeScrollController(); // Dispose the Cubit's scroll controller
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
      body: BlocConsumer<PrizesCubit, PrizesState<PrizesResponse>>(
        listener: (context, state) {
          state.whenOrNull(
            error: (errorMsg) {
              // Optionally show a SnackBar or Toast for errors
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(errorMsg)));
            },
          );
        },
        builder: (context, state) {
          return state.when(
            initial: () => ListView.builder(
              itemCount: 5, // Show 5 shimmer items
              itemBuilder: (context, index) =>
                  ShimmerLoadingWidgets.buildShimmerListItem(),
            ),
            loading: () => ListView.builder(
              itemCount: 5, // Show 5 shimmer items
              itemBuilder: (context, index) =>
                  ShimmerLoadingWidgets.buildShimmerListItem(),
            ),
            success: (prizesResponse) {
              // Access data from the Cubit instance directly
              final allPrizes = _prizesCubit.allPrizes;
              final isLoadingMore = _prizesCubit.isLoadingMore;
              final hasMoreData = _prizesCubit.hasMoreData;

              // Filter prizes based on collected status
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
                  // Pass relevant Cubit properties to PrizeListView
                  PrizeListView(
                    prizes: uncollectedPrizes,
                    tabController: _tabController,
                    onPrizeCollected: () => _prizesCubit.getPrizes(
                      isRefresh: true,
                    ), // Trigger refresh
                    // Pass the Cubit's scroll controller to the PrizeListView
                    scrollController: _prizesCubit.scrollController,
                    isLoadingMore: isLoadingMore,
                    hasMoreData: hasMoreData,
                  ),
                  PrizeListView(
                    prizes: collectedPrizes,
                    tabController: _tabController,
                    onPrizeCollected: () => _prizesCubit.getPrizes(
                      isRefresh: true,
                    ), // Trigger refresh
                    // Pass the Cubit's scroll controller to the PrizeListView
                    scrollController: _prizesCubit.scrollController,
                    isLoadingMore: isLoadingMore,
                    hasMoreData: hasMoreData,
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
