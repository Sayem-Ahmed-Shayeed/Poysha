import 'package:hive/hive.dart';

import '../model/expense.dart';

class ExpenseDbHelper {
  final Box expenseBox = Hive.box('expenseBox');

  List<Expense> getExpenses() {
    final dynamic expenses = expenseBox.get('expenses');
    if (expenses != null && expenses is List) {
      return expenses.cast<Expense>().toList();
    }
    return <Expense>[];
  }

  Future<void> saveExpenses(List<Expense> expenses) async {
    await expenseBox.put('expenses', expenses);
  }

  Future<void> clearExpenses() async {
    await expenseBox.delete('expenses');
  }

  Future<void> removeExpense(Expense expense) async {
    final expenses = getExpenses();
    expenses.removeWhere((e) => e.id == expense.id);
    await saveExpenses(expenses);
  }

  Future<void> updateExpense(Expense updatedExpense) async {
    final expenses = getExpenses();
    final index = expenses.indexWhere((e) => e.id == updatedExpense.id);
    if (index != -1) {
      expenses[index] = updatedExpense;
      await saveExpenses(expenses);
    }
  }
}
