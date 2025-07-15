import 'package:flutter/material.dart';
import 'package:flutter_cv/features/cv/domain/entities/experience.dart';

class ExperienceSection extends StatelessWidget {
  final List<Experience> experience;

  const ExperienceSection({super.key, required this.experience});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Experience', style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 16),
        ...experience.map((e) => _ExperienceItem(e)),
      ],
    );
  }
}

class _ExperienceItem extends StatelessWidget {
  final Experience exp;

  const _ExperienceItem(this.exp);

  @override
  Widget build(BuildContext context) {
    final descriptionLines = exp.description.split('\n');

    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${exp.yearFrom}–${exp.yearTo} · ${exp.position} at ${exp.company}',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          if (exp.reference.trim().isNotEmpty)
            Text(
              'Reference: ${exp.reference}',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
            ),
          const SizedBox(height: 8),
          ...descriptionLines.map((line) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 2.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('• ', style: TextStyle(height: 1.4)),
                Expanded(child: Text(line.trim(), style: const TextStyle(height: 1.4))),
              ],
            ),
          )),
        ],
      ),
    );
  }
}