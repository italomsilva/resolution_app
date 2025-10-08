import 'package:flutter/material.dart';

class IndicatorGraph extends StatelessWidget {
  final Color color;
  final String text;
  final bool isSquare;
  final double size;

  const IndicatorGraph({
    super.key,
    required this.color,
    required this.text,
    this.isSquare = false,
    this.size = 14,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
            color: color,
            borderRadius: isSquare ? BorderRadius.circular(3.0) : null,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          text,
          style: theme.textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
