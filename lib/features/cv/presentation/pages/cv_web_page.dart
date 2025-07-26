import 'package:flutter/material.dart';
import 'package:flutter_cv/features/cv/domain/entities/cv.dart';
import 'package:flutter_cv/features/cv/presentation/widgets/change_theme_button.dart';
import 'package:flutter_cv/features/cv/presentation/widgets/experience_section.dart';
import 'package:flutter_cv/features/cv/presentation/widgets/contact_section.dart';
import 'package:flutter_cv/features/cv/presentation/widgets/education_section.dart';
import 'package:flutter_cv/features/cv/presentation/widgets/skills_section.dart';
import 'package:flutter_cv/features/mosaic_cloud/ui/widgets/mosaic_cloud.dart';
import 'package:flutter_cv/features/pdf/presentation/widgets/pdf_export_button.dart';

class CvWebPage extends StatelessWidget {
  final Cv cv;
  const CvWebPage({super.key, required this.cv});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        actions: [PdfExportButton(), ChangeThemeButton()],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: CvWebContent(cv: cv),
    );
  }
}

class CvWebContent extends StatelessWidget {
  final Cv cv;

  const CvWebContent({super.key, required this.cv});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1000),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CvHeader(cv: cv),
              ContactSection(
                email: cv.email,
                telegram: cv.telegram,
                linkedin: cv.linkedin,
                github: cv.github,
                stackoverflow: cv.stackoverflow,
              ),
              const SizedBox(height: 16),
              ExperienceSection(experience: cv.experience),
              SkillsSection(skills: cv.skills),
              EducationSection(education: cv.education),
            ],
          ),
        ),
      ),
    );
  }
}

class CvHeader extends StatelessWidget {
  final Cv cv;

  const CvHeader({super.key, required this.cv});

  static const List<String> _backgroundSkills = [
    'Flutter', 'Dart', 'BLoC', 'SOLID', 'Android', 'Kotlin', 'Swift', 'Git'
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background mosaic on the right
        Positioned(
          top: 0,
          right: 0,
          bottom: 0,
          width: 300, // Adjust width as needed
          child: Opacity(
            opacity: 0.05,
            child: MosaicCloud(
              children: _backgroundSkills.map((skill) {
                return Hero(
                  tag: 'skill_$skill',
                  child: Text(
                    skill,
                    style: TextStyle(fontSize: 18, color: Theme.of(context).colorScheme.onSurface),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
        // Foreground content
        Padding(
          padding: const EdgeInsets.only(bottom: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(cv.nameEn, style: Theme.of(context).textTheme.displaySmall),
              Text(cv.nameUa, style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.grey[500])),
              Text(
                cv.position,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.grey[700], fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
