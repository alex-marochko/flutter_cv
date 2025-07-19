import 'package:flutter_cv/core/config/app_config.dart';
import 'package:flutter_cv/core/theme/cubit/theme_cubit.dart';
import 'package:flutter_cv/features/cv/data/datasources/cv_data_source.dart';
import 'package:flutter_cv/features/cv/data/datasources/google_sheets_client.dart';
import 'package:flutter_cv/features/cv/data/datasources/remote_cv_data_source.dart';
import 'package:flutter_cv/features/cv/data/repositories/cv_repository_impl.dart';
import 'package:flutter_cv/features/cv/domain/repositories/cv_repository.dart';
import 'package:flutter_cv/features/cv/domain/usecases/get_cv.dart';
import 'package:flutter_cv/features/cv/presentation/cubit/cv_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http show Client;

final sl = GetIt.instance;

Future<void> init() async {
  // Cubit
  sl.registerFactory(() => CvCubit(sl()));

  // Theme
  sl.registerSingleton<ThemeCubit>(ThemeCubit());

  // Use case
  sl.registerLazySingleton(() => GetCv(sl()));

  // Repository
  sl.registerLazySingleton<CvRepository>(() => CvRepositoryImpl(sl()));

  // Google Sheets Client
  sl.registerLazySingleton(() => GoogleSheetsClient(sl(), sheetId: AppConfig.cvSheetId));

  // Data source
  sl.registerLazySingleton<CvDataSource>(() => RemoteCvDataSource(client: sl()));

  // External
  sl.registerLazySingleton(() => http.Client());
}