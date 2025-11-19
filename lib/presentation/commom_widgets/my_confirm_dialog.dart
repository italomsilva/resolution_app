import 'package:flutter/material.dart';

Future<String?> myConfirmDialogMessage({
  required BuildContext context,
  required String title,
  required String message,
  required String cancelMessage,
  required String confirmMessage,
  required String labelText,
  required TextEditingController passwordController,
}) async {
  final result = await showDialog<String>(
    context: context,
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        title: Text(title),
        content: Form(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(message, style: TextStyle(fontSize: 14)),
              SizedBox(height: 10),
              TextFormField(
                controller: passwordController,
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  labelText: labelText,
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Não pode estar vazio';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text(cancelMessage),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(dialogContext).pop(passwordController.text);
            },
            child: Text(confirmMessage),
          ),
        ],
      );
    },
  );
  return result;
}
