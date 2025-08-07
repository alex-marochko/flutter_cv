import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core_platform_interface/firebase_core_platform_interface.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

typedef Callback = void Function(MethodCall call);

void setupFirebaseCoreMocks() {
  TestWidgetsFlutterBinding.ensureInitialized();
  // Mock Firebase.initializeApp()
  setupFirebaseCoreMocksForTest();
}

Future<void> setupFirebaseCoreMocksForTest({Callback? customCallback}) async {
  final original = Firebase.delegatePackingProperty;
  TestWidgetsFlutterBinding.ensureInitialized();

  // Mock the FirebaseCore platform channel
  final channel = MethodChannel('plugins.flutter.io/firebase_core');
  channel.setMockMethodCallHandler((call) async {
    if (call.method == 'Firebase#initializeCore') {
      return [
        {
          'name': defaultFirebaseAppName,
          'options': {
            'apiKey': '123',
            'appId': '1:123:android:123',
            'messagingSenderId': '123',
            'projectId': '123',
          },
          'pluginConstants': {},
        }
      ];
    }
    if (call.method == 'Firebase#initializeApp') {
      return {
        'name': call.arguments['appName'],
        'options': call.arguments['options'],
        'pluginConstants': {},
      };
    }

    if (customCallback != null) {
      customCallback(call);
    }

    return null;
  });


  // Restore the original delegate after the test is complete
  addTearDown(() => Firebase.delegatePackingProperty = original);
}