import 'package:flutter/material.dart';
import 'package:flutter_cv/core/theme/cubit/theme_cubit.dart';
import 'package:flutter_cv/features/cv/presentation/cubit/cv_cubit.dart';
import 'package:flutter_cv/features/cv/presentation/pages/responsive_cv_page.dart';
import 'core/di/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
                theme:  themeMode == ThemeMode.light? ThemeData.light() : ThemeData.dark(),
                home: BlocProvider(
                  create: (_) => CvCubit(sl())..loadCv(),
                  child: ResponsiveCvPage(key: ValueKey(themeMode)),
                ),
              );
            }
          );
        }
      ),
    );
  }
}