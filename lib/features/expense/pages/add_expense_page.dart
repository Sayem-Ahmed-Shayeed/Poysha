import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:poysha/features/expense/widgets/custom_text_field.dart';
import 'package:poysha/features/expense/widgets/retro_date_picker.dart';
import 'package:poysha/features/expense/widgets/title_text.dart';

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
  var isDateSelecting = false;
  var isMinimized = false;

  bool income = true;
  String selectedCategory = 'Food';

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
                          color: theme.colorScheme.surfaceContainerHighest,
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
                          color: theme.colorScheme.surfaceContainerHighest,
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
                          color: theme.colorScheme.surfaceContainerHighest,
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
                          color: theme.colorScheme.surfaceContainerHighest,
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
                          color: theme.colorScheme.surfaceContainerHighest,
                        ),
                        width: double.infinity,
                        child: CupertinoButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {},
                          child: Text(
                            'Save Expense',
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: theme.colorScheme.onSurface,
                            ),
                          ),
                        ),
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
                ),
              ),
          ],
        ),
      ),
    );
  }
}
