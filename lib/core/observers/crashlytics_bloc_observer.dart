import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CrashlyticsBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    FirebaseCrashlytics.instance.log('Bloc: ${bloc.runtimeType}, Event: ${event.runtimeType}');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    FirebaseCrashlytics.instance.log('Bloc: ${bloc.runtimeType}, Transition: ${transition.event.runtimeType} -> ${transition.nextState.runtimeType}');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    FirebaseCrashlytics.instance.recordError(
      error,
      stackTrace,
      reason: 'An error occurred in ${bloc.runtimeType}',
    );
    super.onError(bloc, error, stackTrace);
  }
}
