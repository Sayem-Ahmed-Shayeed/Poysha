import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poysha/features/expense/pages/expense_pages/edit_expense_page.dart';
import 'package:poysha/features/expense/pages/income_pages/edit_income_page.dart';
import 'package:poysha/features/expense/providers/expense_provider.dart';
import 'package:poysha/features/expense/widgets/expense_card.dart';
import 'package:poysha/features/theme/providers/theme_mode_provider.dart';

import '../helpers/dismissble_widget_helper.dart';
import 'expense_gate.dart';

class ExpensePage extends StatefulWidget {
  const ExpensePage({super.key});

  @override
  State<ExpensePage> createState() => _ExpensePageState();
}

class _ExpensePageState extends State<ExpensePage> {
  void navigateWithAnimation({
    required Widget child,
    required BuildContext ctx,
  }) {
    Navigator.push(
      ctx,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => child,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, 1.0);
          const end = Offset.zero;
          final tween = Tween(begin: begin, end: end);
          final _ = animation.drive(tween);
          return ScaleTransition(scale: animation, child: child);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      floatingActionButton: GestureDetector(
        onTap: () {
          navigateWithAnimation(child: ExpenseGate(), ctx: context);
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: theme.colorScheme.secondary,
            boxShadow: [
              BoxShadow(
                offset: Offset(2, 2),
                blurRadius: 0,
                color: theme.colorScheme.onSurface,
              ),
            ],
          ),
          child: Text(
            "Add Expense/Income",
            style: theme.textTheme.titleSmall?.copyWith(
              color: theme.colorScheme.onSecondary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        scrolledUnderElevation: 0,
        actions: [
          Consumer(
            builder: (context, ref, child) {
              final inDarkMode = ref.watch(themeNotifierProvider);
              return IconButton(
                icon: Icon(
                  inDarkMode ? Icons.sunny : Icons.dark_mode,
                  color: theme.colorScheme.primary,
                ),
                onPressed: () {
                  ref.read(themeNotifierProvider.notifier).toggleThemeMode();
                },
              );
            },
          ),
        ],
        title: const Text('Expense'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Consumer(
                builder: (context, ref, child) {
                  final expenses = ref.watch(expenseProvider);

                  if (expenses.isEmpty) {
                    return Expanded(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.receipt_long,
                              size: 100,
                              color: theme.colorScheme.outline,
                            ),
                            SizedBox(height: 20),
                            Text(
                              "No expenses yet",
                              style: theme.textTheme.titleLarge?.copyWith(
                                color: theme.colorScheme.onSurface,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              "Tap 'Add Expense' to get started",
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: theme.colorScheme.outline,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  return Expanded(
                    child: ListView.builder(
                      itemCount: expenses.length,
                      itemBuilder: (context, index) {
                        final expense = expenses[index];
                        final String date =
                            "${expense.date.day}/${expense.date.month}/${expense.date.year}";
                        final title = expense.title;
                        final category = expense.category;
                        final amount = expense.amount.toStringAsFixed(2);
                        bool isIncome = expense.isIncome;

                        final colorIndex = index % 8;
                        return Dismissible(
                          key: Key(expense.id),
                          direction: DismissDirection.horizontal,
                          confirmDismiss: (direction) async {
                            return await confirmDismiss(
                              expense: expense,
                              ref: ref,
                              context: context,
                            );
                          },
                          background: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Image(
                                fit: BoxFit.cover,
                                image: AssetImage(
                                  'assets/images/background.gif',
                                ),
                              ),
                            ),
                          ),
                          child: GestureDetector(
                            onTap: () {
                              navigateWithAnimation(
                                child: isIncome
                                    ? EditIncomePage(expense: expense)
                                    : EditExpensePage(expense: expense),
                                ctx: context,
                              );
                            },
                            child: ExpenseCard(
                              category: category,
                              title: title,
                              date: date,
                              amount: amount,
                              colorIndex: colorIndex,
                              isIncome: isIncome,
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
