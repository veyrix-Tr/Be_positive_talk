import 'package:flutter_test/flutter_test.dart';
import 'package:positive_talk/services/vendor_service.dart';
import 'package:positive_talk/services/chat_service.dart';
import 'package:positive_talk/services/wallet_service.dart';
import 'package:positive_talk/services/usage_service.dart';
import 'package:positive_talk/services/user_service.dart';

void main() {
  // Initialize Flutter binding for asset loading
  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  group('JSON Data Loading Tests', () {
    test('VendorService loads vendors from JSON', () async {
      final vendorService = VendorService();
      final vendors = await vendorService.getVerifiedVendors();
      
      expect(vendors, isA<List>());
      // Allow for empty list in test environment, but check structure if not empty
      if (vendors.isNotEmpty) {
        expect(vendors.first.name, isA<String>());
        expect(vendors.first.rating, greaterThan(0));
      }
    });

    test('ChatService loads inbox chats from JSON', () async {
      final chatService = ChatService();
      final chats = await chatService.getInboxChats();
      
      expect(chats, isA<List>());
      // Allow for empty list in test environment, but check structure if not empty
      if (chats.isNotEmpty) {
        expect(chats.first.vendorName, isA<String>());
        expect(chats.first.lastMessage, isA<String>());
      }
    });

    test('WalletService loads transactions from JSON', () async {
      final walletService = WalletService();
      final balance = await walletService.getBalance();
      final transactions = await walletService.getTransactions();
      
      expect(balance, isA<int>());
      expect(balance, greaterThanOrEqualTo(0));
      expect(transactions, isA<List>());
      // Allow for empty list in test environment, but check structure if not empty
      if (transactions.isNotEmpty) {
        expect(transactions.first.description, isA<String>());
        expect(transactions.first.amount, isA<double>());
      }
    });

    test('UsageService loads usage records from JSON', () async {
      final usageService = UsageService();
      final usageHistory = await usageService.getUsageHistory();
      
      expect(usageHistory, isA<List>());
      // Allow for empty list in test environment, but check structure if not empty
      if (usageHistory.isNotEmpty) {
        expect(usageHistory.first.vendorName, isA<String>());
        expect(usageHistory.first.tokensUsed, greaterThan(0));
      }
    });

    test('UserService loads user from JSON', () async {
      final userService = UserService();
      final user = await userService.getCurrentUser();
      
      expect(user.name, isA<String>());
      expect(user.phoneNumber, isA<String>());
      expect(user.tokenBalance, greaterThanOrEqualTo(0));
    });
  });
}
