import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:linkify/linkify.dart' show linkify;
import 'package:pdf/pdf.dart' show PdfColor;
import 'package:pdf/widgets.dart' as pw;

const PdfColor blue = PdfColor.fromInt(0xff155577);
const PdfColor lightBlue = PdfColor.fromInt(0xffb9e0f3);

class Position extends pw.StatelessWidget {
  Position({required this.title});

  final String title;

  @override
  pw.Widget build(pw.Context context) {
    return ColoredTextBlock(
      text: title,
      textColor: PdfColor(1, 1, 1),
      bgColour: blue,
      bold: true,
    );
  }
}

class Category extends pw.StatelessWidget {
  Category({required this.title});

  final String title;

  @override
  pw.Widget build(pw.Context context) {
    return ColoredTextBlock(
      text: title,
      textColor: PdfColor(0, 0, 0),
      bgColour: lightBlue,
    );
  }
}

class ColoredTextBlock extends pw.StatelessWidget {
  ColoredTextBlock({
    required this.text,
    required this.textColor,
    required this.bgColour,
    this.bold = false,
  });

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
      margin: const pw.EdgeInsets.only(bottom: 8, top: 8),
      padding: const pw.EdgeInsets.all(4),
      child: pw.Text(
        text,
        style: pw.TextStyle(
          color: textColor,
          fontWeight: bold ? pw.FontWeight.bold : pw.FontWeight.normal,
        ),
      ),
    );
  }
}

class UrlText extends pw.StatelessWidget {
  UrlText({required this.text, required this.url});

  final String text;
  final String url;

  @override
  pw.Widget build(pw.Context context) {
    return pw.UrlLink(
      destination: url,
      child: pw.Text(
        text,
        style: const pw.TextStyle(
          decoration: pw.TextDecoration.underline,
          color: blue,
        ),
      ),
    );
  }
}

class RichTextLinkified extends pw.StatelessWidget {
  final PdfColor? textColor;
  final double? textSize;
  final String text;

  RichTextLinkified(this.text, {this.textColor, this.textSize});

  @override
  pw.Widget build(pw.Context context) {
    return pw.RichText(
      text: pw.TextSpan(
        children:
            linkify(text)
                .map(
                  (t) =>
                      (t is UrlElement)
                          ? pw.TextSpan(
                            text: t.originText,
                            style: pw.TextStyle(
                              color: blue,
                              decoration: pw.TextDecoration.underline,
                              fontSize: textSize,
                            ),
                          )
                          : pw.TextSpan(
                            text: t.originText,
                            style: pw.TextStyle(
                              color: textColor,
                              fontSize: textSize,
                            ),
                          ),
                )
                .toList(),
      ),
    );
  }
}
