import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cv/core/di/service_locator.dart';
import 'package:flutter_cv/core/theme/cubit/theme_cubit.dart';
import 'package:flutter_cv/features/cv/presentation/cubit/cv_cubit.dart';
import 'package:flutter_cv/features/cv/presentation/cubit/cv_state.dart';
import 'package:flutter_cv/features/cv/presentation/pages/responsive_cv_page.dart';
import 'package:flutter_cv/features/cv/presentation/widgets/error_screen.dart';
import 'package:flutter_cv/features/loading/presentation/loading_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  await init(); // DI setup

  runApp(const CvApp());
}

class CvApp extends StatelessWidget {
  const CvApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ThemeCubit(),
      child: Builder(
        builder: (context) {
          return BlocBuilder<ThemeCubit, ThemeMode>(
            builder: (context, themeMode) {
              return MaterialApp(
                title: 'Flutter CV',
                theme:
                    themeMode == ThemeMode.light
                        ? ThemeData.light()
                        : ThemeData.dark(),
                home: BlocProvider(
                  create: (_) => CvCubit(sl())..loadCv(),
                  child: BlocBuilder<CvCubit, CvState>(
                    builder: (context, state) {
                      return AnimatedSwitcher(
                        duration: const Duration(milliseconds: 500),
                        child: switch (state) {
                          CvLoaded() => ResponsiveCvPage(
                            key: const ValueKey('cv_page'),
                            cv: state.cv,
                          ),
                          CvError() => ErrorScreen(
                            key: const ValueKey('error_screen'),
                            failure: state.failure,
                            onRetry: () => context.read<CvCubit>().loadCv(),
                          ),
                          _ => const LoadingScreen(
                            key: ValueKey('loading_screen'),
                          ),
                        },
                      );
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
