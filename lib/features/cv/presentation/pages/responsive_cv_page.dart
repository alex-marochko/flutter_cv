import 'package:flutter/material.dart';
import 'package:flutter_cv/features/cv/domain/entities/cv.dart';
import 'package:flutter_cv/features/cv/presentation/pages/cv_page.dart';
import 'package:flutter_cv/features/cv/presentation/pages/cv_web_page.dart';

class ResponsiveCvPage extends StatelessWidget {
  final Cv cv;
  const ResponsiveCvPage({super.key, required this.cv});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 800) {
          return CvWebPage(cv: cv);
        } else {
          return CvPage(cv: cv);
        }
      },
    );
  }
}
