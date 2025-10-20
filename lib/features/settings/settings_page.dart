import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poysha/features/theme/pages/theme_selection_page.dart';

import '../theme/providers/theme_mode_provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
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
        ],
        title: const Text('Settings'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 8),
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                    color: theme.colorScheme.onSurface,
                    width: 0.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: theme.colorScheme.onSurface,
                      offset: const Offset(2, 2),
                      blurRadius: 0,
                    ),
                  ],
                ),
                child: ListTile(
                  leading: const Icon(Icons.color_lens),
                  title: const Text('Themes'),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ThemeSelectionPage(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
