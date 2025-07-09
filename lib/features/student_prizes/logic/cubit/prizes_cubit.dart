// lib/features/student_prizes/logic/cubit/prizes_cubit.dart
import 'package:bloc/bloc.dart';
import 'package:english_club/features/student_prizes/data/models/prizes_response.dart';
import 'package:english_club/features/student_prizes/data/repos/prizes_repo.dart';
import 'package:english_club/features/student_prizes/logic/cubit/prizes_state.dart';
import 'package:flutter/material.dart'; // ضروري لـ ScrollController

class PrizesCubit extends Cubit<PrizesState<PrizesResponse>> {
  final PrizesRepo prizesRepo;

  PrizesCubit(this.prizesRepo) : super(const PrizesState.initial());

  // رقم الصفحة الحالية التي سيتم جلب البيانات منها.
  int _currentPage = 1;

  // قائمة لتخزين جميع الجوائز التي تم جلبها حتى الآن.
  final List<PrizeItem> _allPrizes = [];

  // يشير إذا ما كان هناك المزيد من البيانات لجلبها من الخادم.
  bool _hasMoreData = true;

  // يشير إذا ما كانت عملية "تحميل المزيد" قيد التنفيذ حاليًا.
  bool _isLoadingMore = false;

  // وحدة تحكم بالتمرير (ScrollController) لمراقبة موقع التمرير
  // وتحديد متى يتم جلب المزيد من البيانات.
  final ScrollController scrollController = ScrollController();

  // Getter للوصول إلى قائمة جميع الجوائز من خارج الـ Cubit.
  List<PrizeItem> get allPrizes => _allPrizes;

  // Getter لمعرفة ما إذا كان هناك المزيد من البيانات.
  bool get hasMoreData => _hasMoreData;

  // Getter لمعرفة ما إذا كانت عملية التحميل الإضافي قيد التنفيذ.
  bool get isLoadingMore => _isLoadingMore;

  /// تهيئة ScrollController وإضافة المستمع له.
  /// يجب استدعاء هذه الدالة عند تهيئة الـ Bloc (عادة في initState).
  void initScrollController() {
    scrollController.addListener(_onScroll);
  }

  /// التخلص من ScrollController عند إغلاق الشاشة لمنع تسرب الذاكرة.
  /// يجب استدعاء هذه الدالة عند التخلص من الـ Bloc (عادة في dispose).
  void disposeScrollController() {
    scrollController.dispose();
  }

