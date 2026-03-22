import '../models/transaction_model.dart';
import '../core/api/api_client.dart';

class WalletService {
  static final WalletService _instance = WalletService._internal();
  factory WalletService() => _instance;
  WalletService._internal();

  // Get current balance
  Future<int> getBalance() async {
    try {
      final apiClient = ApiClient();
      final response = await apiClient.get('/wallet', requireAuth: true);

      final data = apiClient.handleResponse(response);
      return data['balance'] as int;
    } catch (e) {
      throw Exception('Failed to load balance: $e');
    }
  }

  // Get transaction history
  Future<List<Transaction>> getTransactions() async {
    try {
      final apiClient = ApiClient();
      final response = await apiClient.get(
        '/wallet/transactions',
        requireAuth: true,
      );

      final transactionsData = apiClient.handleListResponse(response);
      return transactionsData
          .map((json) => Transaction.fromJson(json))
          .toList();
    } catch (e) {
      throw Exception('Failed to load transactions: $e');
    }
  }

  // Purchase tokens (add tokens to wallet)
  Future<Map<String, dynamic>> purchaseTokens(int tokens, double amount) async {
    try {
      final apiClient = ApiClient();
      final response = await apiClient.post(
        '/wallet/add-tokens',
        requireAuth: true,
        body: {'tokens': tokens, 'amount': amount},
      );

      return apiClient.handleResponse(response);
    } catch (e) {
      throw Exception('Failed to purchase tokens: $e');
    }
  }

  // Get token packages
  Future<Map<String, dynamic>> getTokenPackages() async {
    try {
      // For now, return hardcoded packages (can be moved to backend later)
      await Future.delayed(const Duration(milliseconds: 300));

      return {
        'packages': [
          {'tokens': 50, 'price': 5, 'popularBadge': null},
          {'tokens': 100, 'price': 9, 'popularBadge': 'Popular'},
          {'tokens': 200, 'price': 16, 'popularBadge': 'Best Value'},
          {'tokens': 500, 'price': 35, 'popularBadge': null},
        ],
      };
    } catch (e) {
      throw Exception('Failed to load token packages: $e');
    }
  }
}
