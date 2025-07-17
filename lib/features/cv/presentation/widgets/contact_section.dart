import 'package:flutter/material.dart';
import 'package:flutter_cv/features/cv/presentation/widgets/cv_section_card.dart';

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
    return CvSectionCard(
      title: 'Contacts',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLink('Email', email),
          _buildLink('Telegram', telegram),
          _buildLink('LinkedIn', linkedin),
          _buildLink('GitHub', github),
          _buildLink('Stack Overflow', stackoverflow),
        ],
      ),
    );
  }

  Widget _buildLink(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text('$label: ', style: const TextStyle(fontWeight: FontWeight.bold)),
          Flexible(
            child: Text(
              value,
              style: const TextStyle(color: Colors.blue),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}