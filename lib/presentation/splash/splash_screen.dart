import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:go_router/go_router.dart';
import 'package:resolution_app/presentation/commom_widgets/MyFormButton.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.lightbulb_outline, size: 100, color: theme.primaryColor),
              const SizedBox(height: 24),
              Text(
                "ResolutionApp",
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.primaryColorDark,
                ),
              ),
          
              const SizedBox(height: 8),
              Text(
                "Conectando problemas e soluções.",
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.hintColor,
                ),
              ),
              const SizedBox(height: 60),
              MyFormButton(text: "Continuar", onPressed: () => context.go("/"),)
            ],
          ),
        ),
      ),
    );
  }
}
