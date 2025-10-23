import 'package:flutter_riverpod/legacy.dart';

class IsDateSelectingProviderNotifier extends StateNotifier<bool> {
  IsDateSelectingProviderNotifier() : super(false);

  void toggleIsDateSelecting() {
    state = !state;
  }
}

final isDateSelectingProvider =
    StateNotifierProvider<IsDateSelectingProviderNotifier, bool>((ref) {
      return IsDateSelectingProviderNotifier();
    });
