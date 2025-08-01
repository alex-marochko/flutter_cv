import 'package:printing/printing.dart';
import 'package:flutter_cv/features/cv/domain/entities/cv.dart';
import 'package:flutter_cv/features/pdf/data/pdf_generator_service.dart';

Future<void> generateAndSavePdf(Cv cv) async {
  final pdfData = await PdfGeneratorService().generateCvPdf(cv);
  final filename = '${cv.nameEn} (${cv.position}) cv.pdf';
  await Printing.sharePdf(bytes: pdfData, filename: filename);
}
