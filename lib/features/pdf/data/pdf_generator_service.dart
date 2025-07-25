import 'dart:typed_data';
import 'package:pdf/pdf.dart' show PdfColor;
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter_cv/features/cv/domain/entities/cv.dart';
import 'package:printing/printing.dart' show PdfGoogleFonts;
import 'package:flutter_cv/features/pdf/presentation/widgets/pdf_widgets.dart';

enum CategoryTitle {
  experience,
  skills,
  education,
}

class PdfGeneratorService {
  Future<Uint8List> generateCvPdf(Cv cv) async {
    final font = await PdfGoogleFonts.manropeRegular();
    final pdf = pw.Document(
        theme: pw.ThemeData.withFont(base: font)
            .copyWith(defaultTextStyle: pw.TextStyle(fontSize: 9)));

    pdf.addPage(
      pw.MultiPage(
        margin: const pw.EdgeInsets.all(32),
        build: (context) => [
          _buildHeader(cv),
          _buildExperience(cv),
          _buildSkills(cv),
          _buildEducation(cv),
        ],
      ),
    );

    return pdf.save();
  }

  pw.Widget _buildHeader(Cv cv) {
    return pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(cv.nameEn.toUpperCase(),
              style: pw.TextStyle(fontSize: 23, color: blue)),
          pw.Text(cv.nameUa.toUpperCase(),
              style: pw.TextStyle(fontSize: 12, color: blue)),
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
                pw.Text('[QR code]'),
              ]),
        ]);
  }

  pw.Widget _buildExperience(Cv cv) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        Category(title: 'EXPERIENCE'),
        ...cv.experience.map((e) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(
                '${e.yearFrom} - ${e.yearTo}: ${e.position} at ${e.company}',
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 4),
            if (e.reference.isNotEmpty)
              pw.Padding(
                padding: pw.EdgeInsets.only(bottom: 4),
                child: RichTextLinkified('Reference: ${e.reference}',
                    textColor: PdfColor.fromInt(0xFF757575), textSize: 8),
              ),
            if (e.description.isNotEmpty)
              ...e.description.split(r'\n').map((d) => pw.Padding(
                    padding: const pw.EdgeInsets.only(left: 12, top: 2),
                    child: RichTextLinkified('• $d'),
                  )),
            pw.SizedBox(height: 4),
          ],
        )),
      ],
    );
  }

  pw.Widget _buildSkills(Cv cv) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        Category(title: 'SKILLS & TECHS USED'),
        ...cv.skills.entries.map((entry) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text('${entry.key.label}:',
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
            pw.Padding(
              padding: pw.EdgeInsets.only(left: 12),
              child: pw.Text('${entry.value}, '),
            ),
            pw.SizedBox(height: 4),
          ],
        )),
      ],
    );
  }

  pw.Widget _buildEducation(Cv cv) {
    return pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [Category(title: 'EDUCATION'), pw.Text(cv.education)]);
  }
}
