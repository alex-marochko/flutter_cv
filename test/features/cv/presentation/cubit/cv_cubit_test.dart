import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_cv/core/error/failures.dart';
import 'package:flutter_cv/features/cv/domain/entities/cv.dart';
import 'package:flutter_cv/features/cv/domain/usecases/get_cv.dart';
import 'package:flutter_cv/features/cv/presentation/cubit/cv_cubit.dart';
import 'package:flutter_cv/features/cv/presentation/cubit/cv_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetCv extends Mock implements GetCv {}

class MockCv extends Mock implements Cv {}

void main() {
  late CvCubit cvCubit;
  late MockGetCv mockGetCv;
  late MockCv mockCv;

  setUp(() {
    mockGetCv = MockGetCv();
    cvCubit = CvCubit(mockGetCv);
    mockCv = MockCv();
  });

  tearDown(() {
    cvCubit.close();
  });

  test('initial state is CvInitial', () {
    expect(cvCubit.state, equals(CvInitial()));
  });

  group('loadCv', () {
    const tFailure = GeneralFailure(message: 'Something went wrong');

    blocTest<CvCubit, CvState>(
      'should emit [CvLoading, CvLoaded] when getCv is successful',
      build: () {
        when(() => mockGetCv()).thenAnswer((_) async => mockCv);
        return cvCubit;
      },
      act: (cubit) => cubit.loadCv(),
      expect: () => <CvState>[CvLoading(), CvLoaded(mockCv)],
    );

    blocTest<CvCubit, CvState>(
      'should emit [CvLoading, CvError] and throw failure when getCv fails',
      build: () {
        when(() => mockGetCv()).thenThrow(tFailure);
        return cvCubit;
      },
      act: (cubit) => cubit.loadCv(),
      expect: () => <CvState>[CvLoading(), const CvError(tFailure)],
      errors: () => [tFailure],
    );
  });
}
