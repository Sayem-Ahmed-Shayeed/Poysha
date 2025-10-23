import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poysha/features/expense/providers/is_date_selecting_provider.dart';
import 'package:poysha/features/expense/providers/selected_date_provider.dart';

class DateControllerTextField extends StatelessWidget {
  const DateControllerTextField({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Consumer(
      builder: (context, ref, child) {
        TextEditingController dateController = TextEditingController();
        final selectedDate = ref.watch(selectedDateProvider);
        final day = selectedDate.day;
        final month = selectedDate.month;
        final year = selectedDate.year;
        dateController.text = "$day/$month/$year";

        return TextFormField(
          controller: dateController,
          readOnly: true,
          decoration: InputDecoration(
            label: Text(label),
            labelStyle: theme.textTheme.titleMedium?.copyWith(
              color: theme.colorScheme.onSurface,
            ),
            fillColor: theme.colorScheme.surface,
            filled: true,
            suffix: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
                ref
                    .read(isDateSelectingProvider.notifier)
                    .toggleIsDateSelecting();
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primaryContainer.withValues(
                    alpha: 0.5,
                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Icon(Icons.calendar_month_outlined, size: 18),
              ),
            ),
            enabled: true,
            enabledBorder: borderDesign(borderColor: theme.colorScheme.outline),
            focusedBorder: borderDesign(borderColor: theme.colorScheme.outline),
            errorBorder: borderDesign(borderColor: theme.colorScheme.error),
          ),
        );
      },
    );
  }
}

InputBorder borderDesign({required Color borderColor}) {
  return OutlineInputBorder(
    borderSide: BorderSide(width: 0.5, color: Colors.transparent),
  );
}
