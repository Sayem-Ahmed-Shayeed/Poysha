import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:poysha/features/expense/providers/expense_provider.dart';
import 'package:poysha/features/summary/helpers/calculate_monthly_summary.dart';
import 'package:poysha/features/summary/helpers/calculate_summary.dart';
import 'package:poysha/features/summary/widgets/summary_card.dart';
import 'package:poysha/features/summary/widgets/title_text.dart';

import '../const/month_names.dart';

class SummaryPage extends StatefulWidget {
  const SummaryPage({super.key});

  @override
  State<SummaryPage> createState() => _SummaryPageState();
}

class _SummaryPageState extends State<SummaryPage> {
  final TextEditingController _dateController = TextEditingController();

  String selectedMonth = months[DateTime.now().month];

  //DateTime _pickedDate = DateTime.now();
  // bool isSelectingDate = false;
  //
  // void toggleIsSelectingDate() {
  //   setState(() {
  //     isSelectingDate = !isSelectingDate;
  //   });
  // }
  //
  // void onConfirmDate(DateTime date) {
  //   setState(() {
  //     _pickedDate = date;
  //   });
  //   toggleIsSelectingDate();
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(centerTitle: true, title: Text("Summary")),
        body: Consumer(
          builder: (context, ref, child) {
            final expenses = ref.watch(expenseProvider);
            List<double> summary = calculateSummary(expenses);
            final totalIncome = summary[0];
            final totalExpense = summary[1];

            final remaining = totalIncome - totalExpense;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TitleText(title: "Summary"),
                      SizedBox(height: 5.h),
                      SummaryCard(
                        totalIncome: totalIncome,
                        totalExpense: totalExpense,
                        remaining: remaining,
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TitleText(title: "Monthly Summary"),
                          Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 4,
                              horizontal: 10,
                            ),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primaryContainer,
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
                            child: DropdownButton(
                              underline: SizedBox(),
                              padding: EdgeInsets.zero,
                              value: selectedMonth,
                              isDense: true,
                              items: [
                                for (var month in months)
                                  DropdownMenuItem(
                                    value: month,
                                    child: Text(month),
                                  ),
                              ],
                              onChanged: (value) => setState(() {
                                selectedMonth = value!;
                              }),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5.h),
                      Consumer(
                        builder: (context, ref, child) {
                          final monthlySummary = calculateMonthlySummary(
                            expenses,
                            months.indexOf(selectedMonth),
                          );
                          final monthlyIncome = monthlySummary[0];
                          final monthlyExpense = monthlySummary[1];
                          final monthlyRemaining =
                              monthlyIncome - monthlyExpense;
                          return SummaryCard(
                            totalIncome: monthlyIncome,
                            totalExpense: monthlyExpense,
                            remaining: monthlyRemaining,
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
