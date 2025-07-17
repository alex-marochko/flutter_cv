import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cv/features/cv/domain/entities/cv.dart';
import 'package:flutter_cv/features/cv/presentation/cubit/cv_cubit.dart';
import 'package:flutter_cv/features/cv/presentation/cubit/cv_state.dart';
import 'package:flutter_cv/features/cv/presentation/widgets/experience_section.dart';
import 'package:flutter_cv/features/cv/presentation/widgets/contact_section.dart';
import 'package:flutter_cv/features/cv/presentation/widgets/education_section.dart';
import 'package:flutter_cv/features/cv/presentation/widgets/references_section.dart';
import 'package:flutter_cv/features/cv/presentation/widgets/skills_section.dart';

class CvWebPage extends StatefulWidget {
  const CvWebPage({super.key});

  @override
  State<CvWebPage> createState() => _CvWebPageState();
}

class _CvWebPageState extends State<CvWebPage> {
  bool isDark = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: isDark ? ThemeData.dark() : ThemeData.light(),
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () => setState(() => isDark = !isDark),
          child: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
        ),
        body: BlocBuilder<CvCubit, CvState>(
          builder: (context, state) {
            if (state is CvLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CvLoaded) {
              return _buildContent(context, state.cv);
            } else if (state is CvError) {
              return Center(child: Text('Error: ${state.message}'));
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, Cv cv) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1000),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(cv),
              ContactSection(
                email: cv.email,
                telegram: cv.telegram,
                linkedin: cv.linkedin,
                github: cv.github,
                stackoverflow: cv.stackoverflow,
              ),
              ExperienceSection(experience: cv.experience),
              SkillsSection(
                skills: {
                  'General': cv.skillsGeneral,
                  'Flutter': cv.skillsFlutter,
                  'Android': cv.skillsAndroid,
                  'Languages': cv.skillsLanguages,
                  'Additional': cv.skillsAdditional,
                },
              ),
              EducationSection(education: cv.education),
              ReferencesSection(
                references: cv.experience
                    .map((e) => e.reference.trim())
                    .where((r) => r.isNotEmpty && r != '–')
                    .toSet()
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(Cv cv) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(cv.nameEn, style: Theme.of(context).textTheme.displaySmall),
          Text(
            cv.position,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.grey[700]),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 16,
            runSpacing: 8,
            children: [
              Text(cv.location),
              Text(cv.phone),
              Text(cv.email),
              Text(cv.telegram),
            ],
          ),
        ],
      ),
    );
  }
}