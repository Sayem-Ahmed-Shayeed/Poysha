import 'package:poysha/features/expense/model/expense.dart';

List<double> calculateSummary(List<Expense> expenses) {
  double totalExpense = 0;
  double totalIncome = 0;
  for (Expense expense in expenses) {
    totalIncome += (expense.isIncome) ? expense.amount : 0;
    totalExpense += (!expense.isIncome) ? expense.amount : 0;
  }
  return [totalIncome, totalExpense];
}
