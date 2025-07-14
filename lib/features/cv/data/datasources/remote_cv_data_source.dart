import 'dart:convert';
import 'package:http/http.dart' as http;

import 'cv_data_source.dart';

class RemoteCvDataSource implements CvDataSource {
  final http.Client client;

  RemoteCvDataSource({required this.client});

  static const _workBookId = '1kvP2A6xR4N135IjxDpicjzhvR7lxeXz_dUd-VYQGKEU';
  static const _sheetName = 'basic';

  @override
  Future<Map<String, dynamic>> fetchRawData() async {
    final url = Uri.parse(
      'https://sheet-proxy.marochko.workers.dev?action=read&sheetID=$_workBookId&sheetName=$_sheetName',
    );

    try {
      final response = await client.get(url);

      if (response.statusCode == 200) {
        final jsonRaw = utf8.decode(response.bodyBytes);
        final decoded = jsonDecode(jsonRaw);

        if (decoded is! Map || decoded['status'] != 'SUCCESS') {
          throw Exception('Invalid response structure');
        }

        final List data = decoded['data'];
        final Map<String, dynamic> mapped = {
          for (var row in data)
            if (row.length == 2) row[0]: row[1],
        };

        return mapped;
      } else {
        throw Exception('Failed to fetch data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to connect to Google Sheets: $e');
    }
  }
}