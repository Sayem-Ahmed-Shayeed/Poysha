import 'package:flutter/material.dart';

void customSnackBar({required BuildContext context, required String message}) {
  final scaffoldMessenger = ScaffoldMessenger.of(context);
  scaffoldMessenger.clearSnackBars();
  scaffoldMessenger.showSnackBar(
    SnackBar(behavior: SnackBarBehavior.floating, content: Text(message)),
  );
}
