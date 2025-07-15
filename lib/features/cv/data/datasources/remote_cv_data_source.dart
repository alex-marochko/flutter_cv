import 'package:flutter_cv/core/config/app_config.dart';
import 'package:flutter_cv/features/cv/data/datasources/cv_data_source.dart';
import 'package:flutter_cv/features/cv/data/enums/cv_sheet.dart';
import 'package:flutter_cv/features/cv/data/models/experience_model.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter_cv/features/cv/data/models/cv_model.dart';

class RemoteCvDataSource implements CvDataSource {
  final http.Client client;

  RemoteCvDataSource({required this.client});

  static const _sheetId = AppConfig.cvSheetId;

  Uri _buildUrl(CvSheet sheet) {
    return Uri.parse(
      'https://sheet-proxy.marochko.workers.dev?action=read&sheetID=$_sheetId&sheetName=${sheet.name}',
    );
  }

  @override
  Future<CvModel> fetchRawData() async {
    final basicUrl = _buildUrl(CvSheet.basic);
    final experienceUrl = _buildUrl(CvSheet.experience);

    final responses = await Future.wait([client.get(basicUrl), client.get(experienceUrl)]);
    final basicResponse = responses[0];
    final experienceResponse = responses[1];

    if (basicResponse.statusCode != 200 || experienceResponse.statusCode != 200) {
      throw Exception('Failed to load data from Google Sheets');
    }

    // Parse basic key-value map
    final basicJson = jsonDecode(utf8.decode(basicResponse.bodyBytes));
    final Map<String, dynamic> basicMap = {
      for (var row in basicJson['data']) row[0]: row[1]
    };

    // Parse experience list
    final experienceJson = jsonDecode(utf8.decode(experienceResponse.bodyBytes));
    final List<dynamic> rows = experienceJson['data'];

    final headers = List<String>.from(experienceJson['columns']);

    // Expected set of headers
    const expectedHeaders = {
      'year_from',
      'year_to',
      'position',
      'company',
      'reference',
      'description',
    };

    final headerSet = headers.toSet();
    final missing = expectedHeaders.difference(headerSet);

    if (missing.isNotEmpty) {
      throw Exception('Missing required columns in experience sheet: $missing');
    }

    final List<ExperienceModel> experience = rows.map((row) {
      final Map<String, dynamic> rowMap = {
        for (int i = 0; i < headers.length; i++) headers[i]: row[i],
      };
      return ExperienceModel.fromJson(rowMap);
    }).toList();

    return CvModel.fromJson(basicMap, experience);
  }
}