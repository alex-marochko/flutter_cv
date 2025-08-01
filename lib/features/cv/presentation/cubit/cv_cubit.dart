import 'package:bloc/bloc.dart';
import 'package:flutter_cv/core/error/failures.dart';
import 'package:flutter_cv/features/cv/domain/usecases/get_cv.dart';
import 'package:flutter_cv/features/cv/presentation/cubit/cv_state.dart';

class CvCubit extends Cubit<CvState> {
  final GetCv getCv;

  CvCubit(this.getCv) : super(CvInitial());

  /// Loads CV data using the GetCv use case
  Future<void> loadCv() async {
    emit(CvLoading());

    try {
      final cv = await getCv();
      emit(CvLoaded(cv));
    } on Failure catch (e) {
      emit(CvError(e));
    }
  }
}
