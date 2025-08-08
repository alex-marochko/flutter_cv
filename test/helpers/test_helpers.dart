import 'package:flutter/services.dart';
import 'package:flutter_cv/core/services/crash_reporting/crash_reporting_service.dart';
import 'package:mocktail/mocktail.dart';

class MockCrashReportingService extends Mock implements CrashReportingService {}

typedef Callback = void Function(MethodCall call);
