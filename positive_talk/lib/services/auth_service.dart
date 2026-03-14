import '../models/user_model.dart';

class AuthService {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  User? _currentUser;

  // Mock user data
  final User _mockUser = User(
    id: '1',
    name: 'John Doe',
    phoneNumber: '+1234567890',
    profileImage: 'assets/profile1.png',
    referralCode: 'JOHN2024',
    tokenBalance: 150,
    createdAt: DateTime.now().subtract(const Duration(days: 30)),
  );

  // Login with phone number
  Future<void> loginWithPhone(String phoneNumber) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    // Mock successful login
    _currentUser = _mockUser;
  }

  // Verify OTP
  Future<bool> verifyOTP(String otp) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    // Mock OTP verification - accept any 6 digit code
    if (otp.length == 6 && int.tryParse(otp) != null) {
      return true;
    }
    return false;
  }

  // Logout
  Future<void> logout() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    _currentUser = null;
  }

  // Get current user
  Future<User?> getCurrentUser() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 200));

    return _currentUser;
  }

  // Check if user is authenticated
  bool get isAuthenticated => _currentUser != null;
}
