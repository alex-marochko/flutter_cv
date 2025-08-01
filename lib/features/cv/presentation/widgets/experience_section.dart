import 'package:flutter/material.dart';
import 'package:flutter_cv/features/cv/presentation/utils/link_utils.dart'
    show launchLink;
import 'package:flutter_cv/features/cv/presentation/widgets/cv_section_card.dart';
import 'package:flutter_cv/features/cv/domain/entities/experience.dart';
import 'package:flutter_linkify/flutter_linkify.dart';

class ExperienceSection extends StatelessWidget {
  final List<Experience> experience;

  const ExperienceSection({super.key, required this.experience});

  @override
  Widget build(BuildContext context) {
    return CvSectionCard(
      title: 'Experience',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: experience.map((e) => _ExperienceItem(e)).toList(),
      ),
    );
  }
}

class _ExperienceItem extends StatelessWidget {
  final Experience experience;

  const _ExperienceItem(this.experience);

  @override
  Widget build(BuildContext context) {
    final descriptionLines = experience.description.split(r'\n');

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${experience.yearFrom}–${experience.yearTo} · ${experience.position} at ${experience.company}',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          if (experience.reference.trim().isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 4),

              child: Linkify(
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
                linkStyle: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: Colors.blue[600]),
                text: 'Reference: ${experience.reference}',
                onOpen: launchLink,
              ),
            ),
          const SizedBox(height: 8),
          ...descriptionLines.map(
            (line) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 2.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('• ', style: TextStyle(height: 1.4)),
                  Expanded(
                    child: Linkify(
                      text: line.trim(),
                      style: const TextStyle(height: 1.4),
                      linkStyle: const TextStyle(height: 1.4).copyWith(
                        color: Colors.blue[600],
                        decoration: TextDecoration.none,
                      ),
                      onOpen: launchLink,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
