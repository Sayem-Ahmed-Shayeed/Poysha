import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({
    super.key,
    required this.validator,
    required this.label,
    required this.hintText,
    required this.isObscure,
    required this.toggle,
    required this.controller,
  });

  final String? Function(String?)? validator;
  final String label;
  final String hintText;
  final bool? isObscure;
  final void Function()? toggle;
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextFormField(
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
        label: Text(label),
        labelStyle: theme.textTheme.titleMedium?.copyWith(
          color: theme.colorScheme.onSurface,
        ),
        fillColor: theme.colorScheme.surface,
        filled: true,
        suffix: (isObscure != null)
            ? IconButton(
                onPressed: toggle,
                icon: Icon(
                  isObscure!
                      ? Icons.remove_red_eye
                      : Icons.visibility_off_outlined,
                ),
              )
            : null,
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
    borderSide: BorderSide(width: 0, color: Colors.transparent),
  );
}
