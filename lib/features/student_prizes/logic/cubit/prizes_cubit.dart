// lib/features/student_prizes/logic/cubit/prizes_cubit.dart
import 'package:bloc/bloc.dart';
import 'package:english_club/features/student_prizes/data/models/prizes_response.dart';
import 'package:english_club/features/student_prizes/data/repos/prizes_repo.dart';
import 'package:english_club/features/student_prizes/logic/cubit/prizes_state.dart';
import 'package:flutter/material.dart';

class PrizesCubit extends Cubit<PrizesState<PrizesResponse>> {
  final PrizesRepo prizesRepo;

  PrizesCubit(this.prizesRepo) : super(const PrizesState.initial());

  // Current page number for uncollected prizes
  int _uncollectedCurrentPage = 1;
  final List<PrizeItem> _uncollectedPrizes = [];
  bool _uncollectedHasMoreData = true;
  bool _uncollectedIsLoadingMore = false;
  final ScrollController uncollectedScrollController = ScrollController();

  // Current page number for collected prizes
  int _collectedCurrentPage = 1;
  final List<PrizeItem> _collectedPrizes = [];
  bool _collectedHasMoreData = true;
  bool _collectedIsLoadingMore = false;
  final ScrollController collectedScrollController = ScrollController();

  List<PrizeItem> get uncollectedPrizes => _uncollectedPrizes;
  bool get uncollectedHasMoreData => _uncollectedHasMoreData;
  bool get uncollectedIsLoadingMore => _uncollectedIsLoadingMore;

  List<PrizeItem> get collectedPrizes => _collectedPrizes;
  bool get collectedHasMoreData => _collectedHasMoreData;
  bool get collectedIsLoadingMore => _collectedIsLoadingMore;

  void initScrollControllers() {
    uncollectedScrollController.addListener(_onUncollectedScroll);
    collectedScrollController.addListener(_onCollectedScroll);
  }

  void disposeScrollControllers() {
    uncollectedScrollController.dispose();
    collectedScrollController.dispose();
  }

  void _onUncollectedScroll() {
    if (uncollectedScrollController.position.pixels ==
            uncollectedScrollController.position.maxScrollExtent &&
        _uncollectedHasMoreData &&
        !_uncollectedIsLoadingMore) {
      loadMoreUncollectedPrizes();
    }
  }

  void _onCollectedScroll() {
    if (collectedScrollController.position.pixels ==
            collectedScrollController.position.maxScrollExtent &&
        _collectedHasMoreData &&
        !_collectedIsLoadingMore) {
      loadMoreCollectedPrizes();
    }
  }

