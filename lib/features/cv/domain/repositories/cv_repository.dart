import 'package:flutter_cv/features/cv/domain/entities/cv.dart';

abstract class CvRepository {
  Future<Cv> getCv();
}
