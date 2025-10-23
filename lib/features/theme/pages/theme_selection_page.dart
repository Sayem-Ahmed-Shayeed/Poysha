import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../providers/color_scheme_provider.dart';

class ThemeSelectionPage extends StatelessWidget {
  const ThemeSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<FlexScheme> colorSchemes = FlexScheme.values;

    int crossAxisCount = 4;
    if (1.sw < 600) {
      crossAxisCount = 4;
    } else if (1.sw > 601 && 1.sw < 800) {
      crossAxisCount = 4;
    } else if (1.sw > 801 && 1.sw < 1200) {
      crossAxisCount = 5;
    } else {
      crossAxisCount = 5;
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0,
          centerTitle: true,
          title: Text('Select Theme', style: TextStyle(fontSize: 20)),
        ),
        body: GridView.builder(
          itemCount: colorSchemes.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 2.w,
            mainAxisSpacing: 2.h,
            childAspectRatio: 1,
          ),
          itemBuilder: (context, index) {
            final theme = FlexColorScheme.light(
              scheme: colorSchemes[index],
            ).toTheme;
            return _buildThemeCard(theme, colorSchemes[index]);
          },
        ),
      ),
    );
  }

  Widget _buildThemeCard(ThemeData theme, FlexScheme scheme) {
    return Column(
      children: [
        Consumer(
          builder: (context, ref, child) => GestureDetector(
            onTap: () {
              ref
                  .read(colorSchemeProvider.notifier)
                  .setColorScheme(scheme.name);

              Navigator.of(context).pop();
            },
            child: Container(
              padding: EdgeInsets.all(10.w),
              margin: EdgeInsets.all(1.w),
              decoration: BoxDecoration(
                border: Border.all(
                  color: theme.colorScheme.outline.withValues(alpha: 0.5),
                  width: 0.5.w,
                ),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildColorBox(
                        color: theme.colorScheme.primary,
                        size: 35,
                      ),
                      SizedBox(width: 3.w),
                      _buildColorBox(
                        color: theme.colorScheme.secondary,
                        size: 35,
                      ),
                    ],
                  ),
                  SizedBox(height: 1.h),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildColorBox(
                        color: theme.colorScheme.primaryContainer,
                        size: 35,
                      ),
                      SizedBox(width: 3.w),
                      _buildColorBox(
                        color: theme.colorScheme.tertiary,
                        size: 35,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        Text(
          scheme.name.capitalize,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    ).animate(effects: [FadeEffect(duration: 300.ms)]);
  }

  Widget _buildColorBox({required Color color, required double size}) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(6.r),
      ),
    );
  }
}
