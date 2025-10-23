import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:poysha/features/expense/model/expense.dart';
import 'package:poysha/features/theme/providers/theme_mode_provider.dart';
import 'package:poysha/splash_screen.dart';

import 'features/theme/color_scheme.dart';
import 'features/theme/providers/color_scheme_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(CurrColorSchemeAdapter());
  Hive.registerAdapter(ExpenseAdapter());
  await Hive.openBox<String>('colorSchemeBox');
  await Hive.openBox<bool>('themeModeBox');
  await Hive.openBox('expenseBox');
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.sizeOf(context);
    String currentThemeName = ref.watch(colorSchemeProvider);
    var currTheme = FlexScheme.mango;

    for (var schemes in FlexScheme.values) {
      if (currentThemeName == schemes.name) {
        currTheme = schemes;
      }
    }
    if (kDebugMode) {
      print("Current theme :$currentThemeName");
    }
    final inDarkMode = ref.watch(themeNotifierProvider);

    return ScreenUtilInit(
      designSize: Size(size.height, size.width),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
          theme: FlexThemeData.light(
            fontFamily: 'JetBrains Mono',
            scheme: currTheme,
          ),
          darkTheme: FlexThemeData.dark(
            fontFamily: 'JetBrains Mono',
            scheme: currTheme,
          ),
          themeMode: inDarkMode ? ThemeMode.dark : ThemeMode.light,
          debugShowCheckedModeBanner: false,
          home: child,
        );
      },
      child: SplashScreen(),
    );
  }
}
