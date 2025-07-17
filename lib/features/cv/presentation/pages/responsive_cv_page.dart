import 'package:flutter/material.dart';
import 'package:flutter_cv/features/cv/presentation/pages/cv_page.dart';
import 'package:flutter_cv/features/cv/presentation/pages/cv_web_page.dart';

class ResponsiveCvPage extends StatelessWidget {
  const ResponsiveCvPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 800) {
          return const CvWebPage();
        } else {
          return const CvPage();
        }
      },
    );
  }
}