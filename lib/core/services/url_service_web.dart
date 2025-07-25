import 'dart:html' as html;
import 'package:flutter_cv/core/services/url_service.dart';

class UrlServiceImpl implements UrlService {
  @override
  String getUrl() => html.window.location.href;
}
