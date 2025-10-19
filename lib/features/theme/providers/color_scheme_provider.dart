import 'package:flutter_riverpod/legacy.dart';
import 'package:hive/hive.dart';

class ColorSchemeNotifier extends StateNotifier<String> {
  ColorSchemeNotifier() : super('blackWhite') {
    state = _loadInitialScheme();
  }

  void setColorScheme(String schemeName) {
    state = schemeName;

    final Box<String> colorSchemeBox = Hive.box<String>('colorSchemeBox');
    colorSchemeBox.put('currentScheme', schemeName);
  }

  String _loadInitialScheme() {
    final Box<String> colorSchemeBox = Hive.box<String>('colorSchemeBox');
    return colorSchemeBox.get('currentScheme') ?? "blackWhite";
  }
}

final colorSchemeProvider = StateNotifierProvider<ColorSchemeNotifier, String>((
  ref,
) {
  return ColorSchemeNotifier();
});
