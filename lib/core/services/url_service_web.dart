import 'package:web/web.dart' as web;
import 'package:flutter_cv/core/services/url_service.dart';

class UrlServiceImpl implements UrlService {
  @override
  String getUrl() => web.window.location.href;
}
