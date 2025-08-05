import 'package:flutter/material.dart';
import 'package:flutter_cv/features/cv/domain/entities/cv.dart';
import 'package:flutter_cv/features/cv/presentation/widgets/change_theme_button.dart';
import 'package:flutter_cv/features/cv/presentation/widgets/contact_section.dart';
import 'package:flutter_cv/features/cv/presentation/widgets/cv_footer.dart';
import 'package:flutter_cv/features/cv/presentation/widgets/education_section.dart';
import 'package:flutter_cv/features/cv/presentation/widgets/experience_section.dart';
import 'package:flutter_cv/features/cv/presentation/widgets/skills_section.dart';
import 'package:flutter_cv/features/pdf/presentation/widgets/pdf_export_button.dart';
import 'package:mosaic_cloud/mosaic_cloud.dart';

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

  static const _tags = [
    'StatelessWidget',
    'StatefulWidget',
    'setState(() {})',
    'Navigator.push',
    'MaterialApp',
    'CupertinoApp',
    'FutureBuilder',
    'StreamBuilder',
    'Scaffold',
    'AppBar',
    'TextButton',
    'ElevatedButton',
    'TextField',
    'FormField',
    'ListView.builder',
    'GridView.count',
    'MediaQuery.of',
    'Theme.of',
    'context.read',
    'context.watch',
    'context.select',
    'BlocProvider',
    'BlocBuilder',
    'BlocConsumer',
    'MultiProvider',
    'ChangeNotifierProvider',
    'AnimatedBuilder',
    'TweenAnimationBuilder',
    'SingleTickerProviderStateMixin',
    'AnimationController',
    'flutter_test',
    'testWidgets',
    'expect(find.text',
    'mockito.verify',
    'StreamController',
    'late final',
    'const factory',
    'required this.',
    'super.key',
    'super.initState()',
    'dispose()',
    'build(BuildContext context)',
    'runApp(MyApp())',
    'main() => runApp',
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        LayoutBuilder(
          builder: (_, constraints) {
            final hide = constraints.maxHeight < 1024;
            return AnimatedOpacity(
              opacity: hide ? 0 : 1,
              duration: const Duration(milliseconds: 300),
              child: MosaicCloud(
                spacing: 20,
                children:
                    _tags
                        .map(
                          (s) => Text(
                            s,
                            style: TextStyle(
                              color: Colors.blue.withAlpha(30),
                              fontWeight: FontWeight.w900,
                              fontSize: 24,
                            ),
                          ),
                        )
                        .toList(),
              ),
            );
          },
        ),
        SingleChildScrollView(
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
                  const SizedBox(height: 32),
                  CvFooter(text: cv.copyright),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class CvHeader extends StatelessWidget {
  final Cv cv;

  const CvHeader({super.key, required this.cv});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(cv.nameEn, style: Theme.of(context).textTheme.displaySmall),
          Text(
            cv.nameUa,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(color: Colors.grey[500]),
          ),
          Text(
            cv.position,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: Colors.grey[700],
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
