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
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: skills.entries.map((entry) => _SkillTile(category: entry.key, content: entry.value)).toList(),
        ),
      ),
    );
  }
}

class _SkillTile extends StatefulWidget {
  final SkillCategory category;
  final String content;

  const _SkillTile({required this.category, required this.content});

  @override
  State<_SkillTile> createState() => _SkillTileState();
}

class _SkillTileState extends State<_SkillTile> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: ExpansionTile(
        title: Text(widget.category.label, style: Theme.of(context).textTheme.titleMedium),
        initiallyExpanded: false,
        onExpansionChanged: (value) => setState(() => expanded = value),
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            alignment: Alignment.topLeft,
            child: Text(
              widget.content,
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}