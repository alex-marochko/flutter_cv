import 'package:bloc/bloc.dart';
import 'package:flutter_cv/core/di/service_locator.dart';
import 'package:flutter_cv/core/services/crash_reporting/crash_reporting_service.dart';
import 'package:flutter_cv/core/utils/timing_utils.dart';
import 'package:flutter_cv/features/cv/domain/usecases/get_cv.dart';
import 'package:flutter_cv/features/cv/presentation/cubit/cv_state.dart';

class CvCubit extends Cubit<CvState> {
  final GetCv getCv;

  CvCubit(this.getCv) : super(CvInitial());

  /// Loads CV data using the GetCv use case
  Future<void> loadCv() async {
    emit(CvLoading());
    final result = await getCv().withMinDuration(const Duration(seconds: 4));
    result.fold((failure) {
      sl<CrashReportingService>().recordError(
        failure,
        StackTrace.current,
        reason: 'A handled failure occurred in CvCubit',
      );
      emit(CvError(failure));
    }, (cv) => emit(CvLoaded(cv)));
  }
}
