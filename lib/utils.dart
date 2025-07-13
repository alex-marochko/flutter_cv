import 'package:http/http.dart' as http;
import 'dart:convert';

String basicSheetName = r'basic';
String experienceSheetName = r'experience';
String sheetID = r'1kvP2A6xR4N135IjxDpicjzhvR7lxeXz_dUd-VYQGKEU';

Future<Map<String, dynamic>> getSheetsData({required String action}) async {
  final url = Uri.parse(
    'https://sheet-proxy.marochko.workers.dev?action=$action&sheetID=$sheetID&sheetName=$experienceSheetName',
  );

  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final decoded = jsonDecode(utf8.decode(response.bodyBytes));
      print('response: $decoded');
      return decoded;
    } else {
      print('Error: ${response.statusCode}');
    }
  } catch (e) {
    print('FAILED: $e');
  }

  return {};
}