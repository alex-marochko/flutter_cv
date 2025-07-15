import 'cv_data_source.dart';

class FakeCvDataSource implements CvDataSource {
  @override
  Future<Map<String, dynamic>> fetchBasicData() async {
    // Delay to imitate real source
    await Future.delayed(Duration(milliseconds: 300));

    return {
      'name_en': 'Alex Marochko',
      'name_ua': 'Олександр Марочко',
      'position': 'Flutter Developer',
      'location': 'Kyiv, Ukraine',
      'phone': '+38 050 888-88-88',
      'email': 'maro@gmail.com',
    };
  }
}