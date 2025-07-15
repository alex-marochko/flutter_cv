import 'package:flutter_cv/features/cv/data/datasources/cv_data_source.dart';
import 'package:flutter_cv/features/cv/data/datasources/google_sheets_client.dart';

class RemoteCvDataSource implements CvDataSource {
  final GoogleSheetsClient client;

  RemoteCvDataSource(this.client);

  @override
  Future<Map<String, dynamic>> fetchBasicData() {
    return client.fetchKeyValueSheet('basic');
  }
}