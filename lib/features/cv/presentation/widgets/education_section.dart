import 'package:flutter/material.dart';
import 'package:flutter_cv/features/cv/presentation/widgets/cv_section_card.dart';

class EducationSection extends StatelessWidget {
  final String education;

  const EducationSection({super.key, required this.education});

  @override
  Widget build(BuildContext context) {
    return CvSectionCard(
      title: 'Education',
      child: Text(education, style: Theme.of(context).textTheme.bodyMedium),
    );
  }
}
