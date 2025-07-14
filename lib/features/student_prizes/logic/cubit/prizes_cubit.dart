import 'package:bloc/bloc.dart';
import 'package:english_club/features/student_prizes/data/models/prizes_response.dart';
import 'package:english_club/features/student_prizes/data/repos/prizes_repo.dart';
import 'package:english_club/features/student_prizes/logic/cubit/prizes_state.dart';
import 'package:flutter/material.dart';

class PrizesCubit extends Cubit<PrizesState<PrizesResponse>> {
  final PrizesRepo prizesRepo;

  PrizesCubit(this.prizesRepo) : super(const PrizesState.initial());

  int _uncollectedCurrentPage = 1;
  final List<PrizeItem> _uncollectedPrizes = [];
  bool _uncollectedHasMoreData = true;
  bool _uncollectedIsLoadingMore = false;
  ScrollController? uncollectedScrollController;

  int _collectedCurrentPage = 1;
  final List<PrizeItem> _collectedPrizes = [];
  bool _collectedHasMoreData = true;
  bool _collectedIsLoadingMore = false;
  ScrollController? collectedScrollController;

  List<PrizeItem> get uncollectedPrizes => _uncollectedPrizes;
  bool get uncollectedHasMoreData => _uncollectedHasMoreData;
  bool get uncollectedIsLoadingMore => _uncollectedIsLoadingMore;

  List<PrizeItem> get collectedPrizes => _collectedPrizes;
  bool get collectedHasMoreData => _collectedHasMoreData;
  bool get collectedIsLoadingMore => _collectedIsLoadingMore;

  void initScrollControllers() {
    uncollectedScrollController = ScrollController();
    collectedScrollController = ScrollController();

    uncollectedScrollController?.addListener(_onUncollectedScroll);
    collectedScrollController?.addListener(_onCollectedScroll);
  }

  @override
  Future<void> close() {
    disposeScrollControllers();
    return super.close();
  }

  void disposeScrollControllers() {
    uncollectedScrollController?.removeListener(_onUncollectedScroll);
    collectedScrollController?.removeListener(_onCollectedScroll);
    uncollectedScrollController?.dispose();
    collectedScrollController?.dispose();
    uncollectedScrollController = null;
    collectedScrollController = null;
  }

  void _onUncollectedScroll() {
    if (uncollectedScrollController == null ||
        !uncollectedScrollController!.hasClients)
      return;
    if (uncollectedScrollController!.position.pixels ==
            uncollectedScrollController!.position.maxScrollExtent &&
        _uncollectedHasMoreData &&
        !_uncollectedIsLoadingMore) {
      loadMoreUncollectedPrizes();
    }
  }

  void _onCollectedScroll() {
    if (collectedScrollController == null ||
        !collectedScrollController!.hasClients)
      return;
    if (collectedScrollController!.position.pixels ==
            collectedScrollController!.position.maxScrollExtent &&
        _collectedHasMoreData &&
        !_collectedIsLoadingMore) {
      loadMoreCollectedPrizes();
    }
  }

  Future<void> getUncollectedPrizes({bool isRefresh = false}) async {
    if (isClosed) return;
    if (isRefresh) {
      _uncollectedCurrentPage = 1;
      _uncollectedPrizes.clear();
      _uncollectedHasMoreData = true;
    }
    if (!_uncollectedHasMoreData &&
        !isRefresh &&
        _uncollectedPrizes.isNotEmpty) {
      if (isClosed) return;
      emit(
        PrizesState.success(
          PrizesResponse(data: PrizesData(data: _uncollectedPrizes)),
        ),
      );
      return;
    }
    if (_uncollectedPrizes.isEmpty || isRefresh) {
      if (isClosed) return;
      emit(const PrizesState.loading());
    }
    _uncollectedIsLoadingMore = true;
    final result = await prizesRepo.getPrizes(
      page: _uncollectedCurrentPage,
      collected: 0,
    );
    if (isClosed) return;
    result.when(
      success: (prizesResponse) {
        if (prizesResponse.data?.data != null) {
          _uncollectedPrizes.addAll(prizesResponse.data!.data!);
          if (prizesResponse.data!.data!.length < 10) {
            _uncollectedHasMoreData = false;
          } else {
            _uncollectedCurrentPage++;
          }
        } else {
          _uncollectedHasMoreData = false;
        }
        _uncollectedIsLoadingMore = false;
        if (isClosed) return;
        emit(
          PrizesState.success(
            PrizesResponse(
              data: PrizesData(data: _uncollectedPrizes),
              message: prizesResponse.message,
            ),
          ),
        );
      },
      failure: (error) {
        _uncollectedIsLoadingMore = false;
        if (isClosed) return;
        emit(
          PrizesState.error(
            error:
                error.apiErrorModel.message ??
                'Unknown error fetching uncollected prizes',
          ),
        );
      },
    );
  }

