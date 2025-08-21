import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cv/core/config/app_initializer.dart';
import 'package:flutter_cv/core/di/service_locator.dart';
import 'package:flutter_cv/core/theme/app_theme.dart';
import 'package:flutter_cv/core/theme/widgets/sunrise_gradient_background.dart';
import 'package:flutter_cv/features/cv/presentation/cubit/cv_cubit.dart';
import 'package:flutter_cv/features/cv/presentation/cubit/cv_state.dart';
import 'package:flutter_cv/features/cv/presentation/pages/responsive_cv_page.dart';
import 'package:flutter_cv/features/cv/presentation/widgets/error_screen.dart';
import 'package:flutter_cv/features/loading/presentation/loading_screen.dart';

void main() async {
  await AppInitializer.initialize();
  runApp(const CvApp());
}

class CvApp extends StatelessWidget {
  const CvApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter CV',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      home: SunriseGradientBackground(
        child: BlocProvider(
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
                  _ => const LoadingScreen(key: ValueKey('loading_screen')),
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