  /// دالة المستمع لـ ScrollController.
  /// تتحقق ما إذا كان المستخدم قد وصل إلى نهاية القائمة،
  /// وهل يوجد المزيد من البيانات، وهل لا توجد عملية تحميل قيد التنفيذ.
  void _onScroll() {
    if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent &&
        _hasMoreData &&
        !_isLoadingMore) {
      loadMorePrizes(); // استدعاء دالة تحميل المزيد من الجوائز.
    }
  }

  /// دالة لجلب الجوائز، تستخدم للتحميل الأولي أو التحديث.
  /// [isRefresh] إذا كانت true، فإنها تعيد تعيين الصفحات وتمسح البيانات الموجودة.
  Future<void> getPrizes({bool isRefresh = false}) async {
    // إذا كان الطلب تحديثًا، نعيد تهيئة حالة ترقيم الصفحات ونمسح البيانات.
    if (isRefresh) {
      _currentPage = 1;
      _allPrizes.clear();
      _hasMoreData = true;
      _isLoadingMore = false; // تأكد من إعادة تعيين هذه العلامة أيضًا
    }

    // إذا لم يكن هناك المزيد من البيانات للتحميل وليست عملية تحديث،
    // نصدر حالة النجاح بالبيانات الموجودة ونخرج.
    if (!_hasMoreData && !isRefresh) {
      emit(
        PrizesState.success(
          PrizesResponse(
            data: PrizesData(data: _allPrizes),
            // يمكن إضافة رسالة أو معلومات أخرى إذا لزم الأمر
          ),
        ),
      );
      return;
    }

    // إذا كانت القائمة فارغة أو كان الطلب تحديثًا، نطلق حالة التحميل الكاملة.
    if (_allPrizes.isEmpty || isRefresh) {
      emit(const PrizesState.loading());
    }

    // نطلب جلب الجوائز من الـ Repository للصفحة الحالية.
    // لاحظ أننا لا نرسل `collectedStatus` هنا، حيث أن هذا الـ Cubit يتعامل مع قائمة واحدة.
    final result = await prizesRepo.getPrizes(page: _currentPage);

    // نتعامل مع نتيجة طلب الـ API (نجاح أو فشل).
    result.when(
      success: (prizesResponse) {
        // إذا كانت هناك بيانات في الاستجابة، نضيفها إلى قائمة جميع الجوائز.
        if (prizesResponse.data?.data != null) {
          _allPrizes.addAll(prizesResponse.data!.data!);
          // نتحقق إذا ما كان هناك صفحة تالية لتحديث علامة `_hasMoreData`.
          if (prizesResponse.data!.nextPageUrl == null) {
            _hasMoreData = false; // لا يوجد المزيد من البيانات.
          } else {
            _currentPage++; // ننتقل إلى الصفحة التالية للتحميل المستقبلي.
          }
        } else {
          _hasMoreData = false; // لا توجد بيانات في الاستجابة، لا يوجد المزيد.
        }
        // نصدر حالة النجاح مع جميع الجوائز المجمعة.
        emit(
          PrizesState.success(
            PrizesResponse(
              data: PrizesData(data: _allPrizes),
              message: prizesResponse.message, // حافظ على الرسالة من الـ API
            ),
          ),
        );
      },
      failure: (error) {
        // في حالة الفشل، نصدر حالة الخطأ.
        emit(
          PrizesState.error(
            error: error.apiErrorModel.message ?? 'Unknown error',
          ),
        );
      },
    );
  }

  /// دالة لجلب المزيد من الجوائز عند التمرير إلى نهاية القائمة.
  Future<void> loadMorePrizes() async {
    // نخرج إذا لم يكن هناك المزيد من البيانات أو إذا كانت عملية تحميل جارية.
    if (!_hasMoreData || _isLoadingMore) return;

    // نضع علامة `_isLoadingMore` إلى true لمنع طلبات متكررة.
    _isLoadingMore = true;

    // نصدر حالة النجاح الحالية (مع قائمة البيانات الموجودة)
    // لإظهار مؤشر التحميل الإضافي في واجهة المستخدم.
    emit(
      PrizesState.success(
        PrizesResponse(
          data: PrizesData(data: _allPrizes),
          // لا نغير الرسالة هنا، فقط نحدّث البيانات
        ),
      ),
    );

    // نطلب جلب الجوائز من الـ Repository للصفحة الحالية.
    final result = await prizesRepo.getPrizes(page: _currentPage);

    // نتعامل مع نتيجة طلب الـ API (نجاح أو فشل).
    result.when(
      success: (prizesResponse) {
        // إذا كانت هناك بيانات في الاستجابة، نضيفها إلى قائمة جميع الجوائز.
        if (prizesResponse.data?.data != null) {
          _allPrizes.addAll(prizesResponse.data!.data!);
          // نتحقق إذا ما كان هناك صفحة تالية لتحديث علامة `_hasMoreData`.
          if (prizesResponse.data!.nextPageUrl == null) {
            _hasMoreData = false; // لا يوجد المزيد من البيانات.
          } else {
            _currentPage++; // ننتقل إلى الصفحة التالية.
          }
        } else {
          _hasMoreData = false; // لا توجد بيانات، لا يوجد المزيد.
        }
        // بعد انتهاء التحميل، نعيد `_isLoadingMore` إلى false.
        _isLoadingMore = false;
        // نصدر حالة النجاح النهائية مع جميع الجوائز المجمعة.
        emit(
          PrizesState.success(
            PrizesResponse(
              data: PrizesData(data: _allPrizes),
              message: prizesResponse.message, // حافظ على الرسالة من الـ API
            ),
          ),
        );
      },
      failure: (error) {
        // في حالة الفشل، نعيد `_isLoadingMore` إلى false.
        _isLoadingMore = false;
        // نصدر حالة الخطأ.
        emit(
          PrizesState.error(
            error: error.apiErrorModel.message ?? 'Failed to load more prizes',
          ),
        );
      },
    );
  }
}
