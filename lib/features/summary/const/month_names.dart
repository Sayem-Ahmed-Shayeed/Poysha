import 'package:flutter/material.dart';

List<String> months = [
  'January',
  'February',
  'March',
  'April',
  'May',
  'June',
  'July',
  'August',
  'September',
  'October',
  'November',
  'December',
];

Color getColorForCategory(String category) {
  final colors = {
    'Food': Colors.orange,
    'Groceries': Colors.lightGreen,
    'Transport': Colors.blue,
    'Entertainment': Colors.purple,
    'Bills': Colors.red,
    'Shopping / Clothing': Colors.pink,
    'Health / Medical': Colors.green,
    'Education / Learning': Colors.indigo,
    'Travel / Vacation': Colors.cyan,
    'Subscriptions': Colors.deepPurple,
    'Gifts / Charity': Colors.amber,
    'Home / Maintenance': Colors.brown,
    'Insurance': Colors.blueGrey,
    'Savings / Investment': Colors.teal,
    'Others': Colors.grey,
  };
  return colors[category] ?? Colors.redAccent;
}
