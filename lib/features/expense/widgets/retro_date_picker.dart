import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RetroDatePickerDialog extends StatefulWidget {
  final TextEditingController controller;
  final VoidCallback onClosing;

  const RetroDatePickerDialog({
    super.key,
    required this.controller,
    required this.onClosing,
  });

  @override
  State<RetroDatePickerDialog> createState() => _RetroDatePickerDialogState();
}

class _RetroDatePickerDialogState extends State<RetroDatePickerDialog> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final inDarkMode = theme.brightness == Brightness.dark;
    return Center(
      child: Container(
        width: 700.w,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: inDarkMode
              ? theme.colorScheme.onTertiaryFixed
              : theme.colorScheme.tertiaryFixed,
          border: Border.all(color: theme.colorScheme.onSurface, width: 1),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _RetroButton(
                  text: '–',
                  color: Colors.green,
                  onPressed: () {
                    widget.onClosing();
                  },
                ),
                const SizedBox(width: 10),
                _RetroButton(
                  text: 'X',
                  color: Colors.red,
                  onPressed: () {
                    widget.onClosing();
                  },
                ),
              ],
            ),
            Text(
              'Select Date',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onTertiaryFixed,
              ),
            ),
            const SizedBox(height: 16),
            CalendarDatePicker(
              initialDate: selectedDate,
              firstDate: DateTime(2000),
              lastDate: DateTime(2101),
              onDateChanged: (date) {
                setState(() => selectedDate = date);
              },
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _RetroButton(
                  text: 'Cancel',
                  color: Colors.grey,
                  onPressed: () {
                    widget.onClosing();
                  },
                ),
                const SizedBox(width: 10),
                _RetroButton(
                  text: 'Confirm',
                  color: Colors.yellow,
                  onPressed: () {
                    widget.controller.text =
                        "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}";
                    widget.onClosing();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _RetroButton extends StatelessWidget {
  final String text;
  final Color color;
  final VoidCallback onPressed;

  const _RetroButton({
    required this.text,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: color,
          border: Border.all(color: theme.colorScheme.onSurface, width: 1),
          boxShadow: [
            BoxShadow(
              color: theme.colorScheme.onSurface,
              offset: const Offset(2, 2),
              blurRadius: 0,
            ),
          ],
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontFamily: 'JetBrainsMono',
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
