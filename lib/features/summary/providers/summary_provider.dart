import 'package:flutter_riverpod/legacy.dart';
import 'package:intl/intl.dart';
import 'package:poysha/features/expense/model/expense.dart';
import 'package:poysha/features/summary/models/summary_state.dart';

class SummaryNotifier extends StateNotifier<SummaryState> {
  SummaryNotifier() : super(SummaryState());

  Future<void> calculateSummary({
    required List<Expense> expenses,
    required String timeFrame,
    required bool ascending,
  }) async {
    state = state.copyWith(isLoading: true);

    // await Future.delayed(Duration(milliseconds: 100));

    Map<String, List<Expense>> grouped = {};
    Map<String, Map<String, double>> categoryBreakdown = {};
    Map<String, double> totals = {};

    List<Expense> sortedExpenses = List.from(expenses);
    sortedExpenses.sort(
      (a, b) => ascending ? a.date.compareTo(b.date) : b.date.compareTo(a.date),
    );

    switch (timeFrame) {
      case 'Daily':
        grouped = _calculateDaily(sortedExpenses);
        break;
      case 'Weekly':
        grouped = _calculateWeekly(sortedExpenses);
        break;
      case 'Monthly':
        grouped = _calculateMonthly(sortedExpenses);
        break;
      case 'Yearly':
        grouped = _calculateYearly(sortedExpenses);
        break;
      case 'All':
        grouped = _calculateAll(sortedExpenses);
        break;
      default:
        grouped = _calculateDaily(sortedExpenses);
    }

    grouped.forEach((key, expenseList) {
      Map<String, double> categories = {};
      double totalIncome = 0;
      double totalExpense = 0;

      for (var expense in expenseList) {
        if (expense.isIncome) {
          totalIncome += expense.amount;
        } else {
          totalExpense += expense.amount;
          categories.update(
            expense.category,
            (value) => value + expense.amount,
            ifAbsent: () => expense.amount,
          );
        }
      }

      if (totalExpense > 0) {
        categories.forEach((cat, amount) {
          categories[cat] = (amount / totalExpense) * 100;
        });
      }

      categoryBreakdown[key] = categories;
      totals['${key}_income'] = totalIncome;
      totals['${key}_expense'] = totalExpense;
      totals['${key}_remaining'] = totalIncome - totalExpense;
    });

    state = state.copyWith(
      isLoading: false,
      selectedTimeFrame: timeFrame,
      ascending: ascending,
      groupedExpenses: grouped,
      categoryBreakdown: categoryBreakdown,
      totals: totals,
    );
  }

  Map<String, List<Expense>> _calculateDaily(List<Expense> expenses) {
    Map<String, List<Expense>> grouped = {};
    final dateFormat = DateFormat('MMM dd, yyyy');

    for (var expense in expenses) {
      String key = dateFormat.format(expense.date);
      grouped.putIfAbsent(key, () => []).add(expense);
    }

    return grouped;
  }

  Map<String, List<Expense>> _calculateWeekly(List<Expense> expenses) {
    Map<String, List<Expense>> grouped = {};
    final dateFormat = DateFormat('MMM dd, yyyy');

    for (var expense in expenses) {
      DateTime date = expense.date;
      int daysFromSaturday = (date.weekday + 1) % 7;
      DateTime saturday = date.subtract(Duration(days: daysFromSaturday));
      DateTime friday = saturday.add(Duration(days: 6));

      String key =
          '${dateFormat.format(saturday)} - ${dateFormat.format(friday)}';
      grouped.putIfAbsent(key, () => []).add(expense);
    }

    return grouped;
  }

  Map<String, List<Expense>> _calculateMonthly(List<Expense> expenses) {
    Map<String, List<Expense>> grouped = {};
    final dateFormat = DateFormat('MMMM yyyy');

    for (var expense in expenses) {
      String key = dateFormat.format(expense.date);
      grouped.putIfAbsent(key, () => []).add(expense);
    }

    return grouped;
  }

  Map<String, List<Expense>> _calculateYearly(List<Expense> expenses) {
    Map<String, List<Expense>> grouped = {};

    for (var expense in expenses) {
      String key = expense.date.year.toString();
      grouped.putIfAbsent(key, () => []).add(expense);
    }

    return grouped;
  }

  Map<String, List<Expense>> _calculateAll(List<Expense> expenses) {
    return {'All Time': expenses};
  }
}

final summaryProvider = StateNotifierProvider<SummaryNotifier, SummaryState>((
  ref,
) {
  return SummaryNotifier();
});
