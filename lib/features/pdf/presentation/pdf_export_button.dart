import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cv/features/cv/presentation/cubit/cv_state.dart';
import 'package:printing/printing.dart';
import 'package:flutter_cv/features/cv/presentation/cubit/cv_cubit.dart';
import 'package:flutter_cv/features/pdf/data/pdf_generator_service.dart';

class PdfExportButton extends StatelessWidget {
  const PdfExportButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: const Icon(Icons.picture_as_pdf),
      label: const Text('Export PDF'),
      onPressed: () async {
        final state = context.read<CvCubit>().state;
        if (state is! CvLoaded) return;

        final cv = state.cv;
        final pdfData = await PdfGeneratorService().generateCvPdf(cv);
        final filename = '${cv.nameEn} (${cv.position}) cv.pdf';

        await Printing.sharePdf(bytes: pdfData, filename: filename);
      },
    );
  }
}