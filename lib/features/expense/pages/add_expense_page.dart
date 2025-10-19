import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poysha/features/expense/model/expense.dart';
import 'package:poysha/features/expense/widgets/custom_snackbar.dart';
import 'package:poysha/features/expense/widgets/custom_text_field.dart';
import 'package:poysha/features/expense/widgets/retro_date_picker.dart';
import 'package:poysha/features/expense/widgets/title_text.dart';
import 'package:uuid/uuid.dart';

import '../providers/expense_provider.dart';
import '../widgets/date_controller_text_field.dart';

class AddExpensePage extends StatefulWidget {
  const AddExpensePage({super.key});

  @override
  State<AddExpensePage> createState() => _AddExpensePageState();
}

class _AddExpensePageState extends State<AddExpensePage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();

  final DateTime selectedDate = DateTime.now();
  String selectedCategory = "Others";

  var isDateSelecting = false;
  var isMinimized = false;
  bool isAdding = true;

  bool income = true;

  void toggleSelectingDate() {
    FocusScope.of(context).unfocus();
    setState(() {
      isDateSelecting = !isDateSelecting;
    });
  }

  List<String> expenseCategories = [
    'Food',
    'Groceries',
    'Transport',
    'Entertainment',
    'Bills',
    'Shopping / Clothing',
    'Health / Medical',
    'Education / Learning',
    'Travel / Vacation',
    'Subscriptions',
    'Gifts / Charity',
    'Home / Maintenance',
    'Insurance',
    'Savings / Investment',
    'Others',
  ];

  @override
  void dispose() {
    titleController.dispose();
    amountController.dispose();
    dateController.dispose();
    categoryController.dispose();
    super.dispose();
  }

  void saveExpense({required WidgetRef ref}) {
    final title = titleController.text.trim();
    final amount = double.tryParse(amountController.text);
    final selectedDate = this.selectedDate;
    if (title.isEmpty) {
      customSnackBar(context: context, message: 'Please enter a title');
      return;
    } else if (amount == null || amount <= 0) {
      customSnackBar(context: context, message: 'Please enter a valid amount');
      return;
    }
    setState(() {
      isAdding = true;
    });
    ref
        .read(expenseProvider.notifier)
        .addExpense(
          Expense(
            id: Uuid().v4(),
            title: title,
            amount: amount ?? 0,
            date: selectedDate,
            category: selectedCategory,
          ),
        );
    if (mounted) {
      setState(() {
        isAdding = false;
      });
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: Text('Add Expense'),
      ),
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.tertiaryFixed,
                    border: Border.all(color: theme.colorScheme.outline),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: theme.colorScheme.onSurface,
                              offset: const Offset(2, 2),
                              blurRadius: 0,
                            ),
                          ],
                          color: theme.colorScheme.surface,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: CustomTextField(
                          controller: titleController,
                          validator: null,
                          label: "Title",
                          hintText: "e.g. Grocery",
                          isObscure: null,
                          toggle: null,
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: theme.colorScheme.onSurface,
                              offset: const Offset(2, 2),
                              blurRadius: 0,
                            ),
                          ],
                          color: theme.colorScheme.surface,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: DateControllerTextField(
                          label: 'Date',
                          controller: dateController,
                          onSelectingDate: toggleSelectingDate,
                        ),
                      ),
                      SizedBox(height: 10),
                      TitleText(title: "Category"),
                      SizedBox(height: 5),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          boxShadow: [
                            BoxShadow(
                              color: theme.colorScheme.onSurface,
                              offset: const Offset(2, 2),
                              blurRadius: 0,
                            ),
                          ],
                          color: theme.colorScheme.surface,
                        ),
                        child: DropdownButton(
                          elevation: 0,
                          borderRadius: BorderRadius.circular(0),
                          underline: SizedBox(),
                          dropdownColor: theme.colorScheme.surface,
                          value: selectedCategory,
                          isExpanded: true,
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: theme.colorScheme.onSurface,
                          ),
                          items: [
                            for (var category in expenseCategories)
                              DropdownMenuItem(
                                value: category,
                                child: Text(category),
                              ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              selectedCategory = value!;
                            });
                          },
                        ),
                      ),
                      SizedBox(height: 10),
                      TitleText(title: "Amount"),
                      SizedBox(height: 10),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: theme.colorScheme.onSurface,
                              offset: const Offset(2, 2),
                              blurRadius: 0,
                            ),
                          ],
                          color: theme.colorScheme.surface,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: CustomTextField(
                          controller: amountController,
                          validator: null,
                          label: "Amount",
                          hintText: "e.g. 500",
                          isObscure: null,
                          toggle: null,
                        ),
                      ),
                      SizedBox(height: 20),
                      Consumer(
                        builder: (context, ref, child) {
                          return Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              boxShadow: [
                                BoxShadow(
                                  color: theme.colorScheme.onSurface,
                                  offset: const Offset(2, 2),
                                  blurRadius: 0,
                                ),
                              ],
                              color: theme.colorScheme.surface,
                            ),
                            width: double.infinity,
                            child: CupertinoButton(
                              padding: EdgeInsets.zero,
                              onPressed: () {
                                saveExpense(ref: ref);
                              },
                              child: Text(
                                'Save Expense',
                                style: theme.textTheme.titleMedium?.copyWith(
                                  color: theme.colorScheme.onSurface,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ],
            ),
            if (isDateSelecting)
              Center(
                child: RetroDatePickerDialog(
                  controller: dateController,
                  onClosing: toggleSelectingDate,
                  pickedDate: selectedDate,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
