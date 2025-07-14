import 'package:flutter_cv/features/cv/domain/entities/cv.dart';
import 'package:flutter_cv/features/cv/domain/repositories/cv_repository.dart';

class GetCv {
  final CvRepository repository;

  GetCv(this.repository);

  /// Retrieves the CV entity from the repository
  Future<Cv> call() {
    return repository.getCv();
  }
}