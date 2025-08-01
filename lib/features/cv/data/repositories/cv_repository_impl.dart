import 'package:flutter_cv/features/cv/data/datasources/cv_data_source.dart';
import 'package:flutter_cv/features/cv/domain/entities/cv.dart';
import 'package:flutter_cv/features/cv/domain/repositories/cv_repository.dart';

class CvRepositoryImpl implements CvRepository {
  final CvDataSource dataSource;

  CvRepositoryImpl(this.dataSource);

  @override
  Future<Cv> getCv() async {
    final model = await dataSource.fetchRawData();

    return model.toEntity();
  }
}
