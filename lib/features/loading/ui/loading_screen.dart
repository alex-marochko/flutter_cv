import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_cv/features/mosaic_cloud/ui/widgets/mosaic_cloud.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> with SingleTickerProviderStateMixin {
  late AnimationController _entranceController;

  static const List<String> _skills = [
    'Flutter', 'Dart', 'BLoC', 'Provider', 'GetIt', 'Mockito', 'SOLID',
    'Clean Architecture', 'Android', 'Kotlin', 'Git', 'iOS',
    'CI/CD', 'Firebase', 'REST API', 'UI/UX', 'Material Design', 'unit tests',
    'Sentry', 'Crashlytics', 'Java', 'Figma', 'sounds',
  ];

  @override
  void initState() {
    super.initState();
    _entranceController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..forward();
  }

  @override
  void dispose() {
    _entranceController.dispose();
    super.dispose();
  }

  FontWeight _getWeightForSize(double fontSize) {
    if (fontSize > 20) return FontWeight.w700;
    if (fontSize > 16) return FontWeight.w500;
    return FontWeight.w300;
  }

  @override
  Widget build(BuildContext context) {
    const basicFontSize = 24.0;
    const minFontSize = 12.0;
    final textStyle = TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: MosaicCloud(
                children: List.generate(_skills.length, (index) {
                  final skill = _skills[index];
                  final isVertical = index % 2 == 1;

                  // Entrance animation
                  final entranceAnimation = CurvedAnimation(
                    parent: _entranceController,
                    curve: Interval((index / _skills.length) * 0.5, 1.0, curve: Curves.easeOut),
                  );

                  // Font size calculation
                  final progress = index / (_skills.length - 1);
                  final nonLinearProgress = 1 - pow(1 - progress, 2);
                  final fontSize = basicFontSize - (basicFontSize - minFontSize) * nonLinearProgress;
                  final fontWeight = _getWeightForSize(fontSize);

                  final tag = Text(skill, style: textStyle.copyWith(fontSize: fontSize, fontWeight: fontWeight));
                  final rotatedTag = isVertical ? RotatedBox(quarterTurns: 3, child: tag) : tag;

                  return FadeTransition(
                    opacity: entranceAnimation,
                    child: ScaleTransition(
                      scale: entranceAnimation,
                      child: rotatedTag,
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: FractionallySizedBox(
              widthFactor: 0.25,
              child: const LinearProgressIndicator(),
            ),
          ),
        ],
      ),
    );
  }
}

