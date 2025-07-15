import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cv/features/cv/presentation/cubit/cv_cubit.dart';
import 'package:flutter_cv/features/cv/presentation/cubit/cv_state.dart';
import 'package:flutter_cv/features/cv/presentation/widgets/experience_section.dart';

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
            final cv = state.cv;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 16),
                    Text(cv.nameEn, style: Theme.of(context).textTheme.headlineMedium),
                    Text(cv.nameUa, style: Theme.of(context).textTheme.headlineSmall),
                    Text(cv.position, style: Theme.of(context).textTheme.titleLarge),
                    Text('Location: ${cv.location}'),
                    Text('Phone: ${cv.phone}'),
                    Text('Email: ${cv.email}'),
                    Text('Telegram: ${cv.telegram}'),
                    Text('LinkedIn: ${cv.linkedin}'),
                    Text('GitHub: ${cv.github}'),
                    Text('Stack Overflow: ${cv.stackoverflow}'),
                    const SizedBox(height: 32),
                    ExperienceSection(experience: cv.experience),
                    Text('General Skills:\n${cv.skillsGeneral}'),
                    Text('Flutter Skills:\n${cv.skillsFlutter}'),
                    Text('Android Skills:\n${cv.skillsAndroid}'),
                    Text('Languages:\n${cv.skillsLanguages}'),
                    Text('Additional Skills:\n${cv.skillsAdditional}'),
                    Text('Education:\n${cv.education}'),
                  ],
                ),
              ),
            );
          } else if (state is CvError) {
            return Center(child: Text('Error: ${state.message}'));
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}