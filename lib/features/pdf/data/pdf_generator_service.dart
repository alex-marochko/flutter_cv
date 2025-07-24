import 'dart:typed_data';
import 'package:flutter_cv/features/pdf/data/pdf_generator_service.dart' as PdfColors show blue;
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:linkify/linkify.dart' show linkify;
import 'package:pdf/pdf.dart' show PdfColor;
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter_cv/features/cv/domain/entities/cv.dart';
import 'package:printing/printing.dart' show PdfGoogleFonts;

const PdfColor blue = PdfColor.fromInt(0xff155577);
const PdfColor lightBlue = PdfColor.fromInt(0xffb9e0f3);

class PdfGeneratorService {
  Future<Uint8List> generateCvPdf(Cv cv) async {

    final font = await PdfGoogleFonts.manropeRegular();
    final pdf = pw.Document(
      theme: pw.ThemeData.withFont(base: font).copyWith(defaultTextStyle: pw.TextStyle(fontSize: 10))
    );

    pdf.addPage(
      pw.MultiPage(
        margin: const pw.EdgeInsets.all(32),
        build: (context) => [
          pw.Text(cv.nameEn.toUpperCase(), style: pw.TextStyle(fontSize: 23, color: blue)),
          pw.Text(cv.nameUa.toUpperCase(), style: pw.TextStyle(fontSize: 12, color: blue)),
          _Position(title: cv.position.toUpperCase()),

          pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: <pw.Widget>[
                  pw.Text(cv.location),
                  pw.Text(cv.phone),
                  _UrlText(text: cv.email, url: 'mailto:${cv.email}'),
                ],
              ),
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: <pw.Widget>[
                  _UrlText(text: 'LinkedIn', url: cv.linkedin),
                  _UrlText(text: 'Telegram', url: cv.telegram),
                  _UrlText(text: 'GitHub', url: cv.github),
                  _UrlText(text: 'StackOverflow', url: cv.stackoverflow),
                ],
              ),
              pw.Text('[QR code]'),
            ]
          ),

          _Category(title: 'EXPERIENCE'), // todo: make enum
          ...cv.experience.map((e) => pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text('${e.yearFrom} - ${e.yearTo}: ${e.position} at ${e.company}', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
              if(e.reference.isNotEmpty) pw.Padding(
                padding: pw.EdgeInsets.symmetric(vertical: 4),
                child: _RichTextLinkified('Reference: ${e.reference}', textColor: PdfColor.fromInt(0xFF757575), textSize: 8),
              ),

              if (e.description.isNotEmpty) ...e.description.split(r'\n').map((d) => pw.Padding(
                padding: const pw.EdgeInsets.only(left: 12),
                child: _RichTextLinkified('• $d', textSize: 9),
              )),
              pw.SizedBox(height: 8),
            ],
          )),

          _Category(title: 'SKILLS & TECHS USED'),
          ...cv.skills.entries.map((entry) => pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text('${entry.key}:', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
              pw.Text('${entry.value}, '),
              pw.SizedBox(height: 8),
            ],
          )),

          pw.SizedBox(height: 24),
          _Category(title: 'EDUCATION'),
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
}

class _Position extends pw.StatelessWidget {
  _Position({required this.title});

  final String title;

  @override
  pw.Widget build(pw.Context context) {
    return _ColoredTextBlock(text: title, textColor: PdfColor(1, 1, 1), bgColour: blue, bold: true);
  }
}



class _Category extends pw.StatelessWidget {
  _Category({required this.title});

  final String title;

  @override
  pw.Widget build(pw.Context context) {
    return _ColoredTextBlock(text: title, textColor: PdfColor(0, 0, 0), bgColour: lightBlue);
  }
}

class _ColoredTextBlock extends pw.StatelessWidget {
  _ColoredTextBlock({required this.text, required this.textColor, required this.bgColour, this.bold = false});

  final String text;
  final PdfColor textColor;
  final PdfColor bgColour;
  final bool bold;

  @override
  pw.Widget build(pw.Context context) {
    return pw.Container(
      decoration: pw.BoxDecoration(
        color: bgColour,
        borderRadius: const pw.BorderRadius.all(pw.Radius.circular(4)),
      ),
      margin: const pw.EdgeInsets.only(bottom: 8, top: 16),
      padding: const pw.EdgeInsets.all(4),
      child: pw.Text(
        text,
        style: pw.TextStyle(color: textColor, fontWeight: bold? pw.FontWeight.bold : pw.FontWeight.normal)
      ),
    );
  }
}

class _UrlText extends pw.StatelessWidget {
  _UrlText({required this.text, required this.url});

  final String text;
  final String url;

  @override
  pw.Widget build(pw.Context context) {
    return pw.UrlLink(
      destination: url,
      child: pw.Text(text,
          style: const pw.TextStyle(
            decoration: pw.TextDecoration.underline,
            color: PdfColors.blue,
          )),
    );
  }
}

class _RichTextLinkified extends pw.StatelessWidget {
  final PdfColor? textColor;
  final double? textSize;
  final String text;

  _RichTextLinkified( this.text, {this.textColor, this.textSize});

  @override
  pw.Widget build(pw.Context context) {
    return pw.RichText(
        text: pw.TextSpan(children:
        linkify(text).map((t) => (t is UrlElement)?
        pw.TextSpan(text: t.originText, style: pw.TextStyle(color: PdfColors.blue, decoration: pw.TextDecoration.underline, fontSize: textSize))
            :pw.TextSpan(text: t.originText, style: pw.TextStyle(color: textColor, fontSize: textSize))).toList()));
  }
}
