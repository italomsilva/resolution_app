import 'package:flutter/material.dart';

Future<bool> myConfirmActionMessage(
  BuildContext context,
  String title,
  String message,
  String cancelMessage,
  String confirmMessage,
) async {
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
            child: Text(cancelMessage),
          ),

          TextButton(
            style: TextButton.styleFrom(),
            onPressed: () {
              Navigator.of(dialogContext).pop(true);
            },
            child: Text(confirmMessage),
          ),
        ],
      );
    },
  );

  return result ?? false;
}
