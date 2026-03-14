enum ReferralStatus {
  pending,
  completed,
  expired,
}

class Referral {
  final String id;
  final String referrerUserId;
  final String referredUserId;
  final int rewardTokens;
  final ReferralStatus status;
  final DateTime createdAt;

  const Referral({
    required this.id,
    required this.referrerUserId,
    required this.referredUserId,
    required this.rewardTokens,
    required this.status,
    required this.createdAt,
  });

  factory Referral.fromJson(Map<String, dynamic> json) {
    return Referral(
      id: json['id'] as String,
      referrerUserId: json['referrerUserId'] as String,
      referredUserId: json['referredUserId'] as String,
      rewardTokens: json['rewardTokens'] as int,
      status: ReferralStatus.values.firstWhere(
        (status) => status.toString() == json['status'] as String,
        orElse: () => ReferralStatus.pending,
      ),
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'referrerUserId': referrerUserId,
      'referredUserId': referredUserId,
      'rewardTokens': rewardTokens,
      'status': status.toString(),
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
