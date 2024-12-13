import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

class NewExpense extends StatefulWidget {
  final Function(Expense) onAddExpense;

  const NewExpense({required this.onAddExpense, super.key});

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  Category _selectedCategory = Category.food;
  DateTime _selectedDate = DateTime.now();

  void _submitExpense() {
    final enteredTitle = _titleController.text;
    final enteredAmount = double.tryParse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount == null || enteredAmount <= 0) {
      return;
    }

    final newExpense = Expense(
      title: enteredTitle,
      amount: enteredAmount,
      date: _selectedDate,
      category: _selectedCategory,
    );

    widget.onAddExpense(newExpense);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 16,
        left: 16,
        right: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(labelText: 'Title'),
          ),
          TextField(
            controller: _amountController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Amount'),
          ),
          DropdownButton<Category>(
            value: _selectedCategory,
            onChanged: (newValue) {
              setState(() {
                _selectedCategory = newValue!;
              });
            },
            items: Category.values
                .map((cat) => DropdownMenuItem(
                      value: cat,
                      child: Text(cat.name),
                    ))
                .toList(),
          ),
          ElevatedButton(
            onPressed: _submitExpense,
            child: const Text('Add Expense'),
          ),
        ],
      ),
    );
  }
}
