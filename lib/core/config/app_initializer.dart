import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cv/core/di/service_locator.dart';
import 'package:flutter_cv/core/observers/crashlytics_bloc_observer.dart';
import 'package:flutter_cv/firebase_options.dart';

class AppInitializer {
  static Future<void> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();

    await _initializeFirebase();
    _initializeBlocObserver();
    await init(); // DI setup
  }

  static Future<void> _initializeFirebase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    FlutterError.onError = (errorDetails) {
      FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
    };

    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };
  }

  static void _initializeBlocObserver() {
    Bloc.observer = CrashlyticsBlocObserver();
  }
}
