import 'dart:typed_data';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:flutter_cv/features/cv/domain/entities/cv.dart';
import 'package:printing/printing.dart' show PdfGoogleFonts;

class PdfGeneratorService {
  Future<Uint8List> generateCvPdf(Cv cv) async {

    final font = await PdfGoogleFonts.robotoRegular();
    final pdf = pw.Document(
      theme: pw.ThemeData.withFont(base: font)
    );

    final nameLine = '${cv.nameEn} (${cv.position})';

    pdf.addPage(
      pw.MultiPage(
        margin: const pw.EdgeInsets.all(32),
        build: (context) => [
          pw.Header(level: 0, child: pw.Text(nameLine, style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold))),

          pw.Text(cv.nameUa, style: pw.TextStyle(fontSize: 14, color: PdfColors.grey)),

          pw.SizedBox(height: 16),
          pw.Text('${cv.location} ∙ phone: ${cv.phone} ∙ tg: ${cv.telegram}'),
          pw.Text('email: ${cv.email}'),
          pw.Text('LinkedIn: ${cv.linkedin}'),
          pw.Text('GitHub: ${cv.github}'),
          pw.Text('StackOverflow: ${cv.stackoverflow}'),

          pw.SizedBox(height: 24),
          _buildSectionTitle('EXPERIENCE'),
          ...cv.experience.map((e) => pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Bullet(text: '${e.yearFrom} - ${e.yearTo}: ${e.position} at ${e.company}'),

              if (e.description.isNotEmpty) pw.Padding(
                padding: const pw.EdgeInsets.only(left: 12),
                child: pw.Text('• ${e.description}'),
              ),
              // if (e.link != null) pw.Padding(
              //   padding: const pw.EdgeInsets.only(left: 12),
              //   child: pw.UrlLink(destination: e.link!, child: pw.Text(e.link!, style: const pw.TextStyle(color: PdfColors.blue))),
              // ),
              pw.SizedBox(height: 8),
            ],
          )),

          pw.SizedBox(height: 24),
          _buildSectionTitle('SKILLS & TECHS USED'),
          ...cv.skills.entries.map((entry) => pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text('${entry.key}:', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
              pw.Text('${entry.value}, '),
              pw.SizedBox(height: 8),
            ],
          )),

          pw.SizedBox(height: 24),
          _buildSectionTitle('EDUCATION'),
          pw.Text(cv.education),

          // if (cv.experience. != null && cv.references.isNotEmpty) ...[
          //   pw.SizedBox(height: 24),
          //   _buildSectionTitle('REFERENCES'),
          //   ...cv.references.map((r) => pw.Text('• $r')),
          // ]
        ],
      ),
    );

    return pdf.save();
  }

  pw.Widget _buildSectionTitle(String title) {
    return pw.Text(title, style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold));
  }
}
