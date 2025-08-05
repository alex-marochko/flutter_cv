import 'package:flutter/material.dart';
import 'package:flutter_cv/core/error/failures.dart';

class ErrorScreen extends StatelessWidget {
  final Failure failure;
  final VoidCallback onRetry;

  const ErrorScreen({super.key, required this.failure, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Error')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(failure.message),
            const SizedBox(height: 16),
            ElevatedButton(onPressed: onRetry, child: const Text('Retry')),
          ],
        ),
      ),
    );
  }
}
