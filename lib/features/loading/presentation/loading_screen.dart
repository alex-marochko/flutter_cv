import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mosaic_cloud/mosaic_cloud.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen>
    with TickerProviderStateMixin {
  late AnimationController _entranceController;
  late AnimationController _repeatingController;

  static const _repeatingAnimationDurationPerSkill = Duration(
    milliseconds: 700,
  );

  static const List<String> _skills = [
    'Flutter',
    'Dart',
    'BLoC',
    'Provider',
    'GetIt',
    'Mockito',
    'SOLID',
    'Clean Architecture',
    'Android',
    'Kotlin',
    'Git',
    'iOS',
    'CI/CD',
    'Firebase',
    'REST API',
    'UI/UX',
    'Material Design',
    'unit tests',
    'Sentry',
    'Crashlytics',
    'Java',
    'Figma',
    'sounds',
  ];

  @override
  void initState() {
    super.initState();
    _repeatingController = AnimationController(
      duration: _repeatingAnimationDurationPerSkill * _skills.length,
      vsync: this,
    );

    _entranceController =
        AnimationController(duration: const Duration(seconds: 2), vsync: this)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _repeatingController.repeat();
            }
          })
          ..forward();
  }

  @override
  void dispose() {
    _entranceController.dispose();
    _repeatingController.dispose();
    super.dispose();
  }

  FontWeight _getWeightForSize(double fontSize) {
    if (fontSize > 20) return FontWeight.w700;
    if (fontSize > 16) return FontWeight.w500;
    return FontWeight.w300;
  }

  @override
  Widget build(BuildContext context) {
    const basicFontSize = 32.0;
    const minFontSize = 12.0;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: MosaicCloud(
                children:
                    List.generate(_skills.length, (index) {
                      final skill = _skills[index];
                      final isVertical = index % 2 == 1;

                      // Entrance animation
                      final entranceAnimation = CurvedAnimation(
                        parent: _entranceController,
                        curve: Interval(
                          (index / _skills.length) * 0.5,
                          1.0,
                          curve: Curves.linear,
                        ),
                      );

                      // Font size calculation
                      final progress = index / (_skills.length - 1);
                      final nonLinearProgress = 1 - pow(1 - progress, 2);
                      final fontSize =
                          basicFontSize -
                          (basicFontSize - minFontSize) * nonLinearProgress;
                      final fontWeight = _getWeightForSize(fontSize);

                      final indexIntervalStart =
                          (_skills.length - index < 4)
                              ? index - (_skills.length - index)
                              : index;
                      final indexIntervalEnd = min(
                        indexIntervalStart + 4,
                        _skills.length,
                      );

                      // Repeating animation
                      final repeatingAnimation = CurvedAnimation(
                        parent: _repeatingController,
                        curve: Interval(
                          indexIntervalStart / _skills.length,
                          indexIntervalEnd / _skills.length,
                          curve: Curves.decelerate,
                        ),
                      );

                      final forwardAndBackTween = TweenSequence<double>([
                        TweenSequenceItem<double>(
                          tween: Tween<double>(begin: 0.0, end: 1.0),
                          weight: 0.5,
                        ),
                        TweenSequenceItem<double>(
                          tween: ConstantTween<double>(1.0),
                          weight: 1.0,
                        ),
                        TweenSequenceItem<double>(
                          tween: Tween<double>(begin: 1.0, end: 0.0),
                          weight: 2.0,
                        ),
                      ]);

                      final styleTween = TextStyleTween(
                        begin: TextStyle(
                          fontSize: fontSize,
                          color: Colors.blue,
                          fontWeight: fontWeight,
                        ),
                        end: TextStyle(
                          fontSize: fontSize,
                          color: Colors.yellow,
                          fontWeight: fontWeight,
                          shadows: [
                            Shadow(
                              color: Colors.yellow,
                              blurRadius: fontSize / 2,
                            ),
                          ],
                        ),
                      );

                      final tag = DefaultTextStyleTransition(
                        style: styleTween.animate(
                          forwardAndBackTween.animate(repeatingAnimation),
                        ),
                        child: Text(skill),
                      );
                      final rotatedTag =
                          isVertical
                              ? RotatedBox(quarterTurns: 3, child: tag)
                              : tag;

                      return FadeTransition(
                        opacity: entranceAnimation,
                        child: rotatedTag,
                      );
                    }).toList(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: FractionallySizedBox(
              widthFactor: 0.25,
              child: RepaintBoundary(child: const LinearProgressIndicator()),
            ),
          ),
        ],
      ),
    );
  }
}
