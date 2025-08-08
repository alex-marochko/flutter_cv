import 'package:dartz/dartz.dart';
import 'package:flutter_cv/core/error/exceptions.dart';
import 'package:flutter_cv/core/error/failures.dart';
import 'package:flutter_cv/features/cv/data/datasources/cv_data_source.dart';
import 'package:flutter_cv/features/cv/domain/entities/cv.dart';
import 'package:flutter_cv/features/cv/domain/repositories/cv_repository.dart';

class CvRepositoryImpl implements CvRepository {
  final CvDataSource dataSource;

  CvRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, Cv>> getCv() async {
    try {
      final model = await dataSource.fetchRawData();
      return Right(model.toEntity());
    } on ServerException {
      return const Left(
        ServerFailure(message: 'Failed to load data from server'),
      );
    } catch (e) {
      return Left(GeneralFailure(message: e.toString()));
    }
  }
}
