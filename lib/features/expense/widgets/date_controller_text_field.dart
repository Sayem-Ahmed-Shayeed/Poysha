import 'package:flutter/material.dart';

class DateControllerTextField extends StatelessWidget {
  DateControllerTextField({
    super.key,
    required this.label,
    required this.controller,
    required this.onSelectingDate,
  });

  final String label;
  TextEditingController controller = TextEditingController();

  final VoidCallback onSelectingDate;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        label: Text(label),
        labelStyle: theme.textTheme.titleMedium?.copyWith(
          color: theme.colorScheme.onSurface,
        ),
        fillColor: theme.colorScheme.surface,
        filled: true,
        suffix: GestureDetector(
          onTap: () => onSelectingDate(),
          
          child: const Icon(Icons.calendar_month_outlined, size: 18),
        ),
        enabled: true,
        enabledBorder: borderDesign(borderColor: theme.colorScheme.outline),
        focusedBorder: borderDesign(borderColor: theme.colorScheme.outline),
        errorBorder: borderDesign(borderColor: theme.colorScheme.error),
      ),
    );
  }
}

InputBorder borderDesign({required Color borderColor}) {
  return OutlineInputBorder(
    borderSide: BorderSide(width: 0.5, color: Colors.transparent),
  );
}
