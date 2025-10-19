import 'package:flutter/material.dart';

class ExpenseCard extends StatelessWidget {
  const ExpenseCard({
    super.key,
    required this.category,
    required this.title,
    required this.date,
    required this.amount,
    required this.colorIndex,
  });

  final String category;
  final String title;
  final String date;
  final String amount;
  final int colorIndex;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final List<Color> expenseCardColors = [
      Color(0xFF94A3B8), // Slate Blue
      Color(0xFF7C3AED), // Purple
      Color(0xFF2563EB), // Blue
      Color(0xFF059669), // Emerald
      Color(0xFFEAB308), // Yellow
      Color(0xFFEA580C), // Orange
      Color(0xFFDC2626), // Red
      Color(0xFF7C2D12), // Brown
    ];
    final inDarkMode = theme.brightness == Brightness.dark;
    final adjustedColors = expenseCardColors
        .map((color) => inDarkMode ? color.withValues(alpha: 0.7) : color)
        .toList();

    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      decoration: BoxDecoration(
        color: adjustedColors[colorIndex % adjustedColors.length],
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: theme.colorScheme.onSurface, width: 1),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.onSurface,
            offset: const Offset(2, 2),
            blurRadius: 0,
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                textAlign: TextAlign.start,
                "• $category",
                style: theme.textTheme.titleMedium?.copyWith(
                  color: theme.colorScheme.surface,
                ),
              ),
            ],
          ),
          Divider(thickness: 0.3, color: theme.colorScheme.surface),
          ListTile(
            leading: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: theme.colorScheme.surface,
              ),
              child: Icon(
                Icons.remove,
                color: theme.colorScheme.onSurface,
                size: 20,
              ),
            ),
            title: Text(
              title,
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.surface,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              date,
              style: theme.textTheme.titleSmall?.copyWith(
                color: theme.colorScheme.surface,
              ),
            ),
            trailing: Text(
              amount,
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.surface,
                fontWeight: FontWeight.bold,
              ),
            ),
            contentPadding: EdgeInsets.zero,
          ),
        ],
      ),
    );
  }
}
