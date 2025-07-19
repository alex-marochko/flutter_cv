import 'package:flutter_linkify/flutter_linkify.dart' show LinkableElement;
import 'package:url_launcher/url_launcher.dart' show canLaunchUrl, launchUrl;

Future<void> launchLink(LinkableElement link) async {
  final uri = Uri.parse(link.url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri);
  }
}