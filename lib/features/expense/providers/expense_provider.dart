import 'package:flutter_riverpod/legacy.dart';
import 'package:poysha/features/expense/expense_persistency/expense_db_helper.dart';

import '../model/expense.dart';

class ExpenseProviderNotifier extends StateNotifier<List<Expense>> {
  ExpenseProviderNotifier() : super([]) {
    state = _expenseDB.getExpenses();
  }

  final ExpenseDbHelper _expenseDB = ExpenseDbHelper();

  void addExpense(Expense expense) {
    state = [...state, expense];
    _expenseDB.saveExpenses(state);
  }

  void removeExpense(Expense expense) {
    state = state.where((e) => e.id != expense.id).toList();
    _expenseDB.removeExpense(expense);
  }

  void updateExpense(Expense updatedExpense) {
    state = state.map((expense) {
      if (expense.id == updatedExpense.id) {
        return updatedExpense;
      }
      return expense;
    }).toList();
    _expenseDB.updateExpense(updatedExpense);
  }

  void clearExpenses() {
    state = [];
    _expenseDB.clearExpenses();
  }
}

final expenseProvider =
    StateNotifierProvider<ExpenseProviderNotifier, List<Expense>>(
      (ref) => ExpenseProviderNotifier(),
    );
//list of expense it will return where each expense has a dateTime so we can just find the monthly and the yearly query usig the dateTIme
