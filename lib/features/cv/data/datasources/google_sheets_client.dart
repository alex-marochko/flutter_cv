import 'dart:convert';
import 'package:http/http.dart' as http;

class GoogleSheetsClient {
  final http.Client client;
  final String sheetId;

  GoogleSheetsClient(this.client, {required this.sheetId});

  Future<List<List<String>>> fetchListSheet(String sheetName) async {
    final url = Uri.parse(
      'https://sheet-proxy.marochko.workers.dev?action=read&sheetID=$sheetId&sheetName=$sheetName',
    );

    final response = await client.get(url);
    if (response.statusCode != 200) {
      throw Exception('Failed to fetch sheet: $sheetName');
    }

    final decoded = jsonDecode(utf8.decode(response.bodyBytes));
    final raw = decoded['data'] as List;
    return raw.map((e) => List<String>.from(e)).toList();
  }

  Future<Map<String, String>> fetchKeyValueSheet(String sheetName) async {
    final rows = await fetchListSheet(sheetName);
    return {
      for (var row in rows)
        if (row.length >= 2) row[0]: row[1],
    };
  }
}