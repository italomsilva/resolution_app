import 'package:flutter/material.dart';

class MyClickableCard extends StatefulWidget {
  final Widget child;
  final VoidCallback? handleClick;

  const MyClickableCard({super.key, required this.child, this.handleClick});

  @override
  State<MyClickableCard> createState() => _MyClickableCardState();
}

class _MyClickableCardState extends State<MyClickableCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      elevation: 4.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: InkWell(
        splashColor: Theme.of(context).splashColor,
        onTap: widget.handleClick,
        child: Padding(padding: const EdgeInsets.all(16.0), child: widget.child),
      ),
    );
  }
}