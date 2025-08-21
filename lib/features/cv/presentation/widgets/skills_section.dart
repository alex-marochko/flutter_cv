import 'package:flutter/material.dart';
import 'package:flutter_cv/features/cv/domain/enums/skill_category.dart';
import 'package:flutter_cv/features/cv/presentation/widgets/cv_section_card.dart';

class SkillsSection extends StatelessWidget {
  final Map<SkillCategory, String> skills;

  const SkillsSection({super.key, required this.skills});

  @override
  Widget build(BuildContext context) {
    return CvSectionCard(
      title: 'Skills & Techs Used',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: skills.entries
            .map(
              (entry) =>
                  _SkillTile(category: entry.key, content: entry.value),
            )
            .toList(),
      ),
    );
  }
}

class _SkillTile extends StatelessWidget {
  final SkillCategory category;
  final String content;

  const _SkillTile({required this.category, required this.content});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            category.label,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 4),
          Text(
            content,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
