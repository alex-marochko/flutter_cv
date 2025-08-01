import 'dart:convert';
import 'package:flutter_cv/core/config/app_config.dart';
import 'package:flutter_cv/features/cv/data/datasources/remote_cv_data_source.dart';
import 'package:flutter_cv/features/cv/data/enums/cv_sheet.dart';
import 'package:flutter_cv/features/cv/data/models/cv_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

class MockHttpClient extends Mock implements http.Client {}

class FakeUri extends Fake implements Uri {}

void main() {
  late RemoteCvDataSource dataSource;
  late MockHttpClient mockHttpClient;

  setUpAll(() {
    registerFallbackValue(FakeUri());
  });

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = RemoteCvDataSource(client: mockHttpClient);
  });

  group('fetchRawData', () {
    final tBasicData = {
      'columns': ['key', 'value'],
      'data': [
        ['name_en', 'Test Name'],
        ['position', 'Test Position'],
      ],
    };
    final tExperienceData = {
      'columns': [
        'year_from',
        'year_to',
        'position',
        'company',
        'reference',
        'description',
      ],
      'data': [
        [
          '2022',
          '2023',
          'Test Exp Position',
          'Test Exp Company',
          'ref.com',
          'Desc',
        ],
      ],
    };

    final tBasicUrl = Uri.parse(
      'https://sheet-proxy.marochko.workers.dev?action=read&sheetID=${AppConfig.cvSheetId}&sheetName=${CvSheet.basic.name}',
    );
    final tExperienceUrl = Uri.parse(
      'https://sheet-proxy.marochko.workers.dev?action=read&sheetID=${AppConfig.cvSheetId}&sheetName=${CvSheet.experience.name}',
    );

    test(
      'should return CvModel when the response code is 200 (success)',
      () async {
        // Arrange
        when(() => mockHttpClient.get(tBasicUrl)).thenAnswer(
          (_) async => http.Response(
            json.encode(tBasicData),
            200,
            headers: {'content-type': 'application/json; charset=utf-8'},
          ),
        );
        when(() => mockHttpClient.get(tExperienceUrl)).thenAnswer(
          (_) async => http.Response(
            json.encode(tExperienceData),
            200,
            headers: {'content-type': 'application/json; charset=utf-8'},
          ),
        );

        // Act
        final result = await dataSource.fetchRawData();

        // Assert
        expect(result, isA<CvModel>());
        expect(result.nameEn, 'Test Name');
        expect(result.experienceModels.first.company, 'Test Exp Company');
      },
    );

    test(
      'should throw an exception when the response code is not 200',
      () async {
        // Arrange
        when(
          () => mockHttpClient.get(any()),
        ).thenAnswer((_) async => http.Response('Something went wrong', 404));

        // Act
        final call = dataSource.fetchRawData;

        // Assert
        expect(() => call(), throwsA(isA<Exception>()));
      },
    );
  });
}
