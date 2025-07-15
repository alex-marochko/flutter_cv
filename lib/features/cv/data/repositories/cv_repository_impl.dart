import 'package:flutter_cv/features/cv/data/datasources/cv_data_source.dart';
import 'package:flutter_cv/features/cv/data/models/cv_model.dart';
import 'package:flutter_cv/features/cv/domain/entities/cv.dart';
import 'package:flutter_cv/features/cv/domain/repositories/cv_repository.dart';

class CvRepositoryImpl implements CvRepository {
  final CvDataSource dataSource;

  CvRepositoryImpl(this.dataSource);

  @override
  Future<Cv> getCv() async {
    // Get raw JSON from data source
    final json = await dataSource.fetchBasicData();

    // Parse it to a DTO (Data Transfer Object)
    final model = CvModel.fromJson(json);

    // Convert DTO to domain entity
    return model.toEntity();
  }
}