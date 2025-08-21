import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cv/core/di/service_locator.dart';
import 'package:flutter_cv/core/services/analytics_service.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactSection extends StatelessWidget {
  final String email;
  final String telegram;
  final String linkedin;
  final String github;
  final String stackoverflow;

  const ContactSection({
    super.key,
    required this.email,
    required this.telegram,
    required this.linkedin,
    required this.github,
    required this.stackoverflow,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _EmailChip(email: email),
        const SizedBox(height: 8),
        Wrap(
          spacing: 16,
          runSpacing: 12,
          children: [
            _LinkChip(
              label: 'LinkedIn',
              assetPath: 'assets/icons/linkedin.png',
              url: linkedin,
            ),
            _LinkChip(
              label: 'Telegram',
              assetPath: 'assets/icons/telegram.png',
              url: telegram,
            ),
            _LinkChip(
              label: 'GitHub',
              assetPath: 'assets/icons/github.png',
              url: github,
            ),
            _LinkChip(
              label: 'StackOverflow',
              assetPath: 'assets/icons/stackoverflow.png',
              url: stackoverflow,
            ),
          ],
        ),
      ],
    );
  }
}

class _EmailChip extends StatelessWidget {
  final String email;
  const _EmailChip({required this.email});

  Future<void> _launchEmail() async {
    sl<AnalyticsService>().logEvent(
      'contact_click',
      parameters: {'type': 'email'},
    );
    final uri = Uri(scheme: 'mailto', path: email);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  void _copyToClipboard(BuildContext context) {
    sl<AnalyticsService>().logEvent('copy_email');
    Clipboard.setData(ClipboardData(text: email));
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Email copied to clipboard')));
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ActionChip(
          onPressed: _launchEmail,
          label: Row(
            children: [
              const Icon(Icons.email, size: 20),
              const SizedBox(width: 8),
              Text(
                email,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        IconButton(
          icon: const Icon(Icons.copy, size: 18),
          tooltip: 'Copy email',
          onPressed: () => _copyToClipboard(context),
        ),
      ],
    );
  }
}

class _LinkChip extends StatelessWidget {
  final String label;
  final String assetPath;
  final String url;

  const _LinkChip({
    required this.label,
    required this.assetPath,
    required this.url,
  });

  Future<void> _launch() async {
    sl<AnalyticsService>().logEvent(
      'contact_click',
      parameters: {'type': label},
    );
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      onPressed: _launch,
      avatar: Image.asset(assetPath, width: 20, height: 20),
      label: Text(label, style: Theme.of(context).textTheme.bodyMedium),
    );
  }
}
