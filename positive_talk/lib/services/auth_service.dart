import 'dart:async';
import '../models/user_model.dart';

class AuthService {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  // Mock current user
  User? _currentUser;

  Future<User> loginWithPhone(String phoneNumber) async {
    // Simulate API call delay
    await Future.delayed(const Duration(seconds: 1));
    
    // Mock user data
    final mockUser = User(
      id: 'user_123',
      name: 'John Doe',
      phoneNumber: phoneNumber,
      profileImage: 'assets/profile1.png',
      referralCode: 'JOHN123',
      tokenBalance: 100,
      createdAt: DateTime.now(),
    );

    _currentUser = mockUser;
    return mockUser;
  }

  Future<bool> verifyOTP(String otp) async {
    // Simulate API call delay
    await Future.delayed(const Duration(seconds: 1));
    
    // Mock OTP verification - always succeeds for demo
    return otp == '123456';
  }

  Future<void> logout() async {
    // Simulate API call delay
    await Future.delayed(const Duration(milliseconds: 500));
    
    _currentUser = null;
  }

  User? getCurrentUser() {
    return _currentUser;
  }

  Future<User> refreshCurrentUser() async {
    // Simulate API call delay
    await Future.delayed(const Duration(milliseconds: 500));
    
    if (_currentUser != null) {
      // Return updated mock user
      _currentUser = User(
        id: _currentUser!.id,
        name: _currentUser!.name,
        phoneNumber: _currentUser!.phoneNumber,
        profileImage: _currentUser!.profileImage,
        referralCode: _currentUser!.referralCode,
        tokenBalance: _currentUser!.tokenBalance + 10, // Mock bonus
        createdAt: _currentUser!.createdAt,
      );
    }
    
    return _currentUser!;
  }
}
