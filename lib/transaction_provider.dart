import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'transaction_model.dart';

class TransactionProvider with ChangeNotifier {
  List<Transaction> _transactions = [];

  List<Transaction> get transactions => _transactions;

  TransactionProvider() {
    _loadTransactions();
  }

  // Add a new transaction
  void addTransaction(Transaction transaction) {
    _transactions.add(transaction);
    _saveTransactions();
    notifyListeners();
  }

  // Remove a transaction by ID
  void removeTransaction(String id) {
    _transactions.removeWhere((tx) => tx.id == id);
    _saveTransactions();  // Save the updated list after removing
    notifyListeners();
  }

  // Save transactions to shared preferences
  void _saveTransactions() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> transactionList = _transactions
        .map((transaction) => jsonEncode(transaction.toJson()))
        .toList();
    prefs.setStringList('transactions', transactionList);
  }

  // Load transactions from shared preferences
  void _loadTransactions() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? transactionList = prefs.getStringList('transactions');
    if (transactionList != null) {
      _transactions = transactionList
          .map((transaction) => Transaction.fromJson(jsonDecode(transaction)))
          .toList();
    }
    notifyListeners();
  }
}
