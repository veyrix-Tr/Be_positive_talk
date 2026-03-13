import 'dart:async';
import '../models/referral_model.dart';

class ReferralService {
  static final ReferralService _instance = ReferralService._internal();
  factory ReferralService() => _instance;
  ReferralService._internal();

  // Mock current user's referral code
  final String _currentUserReferralCode = 'JOHN123';

  // Mock referral history
  final List<Referral> _mockReferrals = [
    Referral(
      id: 'ref_1',
      referrerUserId: 'user_456',
      referredUserId: 'user_123',
      rewardTokens: 25,
      status: ReferralStatus.completed,
      createdAt: DateTime.now().subtract(const Duration(days: 15)),
    ),
    Referral(
      id: 'ref_2',
      referrerUserId: 'user_123',
      referredUserId: 'user_789',
      rewardTokens: 25,
      status: ReferralStatus.pending,
      createdAt: DateTime.now().subtract(const Duration(days: 5)),
    ),
    Referral(
      id: 'ref_3',
      referrerUserId: 'user_123',
      referredUserId: 'user_101',
      rewardTokens: 25,
      status: ReferralStatus.completed,
      createdAt: DateTime.now().subtract(const Duration(days: 20)),
    ),
  ];

  Future<String> getReferralCode() async {
    // Simulate API call delay
    await Future.delayed(const Duration(milliseconds: 300));
    
    return _currentUserReferralCode;
  }

  Future<Referral> applyReferralCode(String referralCode) async {
    // Simulate API call delay
    await Future.delayed(const Duration(seconds: 1));
    
    // Mock referral validation
    if (referralCode == 'SARAH456' || referralCode == 'MIKE789') {
      final newReferral = Referral(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        referrerUserId: 'unknown', // Would come from API
        referredUserId: 'user_123',
        rewardTokens: 25,
        status: ReferralStatus.completed,
        createdAt: DateTime.now(),
      );

      _mockReferrals.add(newReferral);
      return newReferral;
    } else {
      throw Exception('Invalid referral code');
    }
  }

  Future<List<Referral>> getReferralHistory() async {
    // Simulate API call delay
    await Future.delayed(const Duration(milliseconds: 600));
    
    // Return referrals sorted by date (newest first)
    final sortedReferrals = List<Referral>.from(_mockReferrals)
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    
    return sortedReferrals;
  }

  Future<Map<String, dynamic>> getReferralStats() async {
    // Simulate API call delay
    await Future.delayed(const Duration(milliseconds: 400));
    
    final completedReferrals = _mockReferrals
        .where((referral) => referral.status == ReferralStatus.completed)
        .length;
    
    final pendingReferrals = _mockReferrals
        .where((referral) => referral.status == ReferralStatus.pending)
        .length;
    
    final totalRewards = _mockReferrals
        .where((referral) => referral.status == ReferralStatus.completed)
        .fold<int>(0, (sum, referral) => sum + referral.rewardTokens);

    return {
      'totalReferrals': _mockReferrals.length,
      'completedReferrals': completedReferrals,
      'pendingReferrals': pendingReferrals,
      'totalRewards': totalRewards,
      'nextRewardThreshold': 5, // Mock: bonus after 5 successful referrals
    };
  }

  Future<String> generateReferralLink() async {
    // Simulate API call delay
    await Future.delayed(const Duration(milliseconds: 200));
    
    // Mock referral link generation
    return 'https://positive-talk.app/referral?code=$_currentUserReferralCode';
  }

  Future<void> shareReferralCode() async {
    // Simulate API call delay
    await Future.delayed(const Duration(milliseconds: 300));
    
    // Mock share functionality - would integrate with platform-specific share
    // For now, just return the code for manual sharing
    // In real app, would use: share_plus package
  }

  Future<bool> validateReferralCode(String referralCode) async {
    // Simulate API call delay
    await Future.delayed(const Duration(milliseconds: 500));
    
    // Mock validation logic
    final validCodes = ['SARAH456', 'MIKE789', 'EMMA123', 'LISA456'];
    return validCodes.contains(referralCode);
  }

  Future<Map<String, dynamic>> getReferralProgramInfo() async {
    // Simulate API call delay
    await Future.delayed(const Duration(milliseconds: 300));
    
    return {
      'rewardTokens': 25,
      'minReferralAge': 7, // days
      'maxReferralsPerMonth': 10,
      'bonusThreshold': 5, // bonus after X successful referrals
      'bonusReward': 50, // extra tokens for reaching threshold
      'terms': 'Referral rewards are credited after referred user completes first purchase.',
    };
  }
}
