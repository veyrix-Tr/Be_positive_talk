enum ReferralStatus {
  pending,
  completed,
  failed,
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
        (status) => status.name == json['status'],
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
      'status': status.name,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  Referral copyWith({
    String? id,
    String? referrerUserId,
    String? referredUserId,
    int? rewardTokens,
    ReferralStatus? status,
    DateTime? createdAt,
  }) {
    return Referral(
      id: id ?? this.id,
      referrerUserId: referrerUserId ?? this.referrerUserId,
      referredUserId: referredUserId ?? this.referredUserId,
      rewardTokens: rewardTokens ?? this.rewardTokens,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Referral &&
        other.id == id &&
        other.referrerUserId == referrerUserId &&
        other.referredUserId == referredUserId &&
        other.rewardTokens == rewardTokens &&
        other.status == status &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        referrerUserId.hashCode ^
        referredUserId.hashCode ^
        rewardTokens.hashCode ^
        status.hashCode ^
        createdAt.hashCode;
  }

  @override
  String toString() {
    return 'Referral(id: $id, referrerUserId: $referrerUserId, referredUserId: $referredUserId, rewardTokens: $rewardTokens, status: $status, createdAt: $createdAt)';
  }
}
