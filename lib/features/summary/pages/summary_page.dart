// 4. Update the SummaryPage: lib/features/summary/pages/summary_page.dart

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:poysha/features/expense/providers/expense_provider.dart';
import 'package:poysha/features/summary/providers/summary_provider.dart';
import 'package:poysha/features/summary/widgets/category_breakdown_widget.dart';
import 'package:poysha/features/summary/widgets/summary_card.dart';
import 'package:poysha/features/summary/widgets/title_text.dart';

import '../../theme/providers/theme_mode_provider.dart';
import '../widgets/empty_state.dart';

class SummaryPage extends ConsumerStatefulWidget {
  const SummaryPage({super.key});

  @override
  ConsumerState<SummaryPage> createState() => _SummaryPageState();
}

class _SummaryPageState extends ConsumerState<SummaryPage> {
  String selectedTimeFrame = 'Daily';
  bool ascending = false;
  List<String> timeFrames = ['Daily', 'Weekly', 'Monthly', 'Yearly', 'All'];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadSummary();
    });
  }

  void _loadSummary() {
    final expenses = ref.read(expenseProvider);
    ref
        .read(summaryProvider.notifier)
        .calculateSummary(
          expenses: expenses,
          timeFrame: selectedTimeFrame,
          ascending: ascending,
        );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final summaryState = ref.watch(summaryProvider);
    final _ = ref.watch(expenseProvider);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
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
                ).animate(
                  effects: [
                    ScaleEffect(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                      delay: Duration.zero,
                    ),
                  ],
                );
              },
            ),
          ],
          scrolledUnderElevation: 0,
          centerTitle: true,
          title: const Text("Summary"),
        ),
        body: summaryState.isLoading
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CupertinoActivityIndicator(radius: 20),
                    SizedBox(height: 10.h),
                    Text(
                      'Calculating $selectedTimeFrame Summary...',
                      style: theme.textTheme.bodyMedium,
                    ),
                  ],
                ),
              )
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          _buildTimeFrameWidget(theme: theme),
                          SizedBox(width: 15.w),
                          _buildSortedWidget(theme: theme),
                        ],
                      ).animate(
                        effects: [
                          FadeEffect(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                          ),
                          SlideEffect(
                            begin: const Offset(0, -0.5),
                            end: Offset.zero,
                            curve: Curves.easeInOut,
                            duration: Duration(milliseconds: 500),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h),

                      if (summaryState.groupedExpenses.isEmpty)
                        buildEmptyState(theme)
                      else
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: summaryState.groupedExpenses.length,
                          itemBuilder: (context, index) {
                            final entries = summaryState.groupedExpenses.entries
                                .toList();
                            final key = entries[index].key;
                            // final expenseList = entries[index].value;
                            final categoryBreakdown =
                                summaryState.categoryBreakdown[key] ?? {};

                            final totalIncome =
                                summaryState.totals['${key}_income'] ?? 0;
                            final totalExpense =
                                summaryState.totals['${key}_expense'] ?? 0;
                            final remaining =
                                summaryState.totals['${key}_remaining'] ?? 0;

                            return Container(
                              margin: EdgeInsets.only(bottom: 20.h),
                              padding: EdgeInsets.all(25.w),
                              decoration: BoxDecoration(
                                color: theme.colorScheme.surface,
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(
                                    color: theme.colorScheme.onSurface,
                                    offset: const Offset(0.1, 2),
                                    blurRadius: 0,
                                  ),
                                ],
                                border: Border.all(
                                  color: theme.colorScheme.onSurface
                                      .withOpacity(0.1),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TitleText(title: key).animate(
                                    effects: [
                                      FadeEffect(
                                        duration: Duration(milliseconds: 500),
                                        curve: Curves.easeInOut,
                                      ),
                                      SlideEffect(
                                        begin: const Offset(0, -0.3),
                                        end: Offset.zero,
                                        curve: Curves.easeInOut,
                                        duration: Duration(milliseconds: 500),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5.h),

                                  SummaryCard(
                                    totalIncome: totalIncome,
                                    totalExpense: totalExpense,
                                    remaining: remaining,
                                  ).animate(
                                    effects: [
                                      FadeEffect(
                                        duration: Duration(milliseconds: 500),
                                        curve: Curves.easeInOut,
                                      ),
                                      SlideEffect(
                                        begin: const Offset(0, 0.3),
                                        end: Offset.zero,
                                        curve: Curves.easeInOut,
                                        duration: Duration(milliseconds: 500),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10.h),
                                  if (categoryBreakdown.isNotEmpty) ...[
                                    TitleText(
                                      title: "Category Breakdown",
                                    ).animate(
                                      effects: [
                                        FadeEffect(
                                          duration: Duration(milliseconds: 500),
                                          curve: Curves.easeInOut,
                                        ),
                                        SlideEffect(
                                          begin: const Offset(0, -0.3),
                                          end: Offset.zero,
                                          curve: Curves.easeInOut,
                                          duration: Duration(milliseconds: 500),
                                        ),
                                      ],
                                    ),

                                    Divider(
                                      color: theme.colorScheme.onSurface
                                          .withOpacity(0.8),
                                      thickness: 0.5,
                                      indent: 0.w,
                                      endIndent: 280.w,
                                    ),
                                    CategoryBreakdownWidget(
                                      categoryPercentages: categoryBreakdown,
                                    ).animate(
                                      effects: [
                                        FadeEffect(
                                          duration: Duration(milliseconds: 500),
                                          curve: Curves.easeInOut,
                                        ),
                                        SlideEffect(
                                          begin: const Offset(0, 0.3),
                                          end: Offset.zero,
                                          curve: Curves.easeInOut,
                                          duration: Duration(milliseconds: 500),
                                        ),
                                      ],
                                    ),
                                  ] else
                                    Center(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                          vertical: 10.h,
                                        ),
                                        child: Text(
                                          'No expenses in this period',
                                          style: theme.textTheme.bodyMedium
                                              ?.copyWith(
                                                color: theme
                                                    .colorScheme
                                                    .onSurface
                                                    .withOpacity(0.6),
                                              ),
                                        ),
                                      ),
                                    ).animate(
                                      effects: [
                                        FadeEffect(
                                          duration: Duration(milliseconds: 500),
                                          curve: Curves.easeInOut,
                                        ),
                                        ScaleEffect(
                                          end: Offset.zero,
                                          curve: Curves.easeInOut,
                                          duration: Duration(milliseconds: 500),
                                        ),
                                      ],
                                    ),
                                ],
                              ),
                            );
                          },
                        ),

                      SizedBox(height: 20.h),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  Widget _buildTimeFrameWidget({required ThemeData theme}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: theme.colorScheme.onSurface, width: 0.5),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.onSurface,
            offset: const Offset(2, 2),
            blurRadius: 0,
          ),
        ],
      ),
      child: DropdownButton<String>(
        elevation: 0,
        borderRadius: BorderRadius.circular(4),
        underline: const SizedBox(),
        padding: EdgeInsets.zero,
        value: selectedTimeFrame,
        isDense: true,
        items: [
          for (var timeFrame in timeFrames)
            DropdownMenuItem(value: timeFrame, child: Text(timeFrame)),
        ],
        onChanged: (value) {
          setState(() {
            selectedTimeFrame = value!;
          });
          _loadSummary();
        },
      ),
    );
  }

  Widget _buildSortedWidget({required ThemeData theme}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: theme.colorScheme.onSurface, width: 0.5),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.onSurface,
            offset: const Offset(2, 2),
            blurRadius: 0,
          ),
        ],
      ),
      child: DropdownButton<bool>(
        elevation: 0,
        isDense: true,
        borderRadius: BorderRadius.circular(4),
        underline: const SizedBox(),
        padding: EdgeInsets.zero,
        value: ascending,
        items: const [
          DropdownMenuItem(value: true, child: Text("Ascending")),
          DropdownMenuItem(value: false, child: Text("Descending")),
        ],
        onChanged: (value) {
          setState(() {
            ascending = value!;
          });
          _loadSummary();
        },
      ),
    );
  }
}
