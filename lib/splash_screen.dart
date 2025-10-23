import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:poysha/features/home/pages/home_page.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final splashContent = Center(
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(child: SizedBox()),
            Image.asset(
              fit: BoxFit.cover,
              'assets/images/splash.gif',
              width: 200.w,
            ).animate(
              effects: [
                FadeEffect(duration: 800.ms),
                SlideEffect(
                  begin: Offset(0, -0.3),
                  curve: Curves.easeOutCubic,
                  duration: 800.ms,
                ),
              ],
            ),
            SizedBox(height: 2.h),
            Expanded(
              child: Column(
                children: [
                  Text(
                        'Expense',
                        style: theme.textTheme.headlineMedium?.copyWith(
                          letterSpacing: 6,
                          color: Colors.white,
                        ),
                      )
                      .animate()
                      .fadeIn(duration: 800.ms, delay: 300.ms)
                      .slideY(begin: 0.3, curve: Curves.easeOutCubic)
                      .then(delay: 300.ms)
                      .shimmer(duration: 1500.ms, color: Colors.pink),
                  SizedBox(height: 2.h),
                  Text(
                    'Track Your Expenses Effortlessly',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1.2,
                    ),
                  ).animate().scale(duration: 500.ms, delay: 300.ms),
                ],
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Sayem Ahmed Shayeed. All rights reserved.',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: Colors.white.withOpacity(0.6),
                    ),
                  ).animate().fadeIn(duration: 800.ms, delay: 1200.ms),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );

    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff2D5299),
        body: AnimatedSplashScreen(
          splashIconSize: double.infinity,
          splash: splashContent,
          nextScreen: HomePage(),
          splashTransition: SplashTransition.fadeTransition,
          backgroundColor: Colors.transparent,
        ),
      ),
    );
  }
}
