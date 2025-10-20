import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:poysha/features/summary/widgets/summary_text.dart';

class SummaryCard extends StatelessWidget {
  const SummaryCard({
    super.key,
    required this.totalIncome,
    required this.totalExpense,
    required this.remaining,
  });

  final double totalIncome;
  final double totalExpense;
  final double remaining;

  @override
  Widget build(BuildContext context) {
    final remainingNeg = remaining < 0.0;
    final remainingSymbol = remaining == 0
        ? ''
        : remainingNeg
        ? '-'
        : '+';
    final totalIncomeSymbol = totalIncome == 0 ? '' : '+';
    final totalExpenseSymbol = totalExpense == 0 ? '' : '-';

    final theme = Theme.of(context);
    return Container(
      width: 1.sw,
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer,
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SummaryText(
            title: 'Total Income ',
            value: totalIncome,
            symbol: totalIncomeSymbol,
          ),
          SizedBox(height: 1.h),
          SummaryText(
            title: 'Total Expense',
            value: totalExpense,
            symbol: totalExpenseSymbol,
          ),
          SizedBox(height: 1.h),
          Divider(color: theme.colorScheme.onPrimaryContainer, thickness: 0.2),
          SizedBox(height: 1.h),
          SummaryText(
            title: 'Remaining    ',
            value: remaining,
            symbol: remainingSymbol,
          ),
        ],
      ),
    );
  }
}
