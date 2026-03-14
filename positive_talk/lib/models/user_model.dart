class User {
  final String id;
  final String name;
  final String phoneNumber;
  final String profileImage;
  final String referralCode;
  final int tokenBalance;
  final DateTime createdAt;

  const User({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.profileImage,
    required this.referralCode,
    required this.tokenBalance,
    required this.createdAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      name: json['name'] as String,
      phoneNumber: json['phoneNumber'] as String,
      profileImage: json['profileImage'] as String,
      referralCode: json['referralCode'] as String,
      tokenBalance: json['tokenBalance'] as int,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phoneNumber': phoneNumber,
      'profileImage': profileImage,
      'referralCode': referralCode,
      'tokenBalance': tokenBalance,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
