import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cv/features/cv/domain/entities/cv.dart';
import 'package:flutter_cv/features/cv/presentation/cubit/cv_cubit.dart';
import 'package:flutter_cv/features/cv/presentation/cubit/cv_state.dart';
import 'package:flutter_cv/features/cv/presentation/widgets/contact_section.dart';
import 'package:flutter_cv/features/cv/presentation/widgets/education_section.dart';
import 'package:flutter_cv/features/cv/presentation/widgets/experience_section.dart';
import 'package:flutter_cv/features/cv/presentation/widgets/references_section.dart';
import 'package:flutter_cv/features/cv/presentation/widgets/skills_section.dart';

class CvPage extends StatelessWidget {
  const CvPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My CV')),
      body: BlocBuilder<CvCubit, CvState>(
        builder: (context, state) {
          if (state is CvLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CvLoaded) {
            return _buildContent(state.cv);
          } else if (state is CvError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildContent(Cv cv) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(cv.nameEn, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        Text(cv.position, style: const TextStyle(fontSize: 18, color: Colors.grey)),
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
          skills: {
            'General': cv.skillsGeneral,
            'Flutter': cv.skillsFlutter,
            'Android': cv.skillsAndroid,
            'Languages': cv.skillsLanguages,
            'Additional': cv.skillsAdditional,
          },
        ),
        const SizedBox(height: 24),
        EducationSection(education: cv.education),
        const SizedBox(height: 24),
        ReferencesSection(
          references: cv.experience
              .map((e) => e.reference.trim())
              .where((r) => r.isNotEmpty && r != '–')
              .toSet()
              .toList(),
        ),
      ],
    );
  }
}