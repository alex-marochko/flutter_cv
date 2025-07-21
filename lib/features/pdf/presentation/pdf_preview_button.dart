import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cv/features/cv/presentation/cubit/cv_state.dart' show CvLoaded;
import 'package:printing/printing.dart';
import 'package:flutter_cv/features/cv/presentation/cubit/cv_cubit.dart';
import 'package:flutter_cv/features/pdf/data/pdf_generator_service.dart';

class PdfPreviewButton extends StatelessWidget {
  const PdfPreviewButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: const Icon(Icons.visibility),
      label: const Text('Preview PDF'),
      onPressed: () async {
        final state = context.read<CvCubit>().state;
        if (state is! CvLoaded) return;

        final cv = state.cv;
        final pdfData = await PdfGeneratorService().generateCvPdf(cv);

        await Printing.layoutPdf(
          onLayout: (_) async => pdfData,
          name: '${cv.nameEn} (${cv.position}) cv.pdf',
        );
      },
    );
  }
}
