import 'package:poysha/features/expense/model/expense.dart';

Map<DateTime, List<Expense>> calculateDailySummary({
  required List<Expense> expenses,
  required bool ascending,
}) {
  if (ascending) {
    expenses.sort((Expense a, Expense b) => a.date.compareTo(b.date));
  } else {
    expenses.sort((Expense a, Expense b) => b.date.compareTo(a.date));
  }
  Map<DateTime, List<Expense>> dateWiseSortedExpenses = {};
  for (Expense expense in expenses) {
    DateTime key = expense.date;
    if (dateWiseSortedExpenses.containsKey(key)) {
      dateWiseSortedExpenses[key]!.add(expense);
    } else {
      dateWiseSortedExpenses[key] = [expense];
    }
  }
  dateWiseSortedExpenses.forEach((key, value) {
    print('${key.day}/${key.month}/${key.year}:');
    for (var exp in value) {
      print('${exp.title}: ${exp.amount}');
    }
    print('\n');
  });

  return dateWiseSortedExpenses;
}
