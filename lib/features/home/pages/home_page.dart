import 'package:flutter/material.dart';
import 'package:poysha/features/settings/pages/settings_page.dart';

import '../../expense/pages/expense_page.dart';
import '../../summary/pages/summary_page.dart';

class HomePage extends StatelessWidget {
  final List<List<dynamic>> tabs = [
    ['Home', Icons.money_off],
    ['Summary', Icons.bar_chart],
    ['More', Icons.more_horiz],
  ];

  List<Widget> get tabViews => [ExpensePage(), SummaryPage(), SettingsPage()];

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DefaultTabController(
      length: tabs.length,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: theme.colorScheme.surfaceContainerLowest,
          body: TabBarView(physics: ScrollPhysics(), children: [...tabViews]),
          bottomNavigationBar: TabBar(
            labelColor: theme.colorScheme.primary,
            unselectedLabelColor: theme.colorScheme.outline,
            indicatorColor: theme.colorScheme.primary,
            indicatorSize: TabBarIndicatorSize.label,
            dividerColor: theme.colorScheme.surface,
            tabs: tabs.map((tab) {
              return Tab(text: tab[0], icon: Icon(tab[1]));
            }).toList(),
          ),
        ),
      ),
    );
  }
}
