import 'package:flutter/material.dart';
import 'package:flutter_cv/features/loading/presentation/skills.dart';
import 'package:flutter_cv/features/loading/presentation/widgets/skill_tag.dart';
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

  @override
  void initState() {
    super.initState();
    _repeatingController = AnimationController(
      duration: _repeatingAnimationDurationPerSkill * skills.length,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: MosaicCloud(
                children: List.generate(skills.length, (index) {
                  return SkillTag(
                    skill: skills[index],
                    index: index,
                    skillsCount: skills.length,
                    entranceController: _entranceController,
                    repeatingController: _repeatingController,
                  );
                }),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: FractionallySizedBox(
              widthFactor: 0.25,
              child: RepaintBoundary(child: LinearProgressIndicator()),
            ),
          ),
        ],
      ),
    );
  }
}
