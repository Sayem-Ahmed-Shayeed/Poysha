import 'package:flutter/material.dart';

class SummaryText extends StatelessWidget {
  const SummaryText({
    super.key,
    required this.title,
    required this.value,
    required this.symbol,
  });

  final String title;
  final double value;
  final String symbol;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: '$title :'.padRight(18),
            style: theme.textTheme.titleSmall?.copyWith(
              color: theme.colorScheme.onPrimaryContainer,
            ),
          ),

          TextSpan(
            text: symbol,
            style: theme.textTheme.titleSmall?.copyWith(
              color: theme.colorScheme.onPrimaryContainer,
            ),
          ),
          TextSpan(
            text: value.abs().toStringAsFixed(2),
            style: theme.textTheme.titleSmall?.copyWith(
              color: theme.colorScheme.onPrimaryContainer,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
