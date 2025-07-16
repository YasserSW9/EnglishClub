// lib/features/prizes/ui/student_prizes.dart
import 'package:english_club/features/student_prizes/ui/widgets/shimmer_loading_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:english_club/features/student_prizes/data/models/prizes_response.dart';
import 'package:english_club/features/student_prizes/logic/cubit/prizes_cubit.dart';
import 'package:english_club/features/student_prizes/logic/cubit/prizes_state.dart';
import 'package:english_club/features/student_prizes/ui/widgets/prize_list_view.dart';

class StudentPrizes extends StatefulWidget {
  const StudentPrizes({super.key});

  @override
  State<StudentPrizes> createState() => _StudentPrizesState();
}

class _StudentPrizesState extends State<StudentPrizes>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late PrizesCubit _prizesCubit;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _prizesCubit = context.read<PrizesCubit>();

    _prizesCubit.initScrollControllers();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _prizesCubit.getUncollectedPrizes();
      _prizesCubit.getCollectedPrizes();
    });

    _tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    if (!mounted) return;
    if (!_tabController.indexIsChanging) {
      if (_tabController.index == 0) {
        _prizesCubit.getUncollectedPrizes();
      } else {
        _prizesCubit.getCollectedPrizes();
      }
    }
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabSelection);
    _tabController.dispose();
    _prizesCubit.disposeScrollControllers();
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
          if (!mounted) return;
          state.whenOrNull(
            error: (errorMsg) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(errorMsg)));
            },
          );
        },
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
              final uncollectedPrizes = _prizesCubit.uncollectedPrizes;
              final uncollectedIsLoadingMore =
                  _prizesCubit.uncollectedIsLoadingMore;
              final uncollectedHasMoreData =
                  _prizesCubit.uncollectedHasMoreData;

              final collectedPrizes = _prizesCubit.collectedPrizes;
              final collectedIsLoadingMore =
                  _prizesCubit.collectedIsLoadingMore;
              final collectedHasMoreData = _prizesCubit.collectedHasMoreData;

              return TabBarView(
                controller: _tabController,
                children: [
                  PrizeListView(
                    prizes: uncollectedPrizes,
                    tabController: _tabController,
                    scrollController: _prizesCubit.uncollectedScrollController,
                    isLoadingMore: uncollectedIsLoadingMore,
                    hasMoreData: uncollectedHasMoreData,
                  ),
                  PrizeListView(
                    prizes: collectedPrizes,
                    tabController: _tabController,
                    scrollController: _prizesCubit.collectedScrollController,
                    isLoadingMore: collectedIsLoadingMore,
                    hasMoreData: collectedHasMoreData,
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
