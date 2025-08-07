import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_cv/core/services/crash_reporting/crash_reporting_service.dart';
import 'package:flutter_cv/core/di/service_locator.dart';
import 'package:flutter_cv/core/error/failures.dart';
import 'package:flutter_cv/features/cv/domain/entities/cv.dart';
import 'package:flutter_cv/features/cv/domain/usecases/get_cv.dart';
import 'package:flutter_cv/features/cv/presentation/cubit/cv_cubit.dart';
import 'package:flutter_cv/features/cv/presentation/cubit/cv_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/test_helpers.dart';

class MockGetCv extends Mock implements GetCv {}

class MockCv extends Mock implements Cv {}

void main() {
  late CvCubit cvCubit;
  late MockGetCv mockGetCv;
  late MockCv mockCv;
  late MockCrashReportingService mockCrashReportingService;

  setUp(() {
    mockGetCv = MockGetCv();
    mockCrashReportingService = MockCrashReportingService();
    sl.registerLazySingleton<CrashReportingService>(() => mockCrashReportingService);
    cvCubit = CvCubit(mockGetCv);
    mockCv = MockCv();
  });

  tearDown(() {
    cvCubit.close();
    sl.reset();
  });

  test('initial state is CvInitial', () {
    expect(cvCubit.state, equals(CvInitial()));
  });

  group('loadCv', () {
    const tFailure = GeneralFailure(message: 'Something went wrong');

    blocTest<CvCubit, CvState>(
      'should emit [CvLoading, CvLoaded] when getCv is successful',
      build: () {
        when(() => mockGetCv()).thenAnswer((_) async => Right(mockCv));
        return cvCubit;
      },
      act: (cubit) => cubit.loadCv(),
      expect: () => <CvState>[CvLoading(), CvLoaded(mockCv)],
    );

    blocTest<CvCubit, CvState>(
      'should emit [CvLoading, CvError] when getCv fails',
      build: () {
        when(() => mockGetCv()).thenAnswer((_) async => const Left(tFailure));
        when(() => mockCrashReportingService.recordError(any(), any(), reason: any(named: 'reason'))).thenAnswer((_) async {});
        return cvCubit;
      },
      act: (cubit) => cubit.loadCv(),
      expect: () => <CvState>[CvLoading(), const CvError(tFailure)],
    );
  });
}
