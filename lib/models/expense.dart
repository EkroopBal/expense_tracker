import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

const uuid = Uuid();
final formatter = DateFormat.yMd();

enum Category {
  food,
  travel,
  leisure,
  work,
}

const categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.flight_takeoff,
  Category.leisure: Icons.movie,
  Category.work: Icons.work,
};

class Expense {
  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  String get formattedDate {
    return formatter.format(date);
  }
}

class ExpenseBucket {
  final Category category;
  final List<Expense> expenses;

  ExpenseBucket({
    required this.category,
    required this.expenses,
  });

  /// Factory constructor to create an ExpenseBucket for a specific category
  /// by filtering the given list of expenses.
  factory ExpenseBucket.forCategory(
      {required Category category, required List<Expense> allExpenses}) {
    final filteredExpenses = allExpenses
        .where((expense) => expense.category == category)
        .toList();
    return ExpenseBucket(category: category, expenses: filteredExpenses);
  }

  /// Calculates the total expenses for the bucket.
  double getTotalExpenses() {
    return expenses.fold(0, (sum, expense) => sum + expense.amount);
  }
}

/// Extension to display category names in a user-friendly way.
extension CategoryExtension on Category {
  String get name {
    switch (this) {
      case Category.food:
        return 'Food';
      case Category.travel:
        return 'Travel';
      case Category.leisure:
        return 'Leisure';
      case Category.work:
        return 'Work';
    }
  }
}
