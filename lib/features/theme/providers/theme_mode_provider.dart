import 'package:flutter_riverpod/legacy.dart';
import 'package:hive/hive.dart';

class ThemeNotifier extends StateNotifier<bool> {
  ThemeNotifier() : super(true) {
    state = _loadThemeFromHive();
  }

  bool _loadThemeFromHive() {
    final Box<bool> themeModeBox = Hive.box('themeModeBox');
    return themeModeBox.get('themeMode') ?? true;
  }

  void toggleThemeMode() {
    state = !state;
    final Box<bool> themeModeBox = Hive.box('themeModeBox');
    themeModeBox.put('themeMode', state);
  }
}

final themeNotifierProvider = StateNotifierProvider<ThemeNotifier, bool>((ref) {
  return ThemeNotifier();
});
