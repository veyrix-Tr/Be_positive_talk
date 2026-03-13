import 'dart:async';
import '../models/transaction_model.dart';

class WalletService {
  static final WalletService _instance = WalletService._internal();
  factory WalletService() => _instance;
  WalletService._internal();

  // Mock current balance
  int _currentBalance = 100;

  // Mock transaction history
  final List<Transaction> _mockTransactions = [
    Transaction(
      id: 'txn_1',
      userId: 'user_123',
      type: TransactionType.credit,
      tokens: 100,
      amount: 9.99,
      description: 'Welcome bonus',
      createdAt: DateTime.now().subtract(const Duration(days: 30)),
    ),
    Transaction(
      id: 'txn_2',
      userId: 'user_123',
      type: TransactionType.debit,
      tokens: 30,
      amount: 0.0,
      description: 'Call with Aashna',
      createdAt: DateTime.now().subtract(const Duration(days: 1, hours: 2)),
    ),
    Transaction(
      id: 'txn_3',
      userId: 'user_123',
      type: TransactionType.debit,
      tokens: 27,
      amount: 0.0,
      description: 'Call with Mike Chen',
      createdAt: DateTime.now().subtract(const Duration(days: 2, hours: 3)),
    ),
    Transaction(
      id: 'txn_4',
      userId: 'user_123',
      type: TransactionType.credit,
      tokens: 50,
      amount: 4.99,
      description: 'Token purchase',
      createdAt: DateTime.now().subtract(const Duration(days: 5)),
    ),
    Transaction(
      id: 'txn_5',
      userId: 'user_123',
      type: TransactionType.debit,
      tokens: 12,
      amount: 0.0,
      description: 'Call with Emma Davis',
      createdAt: DateTime.now().subtract(const Duration(days: 7)),
    ),
    Transaction(
      id: 'txn_6',
      userId: 'user_123',
      type: TransactionType.credit,
      tokens: 25,
      amount: 2.99,
      description: 'Referral bonus',
      createdAt: DateTime.now().subtract(const Duration(days: 10)),
    ),
  ];

  Future<int> getBalance() async {
    // Simulate API call delay
    await Future.delayed(const Duration(milliseconds: 400));
    
    return _currentBalance;
  }

  Future<List<Transaction>> getTransactions() async {
    // Simulate API call delay
    await Future.delayed(const Duration(milliseconds: 600));
    
    // Return transactions sorted by date (newest first)
    final sortedTransactions = List<Transaction>.from(_mockTransactions)
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    
    return sortedTransactions;
  }

  Future<Transaction> purchaseTokens(int tokens, double amount) async {
    // Simulate API call delay
    await Future.delayed(const Duration(seconds: 1));
    
    final newTransaction = Transaction(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      userId: 'user_123',
      type: TransactionType.credit,
      tokens: tokens,
      amount: amount,
      description: 'Token purchase - $tokens tokens',
      createdAt: DateTime.now(),
    );

    // Update balance and add transaction
    _currentBalance += tokens;
    _mockTransactions.add(newTransaction);
    
    return newTransaction;
  }

  Future<Transaction> deductTokens(int tokens, String description) async {
    // Simulate API call delay
    await Future.delayed(const Duration(milliseconds: 300));
    
    if (_currentBalance >= tokens) {
      final newTransaction = Transaction(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        userId: 'user_123',
        type: TransactionType.debit,
        tokens: tokens,
        amount: 0.0,
        description: description,
        createdAt: DateTime.now(),
      );

      // Update balance and add transaction
      _currentBalance -= tokens;
      _mockTransactions.add(newTransaction);
      
      return newTransaction;
    } else {
      throw Exception('Insufficient balance');
    }
  }

  Future<List<Transaction>> getTransactionsByType(TransactionType type) async {
    // Simulate API call delay
    await Future.delayed(const Duration(milliseconds: 400));
    
    return _mockTransactions
        .where((transaction) => transaction.type == type)
        .toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  Future<void> addBonusTokens(int tokens, String reason) async {
    // Simulate API call delay
    await Future.delayed(const Duration(milliseconds: 300));
    
    final bonusTransaction = Transaction(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      userId: 'user_123',
      type: TransactionType.credit,
      tokens: tokens,
      amount: 0.0,
      description: reason,
      createdAt: DateTime.now(),
    );

    // Update balance and add transaction
    _currentBalance += tokens;
    _mockTransactions.add(bonusTransaction);
  }

  Future<Map<String, dynamic>> getTokenPackages() async {
    // Simulate API call delay
    await Future.delayed(const Duration(milliseconds: 200));
    
    return {
      'packages': [
        {
          'id': 'basic',
          'tokens': 50,
          'price': 4.99,
          'bonus': 0,
          'popular': false,
        },
        {
          'id': 'standard',
          'tokens': 100,
          'price': 9.99,
          'bonus': 10,
          'popular': false,
        },
        {
          'id': 'premium',
          'tokens': 200,
          'price': 19.99,
          'bonus': 25,
          'popular': true,
        },
        {
          'id': 'enterprise',
          'tokens': 500,
          'price': 49.99,
          'bonus': 75,
          'popular': false,
        },
      ],
    };
  }
}
