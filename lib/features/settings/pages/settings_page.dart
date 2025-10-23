import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poysha/features/settings/widgets/settinngs_card.dart';
import 'package:poysha/features/theme/pages/theme_selection_page.dart';

import '../../theme/providers/theme_mode_provider.dart';
import 'clear_data_page.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
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
        title: const Text('Settings'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SettingsCard(
                title: "Themes",
                icon: Icons.color_lens,
                child: ThemeSelectionPage(),
              ),
              SettingsCard(
                title: "Clear All Data",
                icon: Icons.clear_all,
                child: ClearDataPage(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
