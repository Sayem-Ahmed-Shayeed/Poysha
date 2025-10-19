import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poysha/features/expense/pages/add_expense_page.dart';
import 'package:poysha/features/expense/pages/edit_expense_page.dart';
import 'package:poysha/features/expense/providers/expense_provider.dart';
import 'package:poysha/features/expense/widgets/expense_card.dart';
import 'package:poysha/features/settings/settings_page.dart';
import 'package:poysha/features/theme/providers/theme_mode_provider.dart';

import '../helpers/dismissble_widget_helper.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
          final offsetAnimation = animation.drive(tween);
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
          navigateWithAnimation(child: AddExpensePage(), ctx: context);
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
            "Add Expense",
            style: theme.textTheme.titleSmall?.copyWith(
              color: theme.colorScheme.onSecondary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      appBar: AppBar(
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
          IconButton(
            icon: Icon(Icons.settings, color: theme.colorScheme.primary),
            onPressed: () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (context) => SettingsPage()));
            },
          ),
        ],
        title: const Text('Expense Tracker'),
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
                            child: Image(
                              fit: BoxFit.cover,
                              image: AssetImage('assets/images/background.gif'),
                            ),
                          ),
                          child: GestureDetector(
                            onTap: () {
                              navigateWithAnimation(
                                child: EditExpensePage(expense: expense),
                                ctx: context,
                              );
                            },
                            child: ExpenseCard(
                              category: category,
                              title: title,
                              date: date,
                              amount: amount,
                              colorIndex: colorIndex,
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
