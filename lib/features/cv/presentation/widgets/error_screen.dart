import 'package:flutter/material.dart';
import 'package:flutter_cv/core/error/failures.dart';

class ErrorScreen extends StatelessWidget {
  final Failure failure;
  final VoidCallback onRetry;

  const ErrorScreen({super.key, required this.failure, required this.onRetry});

  String _getErrorMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure _:
        return 'Failed to fetch data from the server. Please try again later.';
      case PdfGenerationFailure _:
        return 'Failed to generate PDF. Please try again.';
      default:
        return 'Failed to fetch data. Please try again.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Error')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_getErrorMessage(failure)),
            const SizedBox(height: 16),
            ElevatedButton(onPressed: onRetry, child: const Text('Retry')),
          ],
        ),
      ),
    );
  }
}
