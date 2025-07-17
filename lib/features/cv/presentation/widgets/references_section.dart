import 'package:flutter/material.dart';
import 'package:flutter_cv/features/cv/presentation/widgets/cv_section_card.dart';

class ReferencesSection extends StatelessWidget {
  final List<String> references;

  const ReferencesSection({super.key, required this.references});

  @override
  Widget build(BuildContext context) {
    if (references.isEmpty) return const SizedBox.shrink();

    return CvSectionCard(
      title: 'References',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: references.map(
              (ref) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Text('• $ref', style: Theme.of(context).textTheme.bodyMedium),
          ),
        ).toList(),
      ),
    );
  }
}