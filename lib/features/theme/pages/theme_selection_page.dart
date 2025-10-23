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

    int getCrossAxisCount() {
      final width = MediaQuery.of(context).size.width;
      if (width < 360) return 3;
      if (width < 600) return 4;
      if (width < 900) return 5;
      return 6;
    }

    int crossAxisCount = getCrossAxisCount();
    final theme = Theme.of(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: theme.colorScheme.surfaceContainerLowest,
        appBar: AppBar(
          backgroundColor: theme.colorScheme.surfaceContainerLowest,
          scrolledUnderElevation: 0,
          centerTitle: true,
          title: Text('Select Theme'),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
          child: GridView.builder(
            itemCount: colorSchemes.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 8.w,
              mainAxisSpacing: 8.h,
              childAspectRatio: 0.85,
            ),
            itemBuilder: (context, index) {
              final theme = FlexColorScheme.light(
                scheme: colorSchemes[index],
              ).toTheme;
              return _buildThemeCard(theme, colorSchemes[index]);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildThemeCard(ThemeData theme, FlexScheme scheme) {
    return Column(
      children: [
        Expanded(
          child: Consumer(
            builder: (context, ref, child) => GestureDetector(
              onTap: () {
                ref
                    .read(colorSchemeProvider.notifier)
                    .setColorScheme(scheme.name);

                Navigator.of(context).pop();
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.w),
                margin: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: theme.colorScheme.outline.withValues(alpha: 0.5),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(5.r),
                ),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final boxSize = (constraints.maxWidth - 12.w) / 2.1;

                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildColorBox(
                              color: theme.colorScheme.primary,
                              size: boxSize,
                            ),
                            SizedBox(width: 2.w),
                            _buildColorBox(
                              color: theme.colorScheme.secondary,
                              size: boxSize,
                            ),
                          ],
                        ),
                        SizedBox(height: 1.5.h),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildColorBox(
                              color: theme.colorScheme.primaryContainer,
                              size: boxSize,
                            ),
                            SizedBox(width: 2.w),
                            _buildColorBox(
                              color: theme.colorScheme.tertiary,
                              size: boxSize,
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.w),
          child: Text(
            scheme.name.capitalize,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        SizedBox(height: 1.h),
      ],
    ).animate(effects: [FadeEffect(duration: 300.ms)]);
  }

  Widget _buildColorBox({required Color color, required double size}) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(2.r),
      ),
    );
  }
}
