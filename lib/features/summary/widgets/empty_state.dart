import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget buildEmptyState(ThemeData theme) {
  return Container(
    height: 300.h,
    padding: EdgeInsetsGeometry.all(20.w),
    decoration: BoxDecoration(
      color: theme.colorScheme.surfaceContainerLowest,
      borderRadius: BorderRadius.circular(4),
    ),

    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.receipt_long_outlined,
            size: 80.sp,
            color: theme.colorScheme.onSurface.withOpacity(0.3),
          ),
          SizedBox(height: 20.h),
          Text(
            'No expenses found',
            style: theme.textTheme.titleLarge?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.6),
            ),
          ),
          SizedBox(height: 5.h),
          Text(
            'Add your first expense to see summary',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.5),
            ),
          ),
        ],
      ),
    ).animate(effects: [FadeEffect(duration: 500.ms)]),
  );
}
