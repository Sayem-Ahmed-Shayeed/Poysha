import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../model/expense.dart';
import '../providers/expense_provider.dart';
import '../widgets/custom_snackbar.dart';

Future<bool> confirmDismiss({
  required BuildContext context,
  required Expense expense,
  required WidgetRef ref,
}) async {
  final theme = Theme.of(context);
  final result = await showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: theme.colorScheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
          side: BorderSide(color: theme.colorScheme.onSurface),
        ),
        content: Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          width: 750.w,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: theme.colorScheme.error.withOpacity(0.2),
                ),
                child: Icon(
                  Icons.warning,
                  color: theme.colorScheme.error,
                  size: 40,
                ),
              ),
              SizedBox(height: 20),
              Text("Delete Expense?", style: theme.textTheme.titleLarge),
              SizedBox(height: 10),
              Text(
                "Do you really want to delete '${expense.title}'?",
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium,
              ),
              SizedBox(height: 5),
              Text(
                "This cannot be undone!",
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.error,
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: theme.colorScheme.surfaceContainerHighest,
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(2, 2),
                          blurRadius: 0,
                          color: theme.colorScheme.onSurface,
                        ),
                      ],
                    ),
                    child: TextButton(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          "Cancel",
                          style: TextStyle(color: theme.colorScheme.onSurface),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop(false);
                      },
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: theme.colorScheme.error,
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(2, 2),
                          blurRadius: 0,
                          color: theme.colorScheme.onSurface,
                        ),
                      ],
                    ),
                    child: TextButton(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          "Delete",
                          style: TextStyle(color: theme.colorScheme.onError),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop(true);
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );

  if (result == true) {
    ref.read(expenseProvider.notifier).removeExpense(expense);
    if (context.mounted) {
      customSnackBar(context: context, message: '${expense.title} deleted');
    }
    return true;
  }
  return false;
}
