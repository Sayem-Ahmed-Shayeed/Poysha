import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poysha/features/expense/model/expense.dart';
import 'package:poysha/features/expense/widgets/custom_snackbar.dart';
import 'package:poysha/features/expense/widgets/custom_text_field.dart';
import 'package:poysha/features/expense/widgets/retro_date_picker.dart';
import 'package:poysha/features/expense/widgets/title_text.dart';

import '../../consts/categories.dart';
import '../../providers/expense_provider.dart';
import '../../providers/is_date_selecting_provider.dart';
import '../../providers/selected_date_provider.dart';
import '../../widgets/date_controller_text_field.dart';

class EditIncomePage extends StatefulWidget {
  const EditIncomePage({super.key, required this.expense});

  final Expense expense;

  @override
  State<EditIncomePage> createState() => _EditIncomePageState();
}

class _EditIncomePageState extends State<EditIncomePage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();

  final DateTime selectedDate = DateTime.now();
  String selectedCategory = "Salary";

  var isDateSelecting = false;
  var isMinimized = false;
  bool isAdding = true;

  bool income = true;

  @override
  void initState() {
    loadExpenseDetails();
    super.initState();
  }

  void loadExpenseDetails() {
    final expense = widget.expense;
    titleController.text = expense.title;
    amountController.text = expense.amount.toString();
    dateController.text =
        "${expense.date.day}/${expense.date.month}/${expense.date.year}";
    selectedCategory = expense.category;
  }

  @override
  void dispose() {
    titleController.dispose();
    amountController.dispose();
    dateController.dispose();
    categoryController.dispose();
    super.dispose();
  }

  void updateExpense({required WidgetRef ref}) {
    final title = titleController.text.trim();
    final amount = double.tryParse(amountController.text);
    final selectedDate = ref.watch(selectedDateProvider);
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
        .updateExpense(
          Expense(
            id: widget.expense.id,
            title: title,
            amount: amount,
            date: selectedDate,
            category: selectedCategory,
            isIncome: true,
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
      backgroundColor: theme.colorScheme.surfaceContainerLowest,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.surfaceContainerLowest,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: Text(widget.expense.title),
      ),
      body: Stack(
        alignment: Alignment.center,
        fit: StackFit.expand,
        children: [
          SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 50),
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
                          hintText: "e.g. Salary",
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
                        child: DateControllerTextField(label: 'Date'),
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
                            for (var category in incomeCategories)
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
                      TitleText(title: "Income Amount"),
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
                                updateExpense(ref: ref);
                              },
                              child: Text(
                                'Update Income',
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
          ),
          Consumer(
            builder: (context, ref, child) {
              isDateSelecting = ref.watch(isDateSelectingProvider);

              if (isDateSelecting) {
                return Center(child: RetroDatePickerDialog());
              }
              return SizedBox();
            },
          ),
        ],
      ),
    );
  }
}
