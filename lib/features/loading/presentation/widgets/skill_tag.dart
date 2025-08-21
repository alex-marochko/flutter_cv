import 'dart:math';

import 'package:flutter/material.dart';

class SkillTag extends StatelessWidget {
  const SkillTag({
    super.key,
    required this.skill,
    required this.index,
    required this.skillsCount,
    required this.entranceController,
    required this.repeatingController,
  });

  final String skill;
  final int index;
  final int skillsCount;
  final AnimationController entranceController;
  final AnimationController repeatingController;

  static const double basicFontSize = 32.0;
  static const double minFontSize = 12.0;

  static const double _mediumFontSize = 20.0;
  static const double _smallFontSize = 16.0;

  FontWeight _getWeightForSize(double fontSize) {
    if (fontSize > _mediumFontSize) return FontWeight.w700;
    if (fontSize > _smallFontSize) return FontWeight.w500;
    return FontWeight.w300;
  }

  @override
  Widget build(BuildContext context) {
    const quarterTurns = 3;
    const animationIntervalSize = 4;
    final isVertical = index % 2 == 1;

    // Entrance animation
    final entranceAnimation = CurvedAnimation(
      parent: entranceController,
      curve: Interval((index / skillsCount) * 0.5, 1.0, curve: Curves.linear),
    );

    // Font size calculation
    final progress = index / (skillsCount - 1);
    final nonLinearProgress = 1 - pow(1 - progress, 2);
    final fontSize =
        basicFontSize - (basicFontSize - minFontSize) * nonLinearProgress;
    final fontWeight = _getWeightForSize(fontSize);

    final indexIntervalStart =
        (skillsCount - index < animationIntervalSize)
            ? index - (skillsCount - index)
            : index;
    final indexIntervalEnd = min(
      indexIntervalStart + animationIntervalSize,
      skillsCount,
    );

    // Repeating animation
    final repeatingAnimation = CurvedAnimation(
      parent: repeatingController,
      curve: Interval(
        indexIntervalStart / skillsCount,
        indexIntervalEnd / skillsCount,
        curve: Curves.decelerate,
      ),
    );

    const forwardAndBackTweenForwardWeight = 0.5;
    const forwardAndBackTweenHoldWeight = 1.0;
    const forwardAndBackTweenBackwardWeight = 2.0;

    final forwardAndBackTween = TweenSequence<double>([
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 0.0, end: 1.0),
        weight: forwardAndBackTweenForwardWeight,
      ),
      TweenSequenceItem<double>(
        tween: ConstantTween<double>(1.0),
        weight: forwardAndBackTweenHoldWeight,
      ),
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 1.0, end: 0.0),
        weight: forwardAndBackTweenBackwardWeight,
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
        shadows: [Shadow(color: Colors.yellow, blurRadius: fontSize / 2)],
      ),
    );

    final tag = DefaultTextStyleTransition(
      style: styleTween.animate(
        forwardAndBackTween.animate(repeatingAnimation),
      ),
      child: Text(skill),
    );
    final rotatedTag =
        isVertical ? RotatedBox(quarterTurns: quarterTurns, child: tag) : tag;

    return FadeTransition(opacity: entranceAnimation, child: rotatedTag);
  }
}
