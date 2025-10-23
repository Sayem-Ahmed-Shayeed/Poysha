import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../const/month_names.dart';

class CategoryBreakdownWidget extends StatelessWidget {
  final Map<String, double> categoryPercentages;

  const CategoryBreakdownWidget({super.key, required this.categoryPercentages});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (categoryPercentages.isEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20.h),
          child: Text(
            'No expenses in this period',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
            ),
          ),
        ),
      );
    }

    final sortedCategories = categoryPercentages.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return Column(
      children: sortedCategories.map((entry) {
        return Container(
          margin: EdgeInsets.symmetric(vertical: 4.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(entry.key, style: theme.textTheme.titleMedium),
                  Text(
                    '${entry.value.toStringAsFixed(1)}%',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4.h),
              Container(
                height: 8.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(0),
                  border: Border.all(
                    width: 0.5,
                    color: theme.colorScheme.onSurface,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: theme.colorScheme.onSurface,
                      offset: const Offset(1, 1),
                      blurRadius: 0,
                    ),
                  ],
                ),
                child: LinearProgressIndicator(
                  value: entry.value / 100,
                  backgroundColor: theme.colorScheme.surface,
                  valueColor: AlwaysStoppedAnimation(
                    getColorForCategory(entry.key),
                  ),
                  minHeight: 8.h,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
