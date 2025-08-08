import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/services.dart';
import 'package:flutter_cv/core/error/failures.dart';
import 'package:flutter_cv/core/services/url_service_provider.dart';
import 'package:flutter_cv/features/cv/domain/entities/cv.dart';
import 'package:flutter_cv/features/pdf/presentation/widgets/pdf_widgets.dart';
import 'package:pdf/pdf.dart' show PdfColor;
import 'package:pdf/widgets.dart' as pw;

enum CategoryTitle { experience, skills, education }

class PdfGeneratorService {
  Future<Either<Failure, Uint8List>> generateCvPdf(Cv cv) async {
    try {
      final fontData = await rootBundle.load(
        "assets/fonts/Manrope-Regular.ttf",
      );
      final font = pw.Font.ttf(fontData);
      final logoImage = pw.MemoryImage(
        (await rootBundle.load(
          'assets/logos/built_with_flutter.png',
        )).buffer.asUint8List(),
      );
      final pdf = pw.Document(
        theme: pw.ThemeData.withFont(
          base: font,
        ).copyWith(defaultTextStyle: const pw.TextStyle(fontSize: 9)),
      );

      pdf.addPage(
        pw.MultiPage(
          margin: const pw.EdgeInsets.all(32),
          build:
              (context) => [
                _buildHeader(cv),
                _buildExperience(cv),
                _buildSkills(cv),
                _buildEducation(cv),
              ],
          footer:
              (context) =>
                  _buildFooter(logoImage: logoImage, text: cv.pdfFooter),
        ),
      );

      return Right(await pdf.save());
    } catch (e) {
      return const Left(
        PdfGenerationFailure(message: 'Failed to generate PDF'),
      );
    }
  }

  pw.Widget _buildFooter({
    required pw.MemoryImage logoImage,
    required String text,
  }) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.center,
      crossAxisAlignment: pw.CrossAxisAlignment.center,
      children: [
        pw.Image(logoImage, height: 20),
        pw.SizedBox(width: 32),
        pw.Text(text),
      ],
    );
  }

  pw.Widget _buildHeader(Cv cv) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          cv.nameEn.toUpperCase(),
          style: pw.TextStyle(fontSize: 23, color: blue),
        ),
        pw.Text(
          cv.nameUa.toUpperCase(),
          style: pw.TextStyle(fontSize: 12, color: blue),
        ),
        Position(title: cv.position.toUpperCase()),
        pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: <pw.Widget>[
                pw.Text(cv.location),
                pw.Text(cv.phone),
                UrlText(text: cv.email, url: 'mailto:${cv.email}'),
              ],
            ),
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: <pw.Widget>[
                UrlText(text: 'LinkedIn', url: cv.linkedin),
                UrlText(text: 'Telegram', url: cv.telegram),
                UrlText(text: 'GitHub', url: cv.github),
                UrlText(text: 'StackOverflow', url: cv.stackoverflow),
              ],
            ),
            _buildQrCode(),
          ],
        ),
      ],
    );
  }

  pw.Widget _buildQrCode() {
    if (kIsWeb) {
      final url = UrlServiceImpl().getUrl();
      if (url.isNotEmpty) {
        final displayUrl = url.replaceAll(RegExp(r'^https?://(www\.)?'), '');
        return pw.Column(
          mainAxisSize: pw.MainAxisSize.min,
          crossAxisAlignment: pw.CrossAxisAlignment.center,
          children: [
            pw.BarcodeWidget(
              barcode: pw.Barcode.qrCode(),
              data: url,
              width: 50,
              height: 50,
            ),
            pw.SizedBox(height: 4),
            UrlText(url: url, text: displayUrl),
          ],
        );
      }
    }
    return pw.SizedBox.shrink();
  }

  pw.Widget _buildExperience(Cv cv) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        Category(title: 'EXPERIENCE'),
        ...cv.experience.map(
          (e) => pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                '${e.yearFrom} - ${e.yearTo}: ${e.position} at ${e.company}',
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
              ),
              pw.SizedBox(height: 4),
              if (e.reference.isNotEmpty)
                pw.Padding(
                  padding: pw.EdgeInsets.only(bottom: 4),
                  child: RichTextLinkified(
                    'Reference: ${e.reference}',
                    textColor: PdfColor.fromInt(0xFF757575),
                    textSize: 8,
                  ),
                ),
              if (e.description.isNotEmpty)
                ...e.description
                    .split(r'\n')
                    .map(
                      (d) => pw.Padding(
                        padding: const pw.EdgeInsets.only(left: 12, top: 2),
                        child: RichTextLinkified('• $d'),
                      ),
                    ),
              pw.SizedBox(height: 4),
            ],
          ),
        ),
      ],
    );
  }

  pw.Widget _buildSkills(Cv cv) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        Category(title: 'SKILLS & TECHS USED'),
        ...cv.skills.entries.expand(
          (entry) => [
            pw.RichText(
              text: pw.TextSpan(
                children: [
                  pw.TextSpan(
                    text: '${entry.key.label}: ',
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                  ),
                  pw.TextSpan(text: entry.value),
                ],
              ),
            ),
            pw.SizedBox(height: 4),
          ],
        ),
      ],
    );
  }

  pw.Widget _buildEducation(Cv cv) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [Category(title: 'EDUCATION'), pw.Text(cv.education)],
    );
  }
}
