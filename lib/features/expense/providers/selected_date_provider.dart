import 'package:flutter_riverpod/legacy.dart';

class SelectedDateProviderNotifier extends StateNotifier<DateTime> {
  SelectedDateProviderNotifier() : super(DateTime.now());

  void setDate(DateTime selectedDate) {
    state = selectedDate;
  }
}

final selectedDateProvider =
    StateNotifierProvider<SelectedDateProviderNotifier, DateTime>((ref) {
      return SelectedDateProviderNotifier();
    });
