import 'package:poysha/features/expense/model/expense.dart';

class SummaryState {
  final bool isLoading;
  final String selectedTimeFrame;
  final bool ascending;
  final Map<String, List<Expense>> groupedExpenses;
  final Map<String, Map<String, double>> categoryBreakdown;
  final Map<String, double> totals;

  SummaryState({
    this.isLoading = false,
    this.selectedTimeFrame = 'Daily',
    this.ascending = false,
    this.groupedExpenses = const {},
    this.categoryBreakdown = const {},
    this.totals = const {},
  });

  SummaryState copyWith({
    bool? isLoading,
    String? selectedTimeFrame,
    bool? ascending,
    Map<String, List<Expense>>? groupedExpenses,
    Map<String, Map<String, double>>? categoryBreakdown,
    Map<String, double>? totals,
  }) {
    return SummaryState(
      isLoading: isLoading ?? this.isLoading,
      selectedTimeFrame: selectedTimeFrame ?? this.selectedTimeFrame,
      ascending: ascending ?? this.ascending,
      groupedExpenses: groupedExpenses ?? this.groupedExpenses,
      categoryBreakdown: categoryBreakdown ?? this.categoryBreakdown,
      totals: totals ?? this.totals,
    );
  }
}
