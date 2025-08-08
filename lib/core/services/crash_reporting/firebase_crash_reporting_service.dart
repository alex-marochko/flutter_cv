import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_cv/core/services/crash_reporting/crash_reporting_service.dart';

class FirebaseCrashReportingService implements CrashReportingService {
  final FirebaseCrashlytics _firebaseCrashlytics;

  FirebaseCrashReportingService(this._firebaseCrashlytics);

  @override
  Future<void> recordError(
    dynamic exception,
    StackTrace? stack, {
    dynamic reason,
    Iterable<Object> information = const [],
    bool? printDetails,
    bool fatal = false,
  }) {
    return _firebaseCrashlytics.recordError(
      exception,
      stack,
      reason: reason,
      information: information,
      printDetails: printDetails,
      fatal: fatal,
    );
  }

  @override
  Future<void> recordFlutterFatalError(
    FlutterErrorDetails flutterErrorDetails,
  ) {
    return _firebaseCrashlytics.recordFlutterFatalError(flutterErrorDetails);
  }

  @override
  void log(String message) {
    _firebaseCrashlytics.log(message);
  }
}
