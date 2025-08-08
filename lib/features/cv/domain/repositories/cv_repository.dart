import 'package:dartz/dartz.dart';
import 'package:flutter_cv/core/error/failures.dart';
import 'package:flutter_cv/features/cv/domain/entities/cv.dart';

abstract class CvRepository {
  Future<Either<Failure, Cv>> getCv();
}