  Future<void> getCollectedPrizes({bool isRefresh = false}) async {
    if (isClosed) return;
    if (isRefresh) {
      _collectedCurrentPage = 1;
      _collectedPrizes.clear();
      _collectedHasMoreData = true;
    }
    if (!_collectedHasMoreData && !isRefresh && _collectedPrizes.isNotEmpty) {
      if (isClosed) return;
      emit(
        PrizesState.success(
          PrizesResponse(data: PrizesData(data: _collectedPrizes)),
        ),
      );
      return;
    }
    if (_collectedPrizes.isEmpty || isRefresh) {
      if (isClosed) return;
      emit(const PrizesState.loading());
    }
    _collectedIsLoadingMore = true;
    final result = await prizesRepo.getPrizes(
      page: _collectedCurrentPage,
      collected: 1,
    );
    if (isClosed) return;
    result.when(
      success: (prizesResponse) {
        if (prizesResponse.data?.data != null) {
          _collectedPrizes.addAll(prizesResponse.data!.data!);
          if (prizesResponse.data!.data!.length < 10) {
            _collectedHasMoreData = false;
          } else {
            _collectedCurrentPage++;
          }
        } else {
          _collectedHasMoreData = false;
        }
        _collectedIsLoadingMore = false;
        if (isClosed) return;
        emit(
          PrizesState.success(
            PrizesResponse(
              data: PrizesData(data: _collectedPrizes),
              message: prizesResponse.message,
            ),
          ),
        );
      },
      failure: (error) {
        _collectedIsLoadingMore = false;
        if (isClosed) return;
        emit(
          PrizesState.error(
            error:
                error.apiErrorModel.message ??
                'Unknown error fetching collected prizes',
          ),
        );
      },
    );
  }

  Future<void> loadMoreUncollectedPrizes() async {
    if (isClosed) return;
    if (!_uncollectedHasMoreData || _uncollectedIsLoadingMore) return;
    await getUncollectedPrizes();
  }

  Future<void> loadMoreCollectedPrizes() async {
    if (isClosed) return;
    if (!_collectedHasMoreData || _collectedIsLoadingMore) return;
    await getCollectedPrizes();
  }

  Future<void> collectPrize({
    required int studentId,
    required int prizeItemId,
  }) async {
    if (isClosed) return;
    emit(const PrizesState.loading());

    final result = await prizesRepo.collectPrize(
      studentId: studentId,
      prizeItemId: prizeItemId,
    );
    if (isClosed) return;

    result.when(
      success: (_) {
        getUncollectedPrizes(isRefresh: true);
        getCollectedPrizes(isRefresh: true);

        if (isClosed) return;
        emit(
          PrizesState.success(
            PrizesResponse(
              message: "Prize collected successfully!",
              data: PrizesData(data: uncollectedPrizes),
            ),
          ),
        );
      },
      failure: (error) {
        if (isClosed) return;
        emit(
          PrizesState.error(
            error: error.apiErrorModel.message ?? 'Failed to collect prize',
          ),
        );
      },
    );
  }
}
