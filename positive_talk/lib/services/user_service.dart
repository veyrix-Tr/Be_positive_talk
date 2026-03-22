import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/user_model.dart';

class UserService {
  static final UserService _instance = UserService._internal();
  factory UserService() => _instance;
  UserService._internal();

  User? _currentUser;

  // Load user from JSON file
  Future<void> _loadUser() async {
    if (_currentUser != null) return;

    try {
      final String jsonString = await rootBundle.loadString(
        'assets/data/users.json',
      );
      final Map<String, dynamic> data = json.decode(jsonString);
      final List<dynamic> usersList = data['users'];

      // Get the first user as current user (for demo purposes)
      final userJson = usersList.first;
      _currentUser = User.fromJson(userJson);
    } catch (e) {
      // Fallback to default user if JSON loading fails
      _currentUser = User(
        id: 'user_001',
        name: 'Alex Johnson',
        phoneNumber: '+1234567890',
        profileImage: 'assets/profile1.png',
        referralCode: 'ALEX123',
        tokenBalance: 150,
        createdAt: DateTime.now(),
      );
    }
  }

  // Get current user
  Future<User> getCurrentUser() async {
    await _loadUser();

    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 300));

    return _currentUser!;
  }

  // Update user profile
  Future<User> updateProfile({
    String? name,
    String? phoneNumber,
    String? profileImage,
  }) async {
    await _loadUser();

    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    _currentUser = User(
      id: _currentUser!.id,
      name: name ?? _currentUser!.name,
      phoneNumber: phoneNumber ?? _currentUser!.phoneNumber,
      profileImage: profileImage ?? _currentUser!.profileImage,
      referralCode: _currentUser!.referralCode,
      tokenBalance: _currentUser!.tokenBalance,
      createdAt: _currentUser!.createdAt,
    );

    return _currentUser!;
  }

  // Get user by ID
  Future<User?> getUserById(String userId) async {
    await _loadUser();

    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 400));

    // For now, only return current user if ID matches
    if (_currentUser!.id == userId) {
      return _currentUser;
    }
    return null;
  }

  // Update token balance
  Future<void> updateTokenBalance(int newBalance) async {
    await _loadUser();

    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 300));

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
