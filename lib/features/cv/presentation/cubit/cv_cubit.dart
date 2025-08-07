import 'package:bloc/bloc.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_cv/core/utils/timing_utils.dart';
import 'package:flutter_cv/features/cv/domain/usecases/get_cv.dart';
import 'package:flutter_cv/features/cv/presentation/cubit/cv_state.dart';

class CvCubit extends Cubit<CvState> {
  final GetCv getCv;

  CvCubit(this.getCv) : super(CvInitial());

  /// Loads CV data using the GetCv use case
  Future<void> loadCv() async {
    emit(CvLoading());
    final result = await getCv().withMinDuration(const Duration(seconds: 2));
    result.fold(
      (failure) {
        FirebaseCrashlytics.instance.recordError(
          failure,
          StackTrace.current,
          reason: 'A handled failure occurred in CvCubit',
        );
        emit(CvError(failure));
      },
      (cv) => emit(CvLoaded(cv)),
    );
  }
}
