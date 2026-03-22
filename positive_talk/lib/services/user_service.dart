import '../models/user_model.dart';
import '../core/api/api_client.dart';

class UserService {
  static final UserService _instance = UserService._internal();
  factory UserService() => _instance;
  UserService._internal();

  User? _currentUser;

  // Get current user from API
  Future<User?> getCurrentUser() async {
    if (_currentUser != null) return _currentUser;

    try {
      final apiClient = ApiClient();
      final response = await apiClient.get('/user/profile', requireAuth: true);

      final userData = apiClient.handleResponse(response);
      _currentUser = User.fromJson(userData['user']!);
      return _currentUser!;
    } catch (e) {
      throw Exception('Failed to load user profile: $e');
    }
  }

  // Update user profile
  Future<User> updateProfile({
    String? name,
    String? phoneNumber,
    String? profileImage,
  }) async {
    try {
      final apiClient = ApiClient();
      final response = await apiClient.put(
        '/user/profile',
        requireAuth: true,
        body: {
          if (name != null) 'name': name,
          if (phoneNumber != null) 'phoneNumber': phoneNumber,
          if (profileImage != null) 'profileImage': profileImage,
        },
      );

      final userData = apiClient.handleResponse(response);
      _currentUser = User.fromJson(userData['user']!);
      return _currentUser!;
    } catch (e) {
      throw Exception('Failed to update profile: $e');
    }
  }

  // Get user by ID
  Future<User?> getUserById(String userId) async {
    try {
      // For now, return current user if ID matches
      final currentUser = await getCurrentUser();
      if (currentUser != null && currentUser.id == userId) {
        return currentUser;
      }
      return null;
    } catch (e) {
      throw Exception('Failed to load user: $e');
    }
  }

  // Update token balance
  Future<void> updateTokenBalance(int newBalance) async {
    // This would typically be handled by the backend when transactions occur
    // For now, we'll update the local user object
    if (_currentUser != null) {
      _currentUser = User(
        id: _currentUser!.id,
        name: _currentUser!.name,
        phoneNumber: _currentUser!.phoneNumber,
        profileImage: _currentUser!.profileImage,
        referralCode: _currentUser!.referralCode,
        tokenBalance: newBalance,
        createdAt: _currentUser!.createdAt,
      );
    }
  }

  // Get referral code
  Future<String> getReferralCode() async {
    try {
      final apiClient = ApiClient();
      final response = await apiClient.get(
        '/user/referral-code',
        requireAuth: true,
      );

      final data = apiClient.handleResponse(response);
      return data['referralCode'] as String;
    } catch (e) {
      throw Exception('Failed to load referral code: $e');
    }
  }

  // Save device token for notifications
  Future<void> saveDeviceToken(String deviceToken) async {
    try {
      final apiClient = ApiClient();
      await apiClient.post(
        '/user/device-token',
        requireAuth: true,
        body: {'deviceToken': deviceToken},
      );
    } catch (e) {
      throw Exception('Failed to save device token: $e');
    }
  }
}
