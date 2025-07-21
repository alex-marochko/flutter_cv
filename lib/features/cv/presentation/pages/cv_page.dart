import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cv/core/theme/cubit/theme_cubit.dart';
import 'package:flutter_cv/features/cv/domain/entities/cv.dart';
import 'package:flutter_cv/features/cv/presentation/cubit/cv_cubit.dart';
import 'package:flutter_cv/features/cv/presentation/cubit/cv_state.dart';
import 'package:flutter_cv/features/cv/presentation/widgets/contact_section.dart';
import 'package:flutter_cv/features/cv/presentation/widgets/education_section.dart';
import 'package:flutter_cv/features/cv/presentation/widgets/experience_section.dart';
import 'package:flutter_cv/features/cv/presentation/widgets/skills_section.dart';
import 'package:flutter_cv/features/pdf/presentation/pdf_export_button.dart';
import 'package:flutter_cv/features/pdf/presentation/pdf_preview_button.dart';

class CvPage extends StatelessWidget {
  const CvPage({super.key});

  @override
  Widget build(BuildContext context) {

    final themeCubit = context.read<ThemeCubit>();

    return BlocBuilder<CvCubit, CvState>(
      builder: (context, state) {
        if (state is CvLoading) {
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (state is CvLoaded) {
          final cv = state.cv;
          return Scaffold(
            appBar: AppBar(title: Text(cv.nameEn)),
            floatingActionButton: Column(
              children: [
                PdfPreviewButton(),
                SizedBox(height: 16),
                PdfExportButton(),
                SizedBox(height: 16),
                FloatingActionButton(
                  key: ValueKey(themeCubit.state),
                  onPressed: () => themeCubit.toggleTheme(),
                  child: Icon(themeCubit.state == ThemeMode.dark? Icons.light_mode : Icons.dark_mode),
                ),
              ],
            ),
            body: CvContent(cv: cv),
          );
        } else if (state is CvError) {
          return Scaffold(
            body: Center(child: Text('Error: ${state.message}')),
          );
        }
        return const SizedBox.shrink();
      },
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