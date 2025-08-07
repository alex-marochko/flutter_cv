import 'package:flutter/foundation.dart';

abstract class CrashReportingService {
  Future<void> recordError(
    dynamic exception,
    StackTrace? stack, {
    dynamic reason,
    Iterable<Object> information = const [],
    bool? printDetails,
    bool fatal = false,
  });

  Future<void> recordFlutterFatalError(FlutterErrorDetails flutterErrorDetails);

  void log(String message);
}
