import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_cv/features/mosaic_cloud/ui/widgets/mosaic_cloud.dart';

// This builder is used to ensure the text style is consistent during the Hero flight.
Widget _flightShuttleBuilder(
  BuildContext flightContext,
  Animation<double> animation,
  HeroFlightDirection flightDirection,
  BuildContext fromHeroContext,
  BuildContext toHeroContext,
) {
  return DefaultTextStyle(
    style: DefaultTextStyle.of(toHeroContext).style,
    child: toHeroContext.widget,
  );
}

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
    final textStyle = TextStyle(fontSize: 18, color: Theme.of(context).textTheme.bodyLarge?.color);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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

            final tag = Text(skill, style: textStyle);
            final rotatedTag = isVertical ? RotatedBox(quarterTurns: 3, child: tag) : tag;

            return FadeTransition(
              opacity: animation,
              child: ScaleTransition(
                scale: animation,
                child: rotatedTag,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
