import 'package:flutter/material.dart';

class SunriseGradientBackground extends StatelessWidget {
  final Widget child;

  const SunriseGradientBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [
            Color(0xFF175394),
            Theme.of(context).scaffoldBackgroundColor,
          ],
        ),
      ),
      child: child,
    );
  }
}
