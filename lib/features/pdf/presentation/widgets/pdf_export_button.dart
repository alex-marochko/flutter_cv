import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cv/core/di/service_locator.dart';
import 'package:flutter_cv/core/services/analytics_service.dart';
import 'package:flutter_cv/core/services/crash_reporting/crash_reporting_service.dart';
import 'package:flutter_cv/features/cv/presentation/cubit/cv_cubit.dart';
import 'package:flutter_cv/features/cv/presentation/cubit/cv_state.dart';
import 'package:flutter_cv/features/pdf/data/pdf_generator_service.dart';
import 'package:printing/printing.dart';

class PdfExportButton extends StatelessWidget {
  const PdfExportButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
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
            icon: const Icon(Icons.download, color: Colors.white),
            label: const Text('PDF', style: TextStyle(color: Colors.white)),
            onPressed:
                (state is! CvLoaded)
                    ? null
                    : () async {
                      sl<AnalyticsService>().logEvent('download_pdf');
                      final cv = state.cv;
                      final result = await PdfGeneratorService().generateCvPdf(
                        cv,
                      );

                      result.fold(
                        (failure) {
                          sl<CrashReportingService>().recordError(
                            failure,
                            StackTrace.current,
                            reason:
                                'A handled failure occurred in PdfExportButton',
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(failure.message)),
                          );
                        },
                        (pdfData) async {
                          final filename =
                              'CV ${cv.nameEn} - ${cv.position}.pdf';
                          await Printing.sharePdf(
                            bytes: pdfData,
                            filename: filename,
                          );
                        },
                      );
                    },
          );
        },
      ),
    );
  }
}
