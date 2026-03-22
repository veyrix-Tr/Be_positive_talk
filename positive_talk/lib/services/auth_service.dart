import '../models/user_model.dart';
import '../core/api/api_client.dart';
import '../core/storage/token_storage.dart';

class AuthService {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  User? _currentUser;

  // Send OTP
  Future<Map<String, dynamic>> sendOTP(String phoneNumber) async {
    try {
      final apiClient = ApiClient();
      final response = await apiClient.post(
        '/auth/send-otp',
        body: {'phoneNumber': phoneNumber},
      );

      return apiClient.handleResponse(response);
    } catch (e) {
      throw Exception('Failed to send OTP: $e');
    }
  }

  // Verify OTP and login
  Future<User> verifyOTP(
    String phoneNumber,
    String otp, {
    String? referralCode,
  }) async {
    try {
      final apiClient = ApiClient();
      final response = await apiClient.post(
        '/auth/verify-otp',
        body: {
          'phoneNumber': phoneNumber,
          'otp': otp,
          if (referralCode != null) 'referralCode': referralCode,
        },
      );

      final data = apiClient.handleResponse(response);

      // Store token
      if (data['token'] != null) {
        await TokenStorage.saveToken(data['token'] as String);
      }

      // Parse and store user
      if (data['user'] != null) {
        _currentUser = User.fromJson(data['user']!);
      }

      return _currentUser!;
    } catch (e) {
      throw Exception('Failed to verify OTP: $e');
    }
  }

  // Logout
  Future<void> logout() async {
    try {
      await TokenStorage.clearToken();
      _currentUser = null;
    } catch (e) {
      throw Exception('Failed to logout: $e');
    }
  }

  // Get current user
  Future<User?> getCurrentUser() async {
    if (_currentUser != null) return _currentUser;

    // Try to get user from token (for app restart)
    final hasToken = await TokenStorage.hasToken();
    if (!hasToken) return null;

    // In a real app, you might want to validate the token with the server
    // For now, we'll return null and let the app handle re-authentication
    return null;
  }

  // Check if user is authenticated
  bool get isAuthenticated => _currentUser != null;
}
