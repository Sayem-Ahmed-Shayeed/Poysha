import 'package:flutter/material.dart';
import 'package:poysha/features/expense/pages/expense_pages/add_expense_page.dart';
import 'package:poysha/features/expense/pages/income_pages/add_income_page.dart';

class ExpenseGate extends StatelessWidget {
  ExpenseGate({super.key});

  List<Widget> pages = [AddExpensePage(), AddIncomePage()];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: pages.length,
      child: SafeArea(
        child: Scaffold(
          bottomNavigationBar: TabBar(
            tabs: [
              Tab(text: 'Expense', icon: Icon(Icons.money_off)),
              Tab(text: 'Income', icon: Icon(Icons.attach_money_outlined)),
            ],
            labelColor: Theme.of(context).colorScheme.primary,
            unselectedLabelColor: Theme.of(context).colorScheme.outline,
            indicatorColor: Theme.of(context).colorScheme.primary,
            indicatorSize: TabBarIndicatorSize.label,
            dividerColor: Theme.of(context).colorScheme.surface,
          ),
          body: TabBarView(children: [...pages]),
        ),
      ),
    );
  }
}
