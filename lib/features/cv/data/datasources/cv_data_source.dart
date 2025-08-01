import 'package:flutter_cv/features/cv/data/models/cv_model.dart';

abstract class CvDataSource {
  Future<CvModel> fetchRawData();
}
