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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<CvCubit, CvState>(
        builder: (_, state) {
          return ElevatedButton.icon(
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
                if (states.contains(WidgetState.disabled)) {
                  return Colors.grey;
                }
                return Colors.green;
              }),
            ),
            icon: const Icon(Icons.picture_as_pdf, color: Colors.white),
            label: const Text('Download', style: TextStyle(color: Colors.white),),
            onPressed: (state is! CvLoaded)? null : () async {
              final cv = state.cv;
              final pdfData = await PdfGeneratorService().generateCvPdf(cv);
              final filename = 'CV ${cv.nameEn} - ${cv.position}.pdf';

              await Printing.sharePdf(bytes: pdfData, filename: filename);
            },
          );
        }
      ),
    );
  }
}