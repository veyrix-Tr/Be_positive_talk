import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/transaction_model.dart';

class WalletService {
  static final WalletService _instance = WalletService._internal();
  factory WalletService() => _instance;
  WalletService._internal();

  List<Transaction> _transactions = [];
  int? _currentBalance;

  // Load transactions from JSON file
  Future<void> _loadTransactions() async {
    if (_transactions.isNotEmpty) return;

    try {
      final String jsonString = await rootBundle.loadString(
        'assets/data/transactions.json',
      );
      final Map<String, dynamic> data = json.decode(jsonString);
      final List<dynamic> transactionsList = data['transactions'];

      _transactions = transactionsList.map((json) {
        // Convert JSON to match Transaction model
        final transactionJson = {
          'id': json['id'],
          'userId': json['userId'],
          'type': json['amount'] > 0 ? 'credit' : 'debit',
          'tokens': json['tokens'].abs(),
          'amount': json['amount'].abs(),
          'description': json['description'],
          'createdAt':
              json['timestamp'], // Pass as string, Transaction.fromJson will parse it
        };
        return Transaction.fromJson(transactionJson);
      }).toList();

      // Calculate balance from transactions
      _currentBalance =
          150; // Starting balance (could also be loaded from users.json)
      for (var transaction in _transactions) {
        if (transaction.type == TransactionType.credit) {
          _currentBalance = _currentBalance! + transaction.tokens;
        } else {
          _currentBalance = _currentBalance! - transaction.tokens;
        }
      }
    } catch (e) {
      // Fallback to empty list and default balance if JSON loading fails
      _transactions = [];
      _currentBalance = 150;
    }
  }

  // Get current balance
  Future<int> getBalance() async {
    await _loadTransactions();

    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 400));

    return _currentBalance!;
  }

  // Get transaction history
  Future<List<Transaction>> getTransactions() async {
    await _loadTransactions();

    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 600));

    return _transactions;
  }

  // Purchase tokens
  Future<Transaction> purchaseTokens(int tokens, double amount) async {
    await _loadTransactions();

    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    final newTransaction = Transaction(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      userId: 'user_001',
      type: TransactionType.credit,
      tokens: tokens,
      amount: amount,
      description: 'Token purchase',
      createdAt: DateTime.now(),
    );

    // Update balance
    _currentBalance = _currentBalance! + tokens;

    // Add to transactions
    _transactions.insert(0, newTransaction);

    return newTransaction;
  }

  // Get token packages
  Future<Map<String, dynamic>> getTokenPackages() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 300));

    return {
      'packages': [
        {'tokens': 50, 'price': 5, 'popularBadge': null},
        {'tokens': 100, 'price': 9, 'popularBadge': 'Popular'},
        {'tokens': 200, 'price': 16, 'popularBadge': 'Best Value'},
        {'tokens': 500, 'price': 35, 'popularBadge': null},
      ],
    };
  }

  // Update balance (for internal use)
  void updateBalance(int newBalance) {
    _currentBalance = newBalance;
  }
}
