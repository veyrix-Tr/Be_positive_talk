import '../models/transaction_model.dart';

class WalletService {
  static final WalletService _instance = WalletService._internal();
  factory WalletService() => _instance;
  WalletService._internal();

  // Mock balance
  int _currentBalance = 150;

  // Mock transactions
  final List<Transaction> _mockTransactions = [
    Transaction(
      id: '1',
      userId: 'user1',
      type: TransactionType.credit,
      tokens: 100,
      amount: 10.0,
      description: 'Initial token purchase',
      createdAt: DateTime.now().subtract(const Duration(days: 30)),
    ),
    Transaction(
      id: '2',
      userId: 'user1',
      type: TransactionType.debit,
      tokens: 75,
      amount: 7.5,
      description: 'Call with Aashna',
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
    ),
    Transaction(
      id: '3',
      userId: 'user1',
      type: TransactionType.debit,
      tokens: 80,
      amount: 8.0,
      description: 'Call with Priya',
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
    Transaction(
      id: '4',
      userId: 'user1',
      type: TransactionType.credit,
      tokens: 50,
      amount: 5.0,
      description: 'Referral bonus',
      createdAt: DateTime.now().subtract(const Duration(hours: 3)),
    ),
    Transaction(
      id: '5',
      userId: 'user1',
      type: TransactionType.debit,
      tokens: 30,
      amount: 3.0,
      description: 'Call with Rajesh',
      createdAt: DateTime.now().subtract(const Duration(hours: 3)),
    ),
  ];

  // Get current balance
  Future<int> getBalance() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 400));

    return _currentBalance;
  }

  // Get transaction history
  Future<List<Transaction>> getTransactions() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 600));

    return _mockTransactions;
  }

  // Purchase tokens
  Future<Transaction> purchaseTokens(int tokens, double amount) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    final newTransaction = Transaction(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      userId: 'user1',
      type: TransactionType.credit,
      tokens: tokens,
      amount: amount,
      description: 'Token purchase',
      createdAt: DateTime.now(),
    );

    // Update balance
    _currentBalance += tokens;

    // Add to transactions
    _mockTransactions.insert(0, newTransaction);

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
