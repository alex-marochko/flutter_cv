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
        Container(
          padding: EdgeInsets.all(4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            gradient: LinearGradient(
              colors: [Colors.transparent, Colors.white70],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: FlutterLogo(size: 36, style: FlutterLogoStyle.markOnly),
        ),
        const SizedBox(width: 16),
        ConstrainedBox(
          constraints: BoxConstraints.loose(Size.fromWidth(300)),
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodySmall,
            textAlign: TextAlign.left,
            maxLines: 2,
            softWrap: true,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
