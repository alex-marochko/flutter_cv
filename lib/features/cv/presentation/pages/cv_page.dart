import 'package:flutter/material.dart';
import 'package:flutter_cv/features/cv/domain/entities/cv.dart';
import 'package:flutter_cv/features/cv/presentation/widgets/change_theme_button.dart';
import 'package:flutter_cv/features/cv/presentation/widgets/contact_section.dart';
import 'package:flutter_cv/features/cv/presentation/widgets/education_section.dart';
import 'package:flutter_cv/features/cv/presentation/widgets/experience_section.dart';
import 'package:flutter_cv/features/cv/presentation/widgets/skills_section.dart';
import 'package:flutter_cv/features/pdf/presentation/widgets/pdf_export_button.dart';

class CvPage extends StatelessWidget {
  final Cv cv;
  const CvPage({super.key, required this.cv});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(cv.nameEn),
        actions: [PdfExportButton(), ChangeThemeButton()],
      ),
      body: CvContent(cv: cv),
    );
  }
}

class CvContent extends StatelessWidget {
  final Cv cv;

  const CvContent({super.key, required this.cv});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(cv.nameUa, style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.grey[500])),
        Text(
          cv.position,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.grey[700], fontWeight: FontWeight.w400),
        ),
        const SizedBox(height: 16),
        ContactSection(
          email: cv.email,
          telegram: cv.telegram,
          linkedin: cv.linkedin,
          github: cv.github,
          stackoverflow: cv.stackoverflow,
        ),
        const SizedBox(height: 24),
        ExperienceSection(experience: cv.experience),
        const SizedBox(height: 24),
        SkillsSection(
          skills: cv.skills,
        ),
        const SizedBox(height: 24),
        EducationSection(education: cv.education),
      ],
    );
  }
}