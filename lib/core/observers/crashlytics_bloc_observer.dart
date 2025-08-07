import 'package:flutter_cv/core/di/service_locator.dart';
import 'package:flutter_cv/core/services/crash_reporting/crash_reporting_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CrashlyticsBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    sl<CrashReportingService>().log('Bloc: ${bloc.runtimeType}, Event: ${event.runtimeType}');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    sl<CrashReportingService>().log('Bloc: ${bloc.runtimeType}, Transition: ${transition.event.runtimeType} -> ${transition.nextState.runtimeType}');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    sl<CrashReportingService>().recordError(
      error,
      stackTrace,
      reason: 'An error occurred in ${bloc.runtimeType}',
    );
    super.onError(bloc, error, stackTrace);
  }
}
