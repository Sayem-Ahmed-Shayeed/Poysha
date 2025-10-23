import 'package:poysha/features/expense/consts/categories.dart';

List<double> calculateCategorySpending(List expenses) {
  Map<String, double> categorySpending = {};
  double totalExpense = 0;

  for (var expense in expenses) {
    String category = expense.category;
    double amount = expense.amount;
    final isIncome = expense.isIncome;

    if (!isIncome) {
      if (categorySpending.containsKey(category)) {
        categorySpending[category] = categorySpending[category]! + amount;
      } else {
        categorySpending[category] = amount;
      }
      totalExpense += amount;
    }
  }
  List<double> categoryPercentage = [];
  for (var i in expenseCategories) {
    categoryPercentage.add(0);
  }
  categorySpending.forEach((category, expenseAmount) {
    double percentage = expenseAmount / totalExpense;
    int index = expenseCategories.indexOf(category);
    categoryPercentage[index] = percentage;
  });
  return categoryPercentage;
}
