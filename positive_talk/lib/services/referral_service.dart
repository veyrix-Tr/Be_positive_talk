import '../models/referral_model.dart';

class ReferralService {
  static final ReferralService _instance = ReferralService._internal();
  factory ReferralService() => _instance;
  ReferralService._internal();

  // Mock referral data
  final List<Referral> _mockReferrals = [
    Referral(
      id: '1',
      referrerUserId: 'user1',
      referredUserId: 'user2',
      rewardTokens: 50,
      status: ReferralStatus.completed,
      createdAt: DateTime.now().subtract(const Duration(days: 15)),
    ),
    Referral(
      id: '2',
      referrerUserId: 'user1',
      referredUserId: 'user3',
      rewardTokens: 50,
      status: ReferralStatus.pending,
      createdAt: DateTime.now().subtract(const Duration(days: 5)),
    ),
  ];

  // Mock user referral code
  final String _referralCode = 'JOHN2024';

  // Get referral code
  Future<String> getReferralCode() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 300));

    return _referralCode;
  }

  // Apply referral code
  Future<bool> applyReferralCode(String referralCode) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    // Mock validation - accept codes that are 8 characters long
    if (referralCode.length == 8 && referralCode.toUpperCase() == referralCode) {
      // Create a new referral record
      final newReferral = Referral(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        referrerUserId: 'unknown', // Would be determined by backend
        referredUserId: 'user1',
        rewardTokens: 25,
        status: ReferralStatus.pending,
        createdAt: DateTime.now(),
      );

      _mockReferrals.add(newReferral);
      return true;
    }

    return false;
  }

  // Get referral history
  Future<List<Referral>> getReferralHistory() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    return _mockReferrals;
  }

  // Get referral stats
  Future<Map<String, dynamic>> getReferralStats() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 400));

    final completedReferrals = _mockReferrals.where((r) => r.status == ReferralStatus.completed).length;
    final pendingReferrals = _mockReferrals.where((r) => r.status == ReferralStatus.pending).length;
    final totalRewards = _mockReferrals
        .where((r) => r.status == ReferralStatus.completed)
        .fold<int>(0, (sum, referral) => sum + referral.rewardTokens);

    return {
      'totalReferrals': _mockReferrals.length,
      'completedReferrals': completedReferrals,
      'pendingReferrals': pendingReferrals,
      'totalRewards': totalRewards,
      'referralCode': _referralCode,
    };
  }
}
