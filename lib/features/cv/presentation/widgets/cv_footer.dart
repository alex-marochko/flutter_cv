import 'package:flutter/material.dart';

class CvFooter extends StatelessWidget {
  const CvFooter({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset('assets/logos/built_with_flutter.png', height: 36),
        const SizedBox(width: 32),
        Text(text, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }
}
