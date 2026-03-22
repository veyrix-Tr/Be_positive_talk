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
    try {
      print('DEBUG: Parsing User from JSON: $json');

      return User(
        id: json['_id']?.toString() ?? json['id']?.toString() ?? '',
        name: json['name']?.toString() ?? 'Unknown User',
        phoneNumber: json['phoneNumber']?.toString() ?? '',
        profileImage: json['profileImage']?.toString() ?? '',
        referralCode: json['referralCode']?.toString() ?? '',
        tokenBalance: (json['tokenBalance'] as num?)?.toInt() ?? 0,
        createdAt: json['createdAt'] != null
            ? DateTime.parse(json['createdAt'] as String)
            : DateTime.now(),
      );
    } catch (e) {
      print('DEBUG: Error parsing User JSON: $e');
      print('DEBUG: JSON data was: $json');
      rethrow;
    }
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