  // Fetch Uncollected Prizes
  Future<void> getUncollectedPrizes({bool isRefresh = false}) async {
    if (isRefresh) {
      _uncollectedCurrentPage = 1;
      _uncollectedPrizes.clear();
      _uncollectedHasMoreData = true;
      _uncollectedIsLoadingMore = false;
    }

    if (!_uncollectedHasMoreData &&
        !isRefresh &&
        _uncollectedPrizes.isNotEmpty) {
      emit(
        PrizesState.success(
          PrizesResponse(data: PrizesData(data: _uncollectedPrizes)),
        ),
      );
      return;
    }

    if (_uncollectedPrizes.isEmpty || isRefresh) {
      emit(const PrizesState.loading());
    }

    final result = await prizesRepo.getPrizes(
      page: _uncollectedCurrentPage,
      collected: 0, // Request uncollected prizes
    );

    result.when(
      success: (prizesResponse) {
        if (prizesResponse.data?.data != null) {
          final filteredPrizes = prizesResponse.data!.data!
              .where((item) => item.collected == 0)
              .toList();
          _uncollectedPrizes.addAll(filteredPrizes);
          if (prizesResponse.data!.nextPageUrl == null) {
            _uncollectedHasMoreData = false;
          } else {
            _uncollectedCurrentPage++;
          }
        } else {
          _uncollectedHasMoreData = false;
        }
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

  // Fetch Collected Prizes
  Future<void> getCollectedPrizes({bool isRefresh = false}) async {
    if (isRefresh) {
      _collectedCurrentPage = 1;
      _collectedPrizes.clear();
      _collectedHasMoreData = true;
      _collectedIsLoadingMore = false;
    }

    if (!_collectedHasMoreData && !isRefresh && _collectedPrizes.isNotEmpty) {
      emit(
        PrizesState.success(
          PrizesResponse(data: PrizesData(data: _collectedPrizes)),
        ),
      );
      return;
    }

    if (_collectedPrizes.isEmpty || isRefresh) {
      emit(const PrizesState.loading());
    }

    final result = await prizesRepo.getPrizes(
      page: _collectedCurrentPage,
      collected: 1, // Request collected prizes
    );

    result.when(
      success: (prizesResponse) {
        if (prizesResponse.data?.data != null) {
          final filteredPrizes = prizesResponse.data!.data!
              .where((item) => item.collected == 1)
              .toList();
          _collectedPrizes.addAll(filteredPrizes);
          if (prizesResponse.data!.nextPageUrl == null) {
            _collectedHasMoreData = false;
          } else {
            _collectedCurrentPage++;
          }
        } else {
          _collectedHasMoreData = false;
        }
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
    if (!_uncollectedHasMoreData || _uncollectedIsLoadingMore) return;

    _uncollectedIsLoadingMore = true;

    emit(
      PrizesState.success(
        PrizesResponse(data: PrizesData(data: _uncollectedPrizes)),
      ),
    );

    final result = await prizesRepo.getPrizes(
      page: _uncollectedCurrentPage,
      collected: 0,
    );

    result.when(
      success: (prizesResponse) {
        if (prizesResponse.data?.data != null) {
          final filteredPrizes = prizesResponse.data!.data!
              .where((item) => item.collected == 0)
              .toList();
          _uncollectedPrizes.addAll(filteredPrizes);
          if (prizesResponse.data!.nextPageUrl == null) {
            _uncollectedHasMoreData = false;
          } else {
            _uncollectedCurrentPage++;
          }
        } else {
          _uncollectedHasMoreData = false;
        }
        _uncollectedIsLoadingMore = false;
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
        emit(
          PrizesState.error(
            error:
                error.apiErrorModel.message ??
                'Failed to load more uncollected prizes',
          ),
        );
      },
    );
  }

  Future<void> loadMoreCollectedPrizes() async {
    if (!_collectedHasMoreData || _collectedIsLoadingMore) return;

    _collectedIsLoadingMore = true;

    emit(
      PrizesState.success(
        PrizesResponse(data: PrizesData(data: _collectedPrizes)),
      ),
    );

    final result = await prizesRepo.getPrizes(
      page: _collectedCurrentPage,
      collected: 1,
    );

    result.when(
      success: (prizesResponse) {
        if (prizesResponse.data?.data != null) {
          final filteredPrizes = prizesResponse.data!.data!
              .where((item) => item.collected == 1)
              .toList();
          _collectedPrizes.addAll(filteredPrizes);
          if (prizesResponse.data!.nextPageUrl == null) {
            _collectedHasMoreData = false;
          } else {
            _collectedCurrentPage++;
          }
        } else {
          _collectedHasMoreData = false;
        }
        _collectedIsLoadingMore = false;
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
        emit(
          PrizesState.error(
            error:
                error.apiErrorModel.message ??
                'Failed to load more collected prizes',
          ),
        );
      },
    );
  }

  Future<void> collectPrize({
    required int studentId,
    required int prizeItemId,
  }) async {
    emit(const PrizesState.loading());

    final result = await prizesRepo.collectPrize(
      studentId: studentId,
      prizeItemId: prizeItemId,
    );

    result.when(
      success: (_) {
        getUncollectedPrizes(isRefresh: true);
        getCollectedPrizes(isRefresh: true);

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
        emit(
          PrizesState.error(
            error: error.apiErrorModel.message ?? 'Failed to collect prize',
          ),
        );
      },
    );
  }
}
