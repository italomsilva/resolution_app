import 'package:flutter/material.dart';

Future<bool> myConfirmActionMessage(
  BuildContext context,
  String title,
  String message,
  String cancelMessage,
  String confirmMessage,
) async {
  final theme = Theme.of(context);
  final result = await showDialog<bool>(
    context: context,
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop(false);
            },
            child: Text(
              cancelMessage,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: theme.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            onPressed: () {
              Navigator.of(dialogContext).pop(true);
            },
            child: Text(
              confirmMessage,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      );
    },
  );

  return result ?? false;
}
