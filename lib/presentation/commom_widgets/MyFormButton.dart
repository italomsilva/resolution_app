import 'package:flutter/material.dart';

class MyFormButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  const MyFormButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
  });

  @override
  State<MyFormButton> createState() => _MyFormButtonState();
}

class _MyFormButtonState extends State<MyFormButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: widget.isLoading ? null : widget.onPressed,
        child: widget.isLoading
            ? SizedBox(
                height: 26,
                width: 26,
                child: CircularProgressIndicator(),
              )
            : Text(
                widget.text,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                  fontSize: 16,
                ),
              ),
      ),
    );
  }
}
