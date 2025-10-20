import 'package:poysha/features/expense/model/expense.dart';

calculateMonthlySummary(List<Expense> expense, int month) {
  int year = DateTime.now().year;
  double totalIncome = 0;
  double totalExpense = 0;
  List<Expense> monthlyExpenses = [];

  for (var exp in expense) {
    if (exp.date.month == month && exp.date.year == year) {
      monthlyExpenses.add(exp);
      if (exp.isIncome) {
        totalIncome += exp.amount;
      } else {
        totalExpense += exp.amount;
      }
    }
  }
  return [totalIncome, totalExpense, monthlyExpenses];
}
