import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_cv/features/mosaic_cloud/ui/widgets/mosaic_cloud.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  static const List<String> _skills = [
    'Flutter', 'Dart', 'BLoC', 'Provider', 'GetIt', 'Mockito', 'SOLID',
    'Clean Architecture', 'Android', 'Kotlin', 'Java', 'iOS', 'Swift',
    'CI/CD', 'Git', 'Firebase', 'REST API', 'UI/UX', 'Agile', 'Scrum'
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final random = Random();
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: MosaicCloud(
          children: List.generate(_skills.length, (index) {
            final skill = _skills[index];
            final isVertical = random.nextBool();

            // Staggered animation setup
            final intervalStart = (index / _skills.length) * 0.5;
            final intervalEnd = intervalStart + 0.5;
            final animation = CurvedAnimation(
              parent: _controller,
              curve: Interval(intervalStart, intervalEnd.clamp(0.0, 1.0), curve: Curves.easeOut),
            );

            final tag = Text(
              skill,
              style: const TextStyle(fontSize: 18, color: Colors.white),
            );

            final rotatedTag = isVertical ? RotatedBox(quarterTurns: 3, child: tag) : tag;

            return FadeTransition(
              opacity: animation,
              child: ScaleTransition(
                scale: animation,
                child: Hero(
                  tag: 'skill_$skill',
                  child: rotatedTag,
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
