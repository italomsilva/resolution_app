import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MyErrorWidget extends StatelessWidget {
  final String baseMessage;
  final String? specificError;
  final String? redirectPath;
  final String buttonText;

  const MyErrorWidget({
    super.key,
    required this.baseMessage,
    this.specificError,
    this.redirectPath,
    this.buttonText = "Voltar",
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                color: theme.colorScheme.error,
                size: 80,
              ),
              const SizedBox(height: 24),
              Text(
                baseMessage,
                textAlign: TextAlign.center,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Text(specificError ?? "", textAlign: TextAlign.center),
              const SizedBox(height: 36),
              if (redirectPath != null)
                ElevatedButton(
                  onPressed: () {
                    context.go(redirectPath!);
                  },
                  child: Text(buttonText),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 15,
                    ),
                    textStyle: const TextStyle(fontSize: 16),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
