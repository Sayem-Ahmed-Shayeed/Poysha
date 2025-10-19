import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poysha/features/expense/pages/add_expense_page.dart';
import 'package:poysha/features/settings/settings_page.dart';
import 'package:poysha/features/theme/providers/theme_mode_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
            shape: BoxShape.rectangle,
            color: theme.colorScheme.secondary,
          ),
          child: Text(
            "Add Expense",
            style: theme.textTheme.titleSmall?.copyWith(
              color: theme.colorScheme.onSecondary,
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
        child: Consumer(
          builder: (context, ref, child) => Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome to Expense Tracker!',
                  style: theme.textTheme.headlineSmall,
                ),
                Text(
                  'Track your expenses and manage your budget effectively.',
                  style: theme.textTheme.bodyLarge,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
