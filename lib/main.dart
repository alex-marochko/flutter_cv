import 'package:flutter/material.dart';
import 'package:flutter_cv/features/cv/presentation/cubit/cv_cubit.dart';
import 'package:flutter_cv/features/cv/presentation/pages/cv_page.dart';
import 'core/di/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init(); // DI setup

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CV App',
      home: BlocProvider(
        create: (_) => sl<CvCubit>()..loadCv(),
        child: const CvPage(),
      ),
    );
  }
}